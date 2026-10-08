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

String _$incomingOrdersHash() => r'782e0e10989c8c9a06f0ff1f61883dcd85d40f92';

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

/// Sync filter — jangan Future biar insert order baru nggak flash loading.

@ProviderFor(filteredIncomingOrders)
final filteredIncomingOrdersProvider = FilteredIncomingOrdersProvider._();

/// Sync filter — jangan Future biar insert order baru nggak flash loading.

final class FilteredIncomingOrdersProvider
    extends
        $FunctionalProvider<
          List<OrderModel>,
          List<OrderModel>,
          List<OrderModel>
        >
    with $Provider<List<OrderModel>> {
  /// Sync filter — jangan Future biar insert order baru nggak flash loading.
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
  $ProviderElement<List<OrderModel>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<OrderModel> create(Ref ref) {
    return filteredIncomingOrders(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<OrderModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<OrderModel>>(value),
    );
  }
}

String _$filteredIncomingOrdersHash() =>
    r'32ddd536a49899b0731336c6f819c60d8dc3c50a';

@ProviderFor(selectedIncomingOrder)
final selectedIncomingOrderProvider = SelectedIncomingOrderProvider._();

final class SelectedIncomingOrderProvider
    extends $FunctionalProvider<OrderModel?, OrderModel?, OrderModel?>
    with $Provider<OrderModel?> {
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
  $ProviderElement<OrderModel?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrderModel? create(Ref ref) {
    return selectedIncomingOrder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderModel?>(value),
    );
  }
}

String _$selectedIncomingOrderHash() =>
    r'61687897610cad80e5bf2029419fabb211be8ad3';

/// Jumlah order tunai yang masih menunggu konfirmasi, dipakai badge sidebar.

@ProviderFor(waitingCashCount)
final waitingCashCountProvider = WaitingCashCountProvider._();

/// Jumlah order tunai yang masih menunggu konfirmasi, dipakai badge sidebar.

final class WaitingCashCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
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
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return waitingCashCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$waitingCashCountHash() => r'2ed6c20ab40ec5cabb3e0be66d5ce8cc2e32de74';
