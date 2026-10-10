// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_events_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// true selama koneksi SSE tersambung; dipakai indikator Online/Offline di header.

@ProviderFor(StaffEventsConnection)
final staffEventsConnectionProvider = StaffEventsConnectionProvider._();

/// true selama koneksi SSE tersambung; dipakai indikator Online/Offline di header.
final class StaffEventsConnectionProvider
    extends $NotifierProvider<StaffEventsConnection, bool> {
  /// true selama koneksi SSE tersambung; dipakai indikator Online/Offline di header.
  StaffEventsConnectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffEventsConnectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffEventsConnectionHash();

  @$internal
  @override
  StaffEventsConnection create() => StaffEventsConnection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$staffEventsConnectionHash() =>
    r'9b8166bc31b91adf15ae464cd0f65a27aa8202eb';

/// true selama koneksi SSE tersambung; dipakai indikator Online/Offline di header.

abstract class _$StaffEventsConnection extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Stream event realtime untuk kasir & dapur. Menyambung ulang otomatis (dengan jeda bertahap)
/// dan melanjutkan dari event terakhir lewat header `Last-Event-ID`, jadi event yang
/// terlewat saat koneksi putus tetap diterima.
///
/// Server menutup koneksi tiap ~25 detik; itu normal dan memicu sambung ulang.

@ProviderFor(staffEvents)
final staffEventsProvider = StaffEventsProvider._();

/// Stream event realtime untuk kasir & dapur. Menyambung ulang otomatis (dengan jeda bertahap)
/// dan melanjutkan dari event terakhir lewat header `Last-Event-ID`, jadi event yang
/// terlewat saat koneksi putus tetap diterima.
///
/// Server menutup koneksi tiap ~25 detik; itu normal dan memicu sambung ulang.

final class StaffEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<StaffEvent>,
          StaffEvent,
          Stream<StaffEvent>
        >
    with $FutureModifier<StaffEvent>, $StreamProvider<StaffEvent> {
  /// Stream event realtime untuk kasir & dapur. Menyambung ulang otomatis (dengan jeda bertahap)
  /// dan melanjutkan dari event terakhir lewat header `Last-Event-ID`, jadi event yang
  /// terlewat saat koneksi putus tetap diterima.
  ///
  /// Server menutup koneksi tiap ~25 detik; itu normal dan memicu sambung ulang.
  StaffEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffEventsHash();

  @$internal
  @override
  $StreamProviderElement<StaffEvent> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<StaffEvent> create(Ref ref) {
    return staffEvents(ref);
  }
}

String _$staffEventsHash() => r'd91c96c6ce0ed310c9c24f262dde9f6413026064';
