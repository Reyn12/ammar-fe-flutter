import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/order_model.dart';
import '../../../network/api_service.dart';
import '../models/incoming_order_filter.dart';

part 'incoming_orders_provider.g.dart';

@riverpod
class IncomingOrders extends _$IncomingOrders {
  @override
  Future<List<OrderModel>> build() async {
    // TODO: tambah SSE GET /v1/stream/orders untuk live update.
    return ref.watch(apiServiceProvider).fetchIncomingOrders();
  }

  /// Sisipkan pesanan baru di depan list (simulasi SSE / event paid).
  void insertIncomingOrder(OrderModel order) {
    state = AsyncData([order, ...state.value ?? <OrderModel>[]]);
  }

  /// SKPL-F-006 — set pembayaran tunai jadi lunas.
  Future<void> confirmCashPayment(int orderId) async {
    final updated = await ref
        .read(apiServiceProvider)
        .confirmCashPayment(orderId: orderId);

    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        if (order.id == orderId) updated else order,
    ]);
  }
}

@riverpod
class IncomingOrderFilterState extends _$IncomingOrderFilterState {
  @override
  IncomingOrderFilter build() => IncomingOrderFilter.all;

  void select(IncomingOrderFilter filter) => state = filter;
}

@riverpod
class SelectedOrderId extends _$SelectedOrderId {
  @override
  int? build() => null;

  void select(int? orderId) => state = orderId;
}

/// Sync filter — jangan Future biar insert order baru nggak flash loading.
@riverpod
List<OrderModel> filteredIncomingOrders(Ref ref) {
  final orders = ref.watch(incomingOrdersProvider).value ?? <OrderModel>[];
  final filter = ref.watch(incomingOrderFilterStateProvider);
  return orders.where(filter.matches).toList();
}

@riverpod
OrderModel? selectedIncomingOrder(Ref ref) {
  final selectedId = ref.watch(selectedOrderIdProvider);
  for (final order in ref.watch(filteredIncomingOrdersProvider)) {
    if (order.id == selectedId) return order;
  }
  return null;
}

/// Jumlah order tunai yang masih menunggu konfirmasi, dipakai badge sidebar.
@riverpod
int waitingCashCount(Ref ref) {
  return (ref.watch(incomingOrdersProvider).value ?? <OrderModel>[])
      .where((order) => order.needCashConfirmation)
      .length;
}
