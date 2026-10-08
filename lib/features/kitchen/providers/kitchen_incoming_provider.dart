import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/order_enums.dart';
import '../../../models/order_item_model.dart';
import '../../../models/order_model.dart';
import '../models/kitchen_incoming_state.dart';
import '../models/kitchen_incoming_toast_model.dart';
import 'kitchen_board_provider.dart';

part 'kitchen_incoming_provider.g.dart';

/// Alert pesanan baru di kitchen (toast + highlight card).
/// Nanti bisa dipicu SSE; sekarang ada simulate buat UI.
@riverpod
class KitchenIncomingAlert extends _$KitchenIncomingAlert {
  final Map<int, Timer> clearNewTimers = {};
  Timer? toastTimer;

  @override
  KitchenIncomingState build() {
    ref.onDispose(() {
      for (final timer in clearNewTimers.values) {
        timer.cancel();
      }
      toastTimer?.cancel();
    });
    return const KitchenIncomingState();
  }

  void announce(OrderModel order) {
    final orderId = order.id;
    if (orderId == null) return;

    state = state.copyWith(
      newOrderIds: {...state.newOrderIds, orderId},
      toast: KitchenIncomingToastModel(
        orderId: orderId,
        orderCode: order.code ?? '-',
        placeLabel: order.placeLabel,
        customerName: order.customerName ?? '-',
      ),
    );

    clearNewTimers[orderId]?.cancel();
    clearNewTimers[orderId] = Timer(const Duration(seconds: 45), () {
      clearNew(orderId);
    });

    toastTimer?.cancel();
    toastTimer = Timer(const Duration(seconds: 4), dismissToast);
  }

  void clearNew(int orderId) {
    clearNewTimers.remove(orderId)?.cancel();
    if (!state.newOrderIds.contains(orderId)) return;
    final next = {...state.newOrderIds}..remove(orderId);
    state = state.copyWith(newOrderIds: next);
  }

  void dismissToast() {
    toastTimer?.cancel();
    toastTimer = null;
    if (state.toast == null) return;
    state = state.copyWith(clearToast: true);
  }

  /// Simulasi SSE: pesanan baru masuk ke board + toast + highlight.
  void simulateIncomingOrder() {
    final current = ref.read(kitchenOrdersProvider).value ?? <OrderModel>[];
    final nextOrderId =
        (current.map((order) => order.id ?? 0).fold(0, (a, b) => a > b ? a : b)) +
        1;
    final nextItemId =
        current
            .expand((order) => order.items ?? <OrderItemModel>[])
            .map((item) => item.id ?? 0)
            .fold(0, (a, b) => a > b ? a : b) +
        1;

    final order = OrderModel(
      id: nextOrderId,
      code: '#AMR$nextOrderId',
      shiftId: 1,
      tableId: 15,
      tableNumber: '15',
      branchId: 1,
      customerName: 'Pelanggan Baru',
      orderType: OrderType.dineIn,
      status: OrderStatus.pending,
      paymentMethod: PaymentMethod.qris,
      paymentStatus: PaymentStatus.paid,
      totalAmount: 44000,
      taxAmount: 4000,
      createdAt: DateTime.now(),
      items: [
        OrderItemModel(
          id: nextItemId,
          orderId: nextOrderId,
          productId: 1,
          productName: 'Ayam Bakar Madu',
          categoryName: 'Makanan',
          qty: 1,
          price: 28000,
          status: OrderItemStatus.pending,
        ),
        OrderItemModel(
          id: nextItemId + 1,
          orderId: nextOrderId,
          productId: 10,
          productName: 'Es Teh Manis',
          categoryName: 'Minuman',
          qty: 1,
          price: 6000,
          status: OrderItemStatus.pending,
        ),
      ],
    );

    ref.read(kitchenOrdersProvider.notifier).insertIncomingOrder(order);
    ref.read(kitchenPageIndexProvider.notifier).select(0);
    announce(order);
  }
}
