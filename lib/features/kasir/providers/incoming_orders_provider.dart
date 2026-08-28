import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/order_mocks.dart';
import '../../../models/order_enums.dart';
import '../../../models/order_model.dart';
import '../models/incoming_order_filter.dart';

part 'incoming_orders_provider.g.dart';

@riverpod
class IncomingOrders extends _$IncomingOrders {
  @override
  Future<List<OrderModel>> build() async {
    // TODO: ganti mock ini dengan GET /v1/orders?status=paid|pending_cash + SSE.
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return OrderMocks.incomingOrders;
  }

  /// SKPL-F-006 — set pembayaran tunai jadi lunas.
  Future<void> confirmCashPayment(int orderId) async {
    // TODO: ganti dengan POST /v1/orders/{id}/confirm-cash.
    await Future<void>.delayed(const Duration(milliseconds: 500));

    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        if (order.id == orderId)
          order.copyWith(paymentStatus: PaymentStatus.paid)
        else
          order,
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
