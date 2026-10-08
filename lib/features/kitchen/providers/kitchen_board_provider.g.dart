// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitchen_board_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KitchenOrders)
final kitchenOrdersProvider = KitchenOrdersProvider._();

final class KitchenOrdersProvider
    extends $AsyncNotifierProvider<KitchenOrders, List<OrderModel>> {
  KitchenOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitchenOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitchenOrdersHash();

  @$internal
  @override
  KitchenOrders create() => KitchenOrders();
}

String _$kitchenOrdersHash() => r'527c990e9cf1f1a8dc2f512d13228450230c8694';

abstract class _$KitchenOrders extends $AsyncNotifier<List<OrderModel>> {
  FutureOr<List<OrderModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<OrderModel>>, List<OrderModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<OrderModel>>, List<OrderModel>>,
              AsyncValue<List<OrderModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(KitchenPageIndex)
final kitchenPageIndexProvider = KitchenPageIndexProvider._();

final class KitchenPageIndexProvider
    extends $NotifierProvider<KitchenPageIndex, int> {
  KitchenPageIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitchenPageIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitchenPageIndexHash();

  @$internal
  @override
  KitchenPageIndex create() => KitchenPageIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$kitchenPageIndexHash() => r'760e2956a4a26e6bd22e570081592cf89a40a26a';

abstract class _$KitchenPageIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(kitchenTotalPages)
final kitchenTotalPagesProvider = KitchenTotalPagesProvider._();

final class KitchenTotalPagesProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  KitchenTotalPagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitchenTotalPagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitchenTotalPagesHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return kitchenTotalPages(ref);
  }
}

String _$kitchenTotalPagesHash() => r'4574cacf607ba92f344e0ea8a40203fff2902153';

@ProviderFor(pagedKitchenOrders)
final pagedKitchenOrdersProvider = PagedKitchenOrdersProvider._();

final class PagedKitchenOrdersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrderModel>>,
          List<OrderModel>,
          FutureOr<List<OrderModel>>
        >
    with $FutureModifier<List<OrderModel>>, $FutureProvider<List<OrderModel>> {
  PagedKitchenOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pagedKitchenOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pagedKitchenOrdersHash();

  @$internal
  @override
  $FutureProviderElement<List<OrderModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrderModel>> create(Ref ref) {
    return pagedKitchenOrders(ref);
  }
}

String _$pagedKitchenOrdersHash() =>
    r'50cb1142fb6d8a64fd0afb51ec15550e72450451';
