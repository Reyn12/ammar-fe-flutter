// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_batch_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KitchenBatches)
final kitchenBatchesProvider = KitchenBatchesProvider._();

final class KitchenBatchesProvider
    extends $AsyncNotifierProvider<KitchenBatches, List<KitchenBatchModel>> {
  KitchenBatchesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitchenBatchesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitchenBatchesHash();

  @$internal
  @override
  KitchenBatches create() => KitchenBatches();
}

String _$kitchenBatchesHash() => r'3a185b8c7a0253ef450fb7511c596f83f59e17b3';

abstract class _$KitchenBatches
    extends $AsyncNotifier<List<KitchenBatchModel>> {
  FutureOr<List<KitchenBatchModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<KitchenBatchModel>>,
              List<KitchenBatchModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<KitchenBatchModel>>,
                List<KitchenBatchModel>
              >,
              AsyncValue<List<KitchenBatchModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Batch aktif di sidebar: cuma yang masih pending (belum Process All).

@ProviderFor(groupedKitchenBatches)
final groupedKitchenBatchesProvider = GroupedKitchenBatchesProvider._();

/// Batch aktif di sidebar: cuma yang masih pending (belum Process All).

final class GroupedKitchenBatchesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, List<KitchenBatchModel>>>,
          Map<String, List<KitchenBatchModel>>,
          FutureOr<Map<String, List<KitchenBatchModel>>>
        >
    with
        $FutureModifier<Map<String, List<KitchenBatchModel>>>,
        $FutureProvider<Map<String, List<KitchenBatchModel>>> {
  /// Batch aktif di sidebar: cuma yang masih pending (belum Process All).
  GroupedKitchenBatchesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groupedKitchenBatchesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groupedKitchenBatchesHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, List<KitchenBatchModel>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, List<KitchenBatchModel>>> create(Ref ref) {
    return groupedKitchenBatches(ref);
  }
}

String _$groupedKitchenBatchesHash() =>
    r'5634bf199bcda0a2f0d97366ffc42f7fce250e71';
