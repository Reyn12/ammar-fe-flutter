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

String _$authHash() => r'f015e7da55898cd1bfaf3864999c3ba9b339bdf7';

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

String _$loginControllerHash() => r'35655fd807e6adb088f25033491107ab9bfd703d';

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
