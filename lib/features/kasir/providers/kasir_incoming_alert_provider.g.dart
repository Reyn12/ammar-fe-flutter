// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kasir_incoming_alert_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Alert pesanan baru di kasir (toast + highlight card + badge filter).
/// Dipicu event SSE dari backend (lihat KasirShellPage / KitchenBoardPage).

@ProviderFor(KasirIncomingAlert)
final kasirIncomingAlertProvider = KasirIncomingAlertProvider._();

/// Alert pesanan baru di kasir (toast + highlight card + badge filter).
/// Dipicu event SSE dari backend (lihat KasirShellPage / KitchenBoardPage).
final class KasirIncomingAlertProvider
    extends $NotifierProvider<KasirIncomingAlert, KasirIncomingState> {
  /// Alert pesanan baru di kasir (toast + highlight card + badge filter).
  /// Dipicu event SSE dari backend (lihat KasirShellPage / KitchenBoardPage).
  KasirIncomingAlertProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kasirIncomingAlertProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kasirIncomingAlertHash();

  @$internal
  @override
  KasirIncomingAlert create() => KasirIncomingAlert();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KasirIncomingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KasirIncomingState>(value),
    );
  }
}

String _$kasirIncomingAlertHash() =>
    r'e30abf45237de7ce8de29ff43883a56772717c8a';

/// Alert pesanan baru di kasir (toast + highlight card + badge filter).
/// Dipicu event SSE dari backend (lihat KasirShellPage / KitchenBoardPage).

abstract class _$KasirIncomingAlert extends $Notifier<KasirIncomingState> {
  KasirIncomingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<KasirIncomingState, KasirIncomingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<KasirIncomingState, KasirIncomingState>,
              KasirIncomingState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
