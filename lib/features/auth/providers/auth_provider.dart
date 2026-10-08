import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/api/auth_interceptor.dart';
import '../../../network/api_service.dart';
import '../../../network/environment.dart';
import '../../kasir/providers/cashier_accounts_provider.dart';
import '../../kasir/providers/owner_auth_provider.dart';
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
    try {
      await ref.read(apiServiceProvider).logout();
    } catch (_) {
      // Tetap clear lokal meskipun logout API gagal.
    }
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
      final LoginResultModel result;

      if (mockStatus) {
        // Mock: pakai daftar kasir lokal + password owner yang bisa diganti.
        await Future<void>.delayed(const Duration(milliseconds: 900));
        final user = _resolveMockUser(username: username, password: password);
        if (user == null) {
          throw Exception(
            'Username atau password salah. '
            'Coba owner/123456, kasir/123456, atau dapur/123456.',
          );
        }
        result = LoginResultModel(
          token: const AuthTokenModel(
            accessToken: 'mock-access-token',
            refreshToken: 'mock-refresh-token',
            tokenType: 'Bearer',
            expiresIn: 3600,
          ),
          user: user,
        );
      } else {
        result = await ref
            .read(apiServiceProvider)
            .login(username: username, password: password);
      }

      await AuthStorage().saveLogin(result);
      ref.read(sessionProvider.notifier).setUser(result.user);
      ref.read(authProvider.notifier).setAuthType(AuthType.AUTHENTICATED);

      return result;
    });
  }

  UserModel? _resolveMockUser({
    required String username,
    required String password,
  }) {
    final normalized = username.trim().toLowerCase();

    if (normalized == UserMocks.demoOwnerUsername) {
      if (password != ref.read(ownerAuthProvider)) return null;
      return UserMocks.owner;
    }

    if (normalized == UserMocks.demoKitchenUsername) {
      if (password != UserMocks.demoPassword) return null;
      return UserMocks.kitchen;
    }

    for (final cashier in ref.read(cashierAccountsProvider)) {
      if (cashier.username.toLowerCase() != normalized) continue;
      if (!cashier.isActive) return null;
      if (cashier.password != password) return null;
      return UserMocks.cashierFromAccount(
        id: cashier.id,
        name: cashier.name,
        username: cashier.username,
      );
    }

    return null;
  }
}
