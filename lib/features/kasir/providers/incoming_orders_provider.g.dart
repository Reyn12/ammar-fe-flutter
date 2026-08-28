// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incoming_orders_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IncomingOrders)
final incomingOrdersProvider = IncomingOrdersProvider._();

final class IncomingOrdersProvider
    extends $AsyncNotifierProvider<IncomingOrders, List<OrderModel>> {
  IncomingOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingOrdersHash();

  @$internal
  @override
  IncomingOrders create() => IncomingOrders();
}

String _$incomingOrdersHash() => r'3e72deccbc10e744a7738c2ebcc1aaa4851b7f54';

abstract class _$IncomingOrders extends $AsyncNotifier<List<OrderModel>> {
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

@ProviderFor(IncomingOrderFilterState)
final incomingOrderFilterStateProvider = IncomingOrderFilterStateProvider._();

final class IncomingOrderFilterStateProvider
    extends $NotifierProvider<IncomingOrderFilterState, IncomingOrderFilter> {
  IncomingOrderFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingOrderFilterStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingOrderFilterStateHash();

  @$internal
  @override
  IncomingOrderFilterState create() => IncomingOrderFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IncomingOrderFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IncomingOrderFilter>(value),
    );
  }
}

String _$incomingOrderFilterStateHash() =>
    r'5a9df326f731bfc69e76bbe2c8544cd9600bb264';

abstract class _$IncomingOrderFilterState
    extends $Notifier<IncomingOrderFilter> {
  IncomingOrderFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<IncomingOrderFilter, IncomingOrderFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IncomingOrderFilter, IncomingOrderFilter>,
              IncomingOrderFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedOrderId)
final selectedOrderIdProvider = SelectedOrderIdProvider._();

final class SelectedOrderIdProvider
    extends $NotifierProvider<SelectedOrderId, int?> {
  SelectedOrderIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedOrderIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedOrderIdHash();

  @$internal
  @override
  SelectedOrderId create() => SelectedOrderId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$selectedOrderIdHash() => r'8c7570ace5feb9d698d682fce2e35b6ac203b624';

abstract class _$SelectedOrderId extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredIncomingOrders)
final filteredIncomingOrdersProvider = FilteredIncomingOrdersProvider._();

final class FilteredIncomingOrdersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<OrderModel>>,
          List<OrderModel>,
          FutureOr<List<OrderModel>>
        >
    with $FutureModifier<List<OrderModel>>, $FutureProvider<List<OrderModel>> {
  FilteredIncomingOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredIncomingOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredIncomingOrdersHash();

  @$internal
  @override
  $FutureProviderElement<List<OrderModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<OrderModel>> create(Ref ref) {
    return filteredIncomingOrders(ref);
  }
}

String _$filteredIncomingOrdersHash() =>
    r'd630698b1afdd654fbcfa5a282c01e0a68139010';

@ProviderFor(selectedIncomingOrder)
final selectedIncomingOrderProvider = SelectedIncomingOrderProvider._();

final class SelectedIncomingOrderProvider
    extends
        $FunctionalProvider<
          AsyncValue<OrderModel?>,
          OrderModel?,
          FutureOr<OrderModel?>
        >
    with $FutureModifier<OrderModel?>, $FutureProvider<OrderModel?> {
  SelectedIncomingOrderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedIncomingOrderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedIncomingOrderHash();

  @$internal
  @override
  $FutureProviderElement<OrderModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<OrderModel?> create(Ref ref) {
    return selectedIncomingOrder(ref);
  }
}

String _$selectedIncomingOrderHash() =>
    r'65e33a339cc6cc6fd4efce759943c90c89bf08df';

/// Jumlah order tunai yang masih menunggu konfirmasi, dipakai badge sidebar.

@ProviderFor(waitingCashCount)
final waitingCashCountProvider = WaitingCashCountProvider._();

/// Jumlah order tunai yang masih menunggu konfirmasi, dipakai badge sidebar.

final class WaitingCashCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Jumlah order tunai yang masih menunggu konfirmasi, dipakai badge sidebar.
  WaitingCashCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'waitingCashCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$waitingCashCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return waitingCashCount(ref);
  }
}

String _$waitingCashCountHash() => r'24a0553f3c796143746320e6c0cf59ce099f3f1c';
