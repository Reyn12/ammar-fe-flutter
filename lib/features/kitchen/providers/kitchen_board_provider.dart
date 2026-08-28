import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/order_mocks.dart';
import '../../../models/order_enums.dart';
import '../../../models/order_model.dart';

part 'kitchen_board_provider.g.dart';

/// Jumlah kartu order per halaman board (murni paginasi UI, bukan batch).
const int kitchenOrdersPerPage = 4;

@riverpod
class KitchenOrders extends _$KitchenOrders {
  @override
  Future<List<OrderModel>> build() async {
    // TODO: ganti mock ini dengan GET /v1/kitchen/orders + SSE.
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return OrderMocks.kitchenOrders;
  }

  /// SKPL-F-011 — semua item pada satu order jadi `cooking`.
  Future<void> processOrder(int orderId) async {
    // TODO: ganti dengan PATCH /v1/orders/{id}/status.
    _updateOrder(
      orderId,
      itemStatus: OrderItemStatus.cooking,
      orderStatus: OrderStatus.cooking,
      onlyWhenPending: true,
    );
  }

  /// SKPL-F-011 — semua item pada satu order jadi `ready`.
  Future<void> serveOrder(int orderId) async {
    _updateOrder(
      orderId,
      itemStatus: OrderItemStatus.ready,
      orderStatus: OrderStatus.ready,
    );
  }

  /// Naikkan status satu item: pending → cooking → ready.
  Future<void> advanceItemStatus(int orderId, int itemId) async {
    // TODO: ganti dengan PATCH /v1/order-items/{id}/status.
    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        if (order.id != orderId)
          order
        else
          _syncOrderStatus(
            order.copyWith(
              items: [
                for (final item in order.items ?? [])
                  if (item.id == itemId)
                    item.copyWith(status: _nextStatus(item.status))
                  else
                    item,
              ],
            ),
          ),
    ]);
  }

  /// Dipakai aksi "Process All" pada batch: semua item menu tsb jadi `cooking`.
  Future<void> markProductCooking(int productId) async {
    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        _syncOrderStatus(
          order.copyWith(
            items: [
              for (final item in order.items ?? [])
                if (item.productId == productId &&
                    item.status == OrderItemStatus.pending)
                  item.copyWith(status: OrderItemStatus.cooking)
                else
                  item,
            ],
          ),
        ),
    ]);
  }

  void _updateOrder(
    int orderId, {
    required OrderItemStatus itemStatus,
    required OrderStatus orderStatus,
    bool onlyWhenPending = false,
  }) {
    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        if (order.id != orderId)
          order
        else
          order.copyWith(
            status: orderStatus,
            items: [
              for (final item in order.items ?? [])
                if (!onlyWhenPending || item.status == OrderItemStatus.pending)
                  item.copyWith(status: itemStatus)
                else
                  item,
            ],
          ),
    ]);
  }

  OrderItemStatus _nextStatus(OrderItemStatus? current) {
    switch (current) {
      case OrderItemStatus.pending:
        return OrderItemStatus.cooking;
      case OrderItemStatus.cooking:
      case OrderItemStatus.ready:
      case null:
        return OrderItemStatus.ready;
    }
  }

  /// Status order mengikuti status item-nya.
  OrderModel _syncOrderStatus(OrderModel order) {
    if ((order.items ?? []).isEmpty) return order;

    if ((order.items ?? []).every(
      (item) => item.status == OrderItemStatus.ready,
    )) {
      return order.copyWith(status: OrderStatus.ready);
    }
    if ((order.items ?? []).any(
      (item) => item.status == OrderItemStatus.cooking,
    )) {
      return order.copyWith(status: OrderStatus.cooking);
    }
    return order.copyWith(status: OrderStatus.pending);
  }
}

@riverpod
class KitchenPageIndex extends _$KitchenPageIndex {
  @override
  int build() => 0;

  void select(int page) => state = page;
}

@riverpod
Future<int> kitchenTotalPages(Ref ref) async {
  return ((await ref.watch(kitchenOrdersProvider.future)).length /
          kitchenOrdersPerPage)
      .ceil()
      .clamp(1, 999);
}

@riverpod
Future<List<OrderModel>> pagedKitchenOrders(Ref ref) async {
  return (await ref.watch(kitchenOrdersProvider.future))
      .skip(ref.watch(kitchenPageIndexProvider) * kitchenOrdersPerPage)
      .take(kitchenOrdersPerPage)
      .toList();
}
