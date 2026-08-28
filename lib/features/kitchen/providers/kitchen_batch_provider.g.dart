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

String _$kitchenBatchesHash() => r'dea62a073cf92b0a14c1a26666e457743feb7f9b';

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

/// Batch dikelompokkan per kategori untuk sidebar dapur.

@ProviderFor(groupedKitchenBatches)
final groupedKitchenBatchesProvider = GroupedKitchenBatchesProvider._();

/// Batch dikelompokkan per kategori untuk sidebar dapur.

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
  /// Batch dikelompokkan per kategori untuk sidebar dapur.
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
    r'fa5319fb8efb71737a1f960d511475328e7719a7';
