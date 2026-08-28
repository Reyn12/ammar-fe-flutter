import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api/auth_interceptor.dart';
import 'environment.dart';

part 'dio_client_provider.g.dart';

@riverpod
Dio dioClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: switch (appMode) {
        AppEnvironment.localMockoon => localBaseUrl,
        AppEnvironment.staging => stagingBaseUrl,
        AppEnvironment.production => productionBaseUrl,
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
  dio.interceptors.add(AuthInterceptor(dio));
  return dio;
}
