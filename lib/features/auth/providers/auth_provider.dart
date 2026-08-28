import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/api/auth_interceptor.dart';
import '../../../network/api_service.dart';
import '../models/auth_type.dart';
import '../models/login_result_model.dart';
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

  // Future<void> logout() async {
  //   final refreshToken = await AuthStorage().getRefreshToken();
  //   await ref.read(apiServiceProvider).logout(refreshToken: refreshToken);
  //   await AuthStorage().clear();
  //   state = AuthType.UNAUTHENTICATED;
  // }
}

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<LoginResultModel?> build() => null;

  // Future<void> login({
  //   required String identifier,
  //   required String password,
  // }) async {
  //   state = const AsyncLoading();
  //   state = await AsyncValue.guard(() async {
  //     final result = await ref
  //         .read(apiServiceProvider)
  //         .login(identifier: identifier, password: password);
  //     await AuthStorage().saveLogin(result);
  //     ref.read(authProvider.notifier).setAuthType(AuthType.AUTHENTICATED);
  //     return result;
  //   });
  // }

  Future<void> loginWithSSO() async {
    // TODO: implement SSO login
  }
}
