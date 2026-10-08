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
    r'c1fc6e924715d185c5c3a4436fc5abf881a98f41';

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

@ProviderFor(IncomingOrderSearchQuery)
final incomingOrderSearchQueryProvider = IncomingOrderSearchQueryProvider._();

final class IncomingOrderSearchQueryProvider
    extends $NotifierProvider<IncomingOrderSearchQuery, String> {
  IncomingOrderSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingOrderSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingOrderSearchQueryHash();

  @$internal
  @override
  IncomingOrderSearchQuery create() => IncomingOrderSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$incomingOrderSearchQueryHash() =>
    r'708633e9413d1853e15d43f705a7954c4136ab8a';

abstract class _$IncomingOrderSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(KasirOrderPageIndex)
final kasirOrderPageIndexProvider = KasirOrderPageIndexProvider._();

final class KasirOrderPageIndexProvider
    extends $NotifierProvider<KasirOrderPageIndex, int> {
  KasirOrderPageIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kasirOrderPageIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kasirOrderPageIndexHash();

  @$internal
  @override
  KasirOrderPageIndex create() => KasirOrderPageIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$kasirOrderPageIndexHash() =>
    r'7582465fb4476346df9005e66d3df4906f4f2684';

abstract class _$KasirOrderPageIndex extends $Notifier<int> {
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

/// Filter + search (sebelum pagination).

@ProviderFor(filteredIncomingOrders)
final filteredIncomingOrdersProvider = FilteredIncomingOrdersProvider._();

/// Filter + search (sebelum pagination).

final class FilteredIncomingOrdersProvider
    extends
        $FunctionalProvider<
          List<OrderModel>,
          List<OrderModel>,
          List<OrderModel>
        >
    with $Provider<List<OrderModel>> {
  /// Filter + search (sebelum pagination).
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
    r'8889119321bdbbac68cc9113edc7b59a0db7d1e8';

@ProviderFor(kasirOrderTotalPages)
final kasirOrderTotalPagesProvider = KasirOrderTotalPagesProvider._();

final class KasirOrderTotalPagesProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  KasirOrderTotalPagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kasirOrderTotalPagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kasirOrderTotalPagesHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return kasirOrderTotalPages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$kasirOrderTotalPagesHash() =>
    r'44ecbcdb17538769fe82c327c0cf53da578bcc43';

@ProviderFor(pagedIncomingOrders)
final pagedIncomingOrdersProvider = PagedIncomingOrdersProvider._();

final class PagedIncomingOrdersProvider
    extends
        $FunctionalProvider<
          List<OrderModel>,
          List<OrderModel>,
          List<OrderModel>
        >
    with $Provider<List<OrderModel>> {
  PagedIncomingOrdersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pagedIncomingOrdersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pagedIncomingOrdersHash();

  @$internal
  @override
  $ProviderElement<List<OrderModel>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<OrderModel> create(Ref ref) {
    return pagedIncomingOrders(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<OrderModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<OrderModel>>(value),
    );
  }
}

String _$pagedIncomingOrdersHash() =>
    r'c49812d9bf816c67263ca63469a3e7a2e47a8b08';

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
