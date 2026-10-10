// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_push_test_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tombol bel di header dapur: minta server mengirim notifikasi tes ke tablet ini.
/// State berisi pesan hasil dari server (null sebelum dipakai).

@ProviderFor(KitchenPushTest)
final kitchenPushTestProvider = KitchenPushTestProvider._();

/// Tombol bel di header dapur: minta server mengirim notifikasi tes ke tablet ini.
/// State berisi pesan hasil dari server (null sebelum dipakai).
final class KitchenPushTestProvider
    extends $AsyncNotifierProvider<KitchenPushTest, String?> {
  /// Tombol bel di header dapur: minta server mengirim notifikasi tes ke tablet ini.
  /// State berisi pesan hasil dari server (null sebelum dipakai).
  KitchenPushTestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitchenPushTestProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitchenPushTestHash();

  @$internal
  @override
  KitchenPushTest create() => KitchenPushTest();
}

String _$kitchenPushTestHash() => r'f0b5d4850fae84305d8d494eda518b6d337e0260';

/// Tombol bel di header dapur: minta server mengirim notifikasi tes ke tablet ini.
/// State berisi pesan hasil dari server (null sebelum dipakai).

abstract class _$KitchenPushTest extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
