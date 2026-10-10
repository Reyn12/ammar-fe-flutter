import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/models/login_result_model.dart';
import '../../features/auth/storage/auth_storage.dart';
import '../../routes/app_paths.dart';
import '../../routes/root_navigator.dart';
import 'converter.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.dio, {AuthStorage? storage})
    : storage = storage ?? AuthStorage();

  final Dio dio;
  final AuthStorage storage;

  static void Function()? onSessionExpired;

  static const retriedExtraKey = 'retriedAfterRefresh';

  Future<void>? refreshInFlight;
  var isSessionExpiring = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await storage.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        final tokenType = await storage.getTokenType();
        options.headers['Authorization'] =
            '${tokenType ?? 'Bearer'} $accessToken';
      }
    } catch (_) {}

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    if (shouldSkipRefresh(err.requestOptions)) {
      return handler.next(err);
    }

    if (err.requestOptions.extra[retriedExtraKey] == true) {
      await expireSession();
      return handler.next(err);
    }

    try {
      await refreshTokens();
      handler.resolve(await retry(err.requestOptions));
    } catch (_) {
      await expireSession();
      handler.next(err);
    }
  }

  bool shouldSkipRefresh(RequestOptions options) {
    final path = options.path;
    // Backend tidak punya refresh token: 401 selalu berarti sesi habis -> login ulang.
    return path.contains('/v1/auth/login') || path.contains('/auth/refresh');
  }

  Future<void> refreshTokens() async {
    final inFlight = refreshInFlight;
    if (inFlight != null) {
      await inFlight;
      return;
    }

    final future = requestNewTokens();
    refreshInFlight = future;

    try {
      await future;
    } finally {
      if (identical(refreshInFlight, future)) {
        refreshInFlight = null;
      }
    }
  }

  Future<void> requestNewTokens() async {
    final refreshToken = await storage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw StateError('missing refresh token');
    }

    final refreshDio = Dio(
      BaseOptions(
        baseUrl: dio.options.baseUrl,
        connectTimeout: dio.options.connectTimeout,
        receiveTimeout: dio.options.receiveTimeout,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    final res = await refreshDio.post(
      '/api/auth/refresh',
      data: {'refresh_token': refreshToken},
    );

    if (res.statusCode == 401) {
      throw StateError('unauthorized refresh');
    }

    await storage.saveLogin(
      Converter.single(res.data, LoginResultModel.fromJson),
    );
  }

  Future<Response<dynamic>> retry(RequestOptions options) {
    options.extra[retriedExtraKey] = true;
    return dio.fetch(options);
  }

  Future<void> expireSession() async {
    if (isSessionExpiring) return;
    isSessionExpiring = true;

    try {
      await storage.clear();
      onSessionExpired?.call();

      final context = rootNavigatorKey.currentContext;
      if (context != null && context.mounted) {
        context.go(AppPaths.login);
      }
    } finally {
      isSessionExpiring = false;
    }
  }
}
