// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kasir_nav_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KasirNav)
final kasirNavProvider = KasirNavProvider._();

final class KasirNavProvider extends $NotifierProvider<KasirNav, KasirNavItem> {
  KasirNavProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kasirNavProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kasirNavHash();

  @$internal
  @override
  KasirNav create() => KasirNav();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KasirNavItem value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KasirNavItem>(value),
    );
  }
}

String _$kasirNavHash() => r'b634a52cdb69278b8fcc2afb212fb07f0267d9b2';

abstract class _$KasirNav extends $Notifier<KasirNavItem> {
  KasirNavItem build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<KasirNavItem, KasirNavItem>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<KasirNavItem, KasirNavItem>,
              KasirNavItem,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
