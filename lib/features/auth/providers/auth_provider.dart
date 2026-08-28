import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/api/auth_interceptor.dart';
import '../mocks/user_mocks.dart';
import '../models/auth_token_model.dart';
import '../models/auth_type.dart';
import '../models/login_result_model.dart';
import '../models/user_model.dart';
import '../storage/auth_storage.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  AuthType build() {
    AuthInterceptor.onSessionExpired = () {
      state = AuthType.UNAUTHENTICATED;
    };
    return AuthType.INITIAL;
  }

  Future<AuthType> checkToken() async {
    state = AuthType.LOAD;

    if (await AuthStorage().hasToken()) {
      state = AuthType.AUTHENTICATED;
      return AuthType.AUTHENTICATED;
    }

    state = AuthType.UNAUTHENTICATED;
    return AuthType.UNAUTHENTICATED;
  }

  void setAuthType(AuthType type) => state = type;

  Future<void> logout() async {
    // TODO: panggil POST /v1/auth/logout sebelum clear storage.
    await AuthStorage().clear();
    ref.read(sessionProvider.notifier).clear();
    state = AuthType.UNAUTHENTICATED;
  }
}

/// User yang sedang login, dipakai header & sidebar.
@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  UserModel? build() => null;

  void setUser(UserModel? user) => state = user;

  void clear() => state = null;
}

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<LoginResultModel?> build() => null;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // TODO: ganti mock ini dengan POST /v1/auth/login.
      await Future<void>.delayed(const Duration(milliseconds: 900));

      if (!UserMocks.isValidLogin(username, password)) {
        throw Exception(
          'Username atau password salah. Coba kasir/123456 atau dapur/123456.',
        );
      }

      final result = LoginResultModel(
        token: const AuthTokenModel(
          accessToken: 'mock-access-token',
          refreshToken: 'mock-refresh-token',
          tokenType: 'Bearer',
          expiresIn: 3600,
        ),
        user: UserMocks.userForLogin(username),
      );

      await AuthStorage().saveLogin(result);
      ref.read(sessionProvider.notifier).setUser(result.user);
      ref.read(authProvider.notifier).setAuthType(AuthType.AUTHENTICATED);

      return result;
    });
  }
}
