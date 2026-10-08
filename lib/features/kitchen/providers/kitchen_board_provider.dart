import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/order_mocks.dart';
import '../../../models/order_enums.dart';
import '../../../models/order_model.dart';

part 'kitchen_board_provider.g.dart';

/// Jumlah kartu order per halaman board (murni paginasi UI, bukan batch).
const int kitchenOrdersPerPage = 6;

@riverpod
class KitchenOrders extends _$KitchenOrders {
  @override
  Future<List<OrderModel>> build() async {
    // TODO: ganti mock ini dengan GET /v1/kitchen/orders + SSE.
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return OrderMocks.kitchenOrders;
  }

  /// SKPL-F-011 — item terpilih jadi `cooking` (baru setelah user klik button).
  Future<void> processSelectedItems(int orderId, List<int> itemIds) async {
    // TODO: ganti dengan PATCH /v1/order-items/{id}/status.
    if (itemIds.isEmpty) return;
    final selected = itemIds.toSet();
    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        if (order.id != orderId)
          order
        else
          _syncOrderStatus(
            order.copyWith(
              items: [
                for (final item in order.items ?? [])
                  if (selected.contains(item.id) &&
                      item.status == OrderItemStatus.pending)
                    item.copyWith(status: OrderItemStatus.cooking)
                  else
                    item,
              ],
            ),
          ),
    ]);
  }

  /// SKPL-F-011 — item terpilih jadi `ready` (baru setelah user klik button).
  Future<void> serveSelectedItems(int orderId, List<int> itemIds) async {
    // TODO: ganti dengan PATCH /v1/order-items/{id}/status.
    if (itemIds.isEmpty) return;
    final selected = itemIds.toSet();
    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        if (order.id != orderId)
          order
        else
          _syncOrderStatus(
            order.copyWith(
              items: [
                for (final item in order.items ?? [])
                  if (selected.contains(item.id) &&
                      item.status == OrderItemStatus.cooking)
                    item.copyWith(status: OrderItemStatus.ready)
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
