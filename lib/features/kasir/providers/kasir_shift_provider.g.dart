// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kasir_shift_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KasirShift)
final kasirShiftProvider = KasirShiftProvider._();

final class KasirShiftProvider
    extends $AsyncNotifierProvider<KasirShift, ShiftModel?> {
  KasirShiftProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kasirShiftProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kasirShiftHash();

  @$internal
  @override
  KasirShift create() => KasirShift();
}

String _$kasirShiftHash() => r'fe1d55b86aae88c296b572e543f9b17ffac99982';

abstract class _$KasirShift extends $AsyncNotifier<ShiftModel?> {
  FutureOr<ShiftModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ShiftModel?>, ShiftModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ShiftModel?>, ShiftModel?>,
              AsyncValue<ShiftModel?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
