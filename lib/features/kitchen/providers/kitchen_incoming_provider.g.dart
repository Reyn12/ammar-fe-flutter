// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_incoming_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Alert pesanan baru di kitchen (toast + highlight card).
/// Nanti bisa dipicu SSE; sekarang ada simulate buat UI.

@ProviderFor(KitchenIncomingAlert)
final kitchenIncomingAlertProvider = KitchenIncomingAlertProvider._();

/// Alert pesanan baru di kitchen (toast + highlight card).
/// Nanti bisa dipicu SSE; sekarang ada simulate buat UI.
final class KitchenIncomingAlertProvider
    extends $NotifierProvider<KitchenIncomingAlert, KitchenIncomingState> {
  /// Alert pesanan baru di kitchen (toast + highlight card).
  /// Nanti bisa dipicu SSE; sekarang ada simulate buat UI.
  KitchenIncomingAlertProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitchenIncomingAlertProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitchenIncomingAlertHash();

  @$internal
  @override
  KitchenIncomingAlert create() => KitchenIncomingAlert();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KitchenIncomingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KitchenIncomingState>(value),
    );
  }
}

String _$kitchenIncomingAlertHash() =>
    r'5a7a4f880958aed5a3e5e9551c2d71bfe71a5973';

/// Alert pesanan baru di kitchen (toast + highlight card).
/// Nanti bisa dipicu SSE; sekarang ada simulate buat UI.

abstract class _$KitchenIncomingAlert extends $Notifier<KitchenIncomingState> {
  KitchenIncomingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<KitchenIncomingState, KitchenIncomingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<KitchenIncomingState, KitchenIncomingState>,
              KitchenIncomingState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
