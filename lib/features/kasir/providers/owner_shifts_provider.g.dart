// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_shifts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manajemen shift dari sisi owner (pantau + force close).

@ProviderFor(OwnerShifts)
final ownerShiftsProvider = OwnerShiftsProvider._();

/// Manajemen shift dari sisi owner (pantau + force close).
final class OwnerShiftsProvider
    extends $AsyncNotifierProvider<OwnerShifts, List<ShiftModel>> {
  /// Manajemen shift dari sisi owner (pantau + force close).
  OwnerShiftsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownerShiftsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownerShiftsHash();

  @$internal
  @override
  OwnerShifts create() => OwnerShifts();
}

String _$ownerShiftsHash() => r'b3494e49e414cc0e5b7bb2c724c46b5ea9a53e49';

/// Manajemen shift dari sisi owner (pantau + force close).

abstract class _$OwnerShifts extends $AsyncNotifier<List<ShiftModel>> {
  FutureOr<List<ShiftModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ShiftModel>>, List<ShiftModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ShiftModel>>, List<ShiftModel>>,
              AsyncValue<List<ShiftModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
