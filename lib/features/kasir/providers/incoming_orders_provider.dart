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

@riverpod
Future<List<OrderModel>> filteredIncomingOrders(Ref ref) async {
  return (await ref.watch(incomingOrdersProvider.future))
      .where(ref.watch(incomingOrderFilterStateProvider).matches)
      .toList();
}

@riverpod
Future<OrderModel?> selectedIncomingOrder(Ref ref) async {
  for (final order in await ref.watch(filteredIncomingOrdersProvider.future)) {
    if (order.id == ref.watch(selectedOrderIdProvider)) return order;
  }
  return null;
}

/// Jumlah order tunai yang masih menunggu konfirmasi, dipakai badge sidebar.
@riverpod
Future<int> waitingCashCount(Ref ref) async {
  return (await ref.watch(incomingOrdersProvider.future))
      .where((order) => order.needCashConfirmation)
      .length;
}
