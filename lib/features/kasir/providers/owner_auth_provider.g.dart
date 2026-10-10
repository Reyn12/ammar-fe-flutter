// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Password owner untuk mock login lokal.

@ProviderFor(OwnerAuth)
final ownerAuthProvider = OwnerAuthProvider._();

/// Password owner untuk mock login lokal.
final class OwnerAuthProvider extends $NotifierProvider<OwnerAuth, String> {
  /// Password owner untuk mock login lokal.
  OwnerAuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownerAuthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownerAuthHash();

  @$internal
  @override
  OwnerAuth create() => OwnerAuth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$ownerAuthHash() => r'c75c2a116d489338ded8ddde695300f84cba33ea';

/// Password owner untuk mock login lokal.

abstract class _$OwnerAuth extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
