// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Auth)
final authProvider = AuthProvider._();

final class AuthProvider extends $NotifierProvider<Auth, AuthType> {
  AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthType>(value),
    );
  }
}

String _$authHash() => r'79d118bf01390bdda8d6edd6404e145647f3e5eb';

abstract class _$Auth extends $Notifier<AuthType> {
  AuthType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthType, AuthType>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthType, AuthType>,
              AuthType,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// User yang sedang login, dipakai header & sidebar.

@ProviderFor(Session)
final sessionProvider = SessionProvider._();

/// User yang sedang login, dipakai header & sidebar.
final class SessionProvider extends $NotifierProvider<Session, UserModel?> {
  /// User yang sedang login, dipakai header & sidebar.
  SessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionHash();

  @$internal
  @override
  Session create() => Session();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserModel?>(value),
    );
  }
}

String _$sessionHash() => r'1cca10d066c5efbec75fc4f8a3ce7fd2be01e6fc';

/// User yang sedang login, dipakai header & sidebar.

abstract class _$Session extends $Notifier<UserModel?> {
  UserModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UserModel?, UserModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserModel?, UserModel?>,
              UserModel?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(LoginController)
final loginControllerProvider = LoginControllerProvider._();

final class LoginControllerProvider
    extends $AsyncNotifierProvider<LoginController, LoginResultModel?> {
  LoginControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginControllerHash();

  @$internal
  @override
  LoginController create() => LoginController();
}

String _$loginControllerHash() => r'5790646bfb7f612b5b5594a312294b88ff590174';

abstract class _$LoginController extends $AsyncNotifier<LoginResultModel?> {
  FutureOr<LoginResultModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<LoginResultModel?>, LoginResultModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LoginResultModel?>, LoginResultModel?>,
              AsyncValue<LoginResultModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
