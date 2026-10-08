import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/order_enums.dart';
import '../../../models/order_model.dart';
import '../../../network/api_service.dart';

part 'kitchen_board_provider.g.dart';

/// Jumlah kartu order per halaman board (murni paginasi UI, bukan batch).
const int kitchenOrdersPerPage = 6;

@riverpod
class KitchenOrders extends _$KitchenOrders {
  @override
  Future<List<OrderModel>> build() async {
    return ref.watch(apiServiceProvider).fetchKitchenOrders();
  }

  /// Sisipkan pesanan baru di depan list (simulasi SSE / event paid).
  void insertIncomingOrder(OrderModel order) {
    state = AsyncData([order, ...state.value ?? <OrderModel>[]]);
  }

  /// Update lokal setelah API process item terpilih sukses.
  void applyProcessSelected(int orderId, List<int> itemIds) {
    if (itemIds.isEmpty) return;
    final selected = itemIds.toSet();
    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        if (order.id != orderId)
          order
        else
          syncOrderStatus(
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

  /// Update lokal setelah API serve item terpilih sukses.
  void applyServeSelected(int orderId, List<int> itemIds) {
    if (itemIds.isEmpty) return;
    final selected = itemIds.toSet();
    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        if (order.id != orderId)
          order
        else
          syncOrderStatus(
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

  /// Update lokal setelah Process All batch sukses.
  void applyMarkProductCooking(int productId) {
    state = AsyncData([
      for (final order in state.value ?? <OrderModel>[])
        syncOrderStatus(
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
  OrderModel syncOrderStatus(OrderModel order) {
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
