import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/order_enums.dart';
import '../../../models/order_item_model.dart';
import '../../../models/order_model.dart';
import '../models/kasir_incoming_state.dart';
import '../models/kasir_incoming_toast_model.dart';
import '../models/kasir_nav_item.dart';
import 'incoming_orders_provider.dart';
import 'kasir_nav_provider.dart';

part 'kasir_incoming_alert_provider.g.dart';

/// Alert pesanan baru di kasir (toast + highlight card + badge filter).
/// Nanti bisa dipicu SSE; sekarang ada simulate buat UI.
@riverpod
class KasirIncomingAlert extends _$KasirIncomingAlert {
  final Map<int, Timer> clearNewTimers = {};
  Timer? toastTimer;

  @override
  KasirIncomingState build() {
    ref.onDispose(() {
      for (final timer in clearNewTimers.values) {
        timer.cancel();
      }
      toastTimer?.cancel();
    });
    return const KasirIncomingState();
  }

  void announce(OrderModel order) {
    final orderId = order.id;
    if (orderId == null) return;

    state = state.copyWith(
      newOrderIds: {...state.newOrderIds, orderId},
      toast: KasirIncomingToastModel(
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

  /// Simulasi SSE: pesanan baru masuk + toast + highlight.
  void simulateIncomingOrder() {
    final current = ref.read(incomingOrdersProvider).value ?? <OrderModel>[];
    final nextOrderId =
        (current.map((order) => order.id ?? 0).fold(0, (a, b) => a > b ? a : b)) +
        1;
    final nextItemId =
        current
            .expand((order) => order.items ?? <OrderItemModel>[])
            .map((item) => item.id ?? 0)
            .fold(0, (a, b) => a > b ? a : b) +
        1;

    final isCash = nextOrderId.isOdd;
    final order = OrderModel(
      id: nextOrderId,
      code: '#AMR$nextOrderId',
      shiftId: 1,
      tableId: isCash ? null : 8,
      tableNumber: isCash ? null : '08',
      branchId: 1,
      customerName: isCash ? 'Walk-in' : 'Pelanggan Baru',
      orderType: isCash ? OrderType.takeaway : OrderType.dineIn,
      status: OrderStatus.pending,
      paymentMethod: isCash ? PaymentMethod.cash : PaymentMethod.qris,
      paymentStatus: isCash ? PaymentStatus.unpaid : PaymentStatus.paid,
      totalAmount: isCash ? 56000 : 44000,
      taxAmount: isCash ? 5091 : 4000,
      createdAt: DateTime.now(),
      items: [
        OrderItemModel(
          id: nextItemId,
          orderId: nextOrderId,
          productId: 1,
          productName: 'Ayam Bakar Madu',
          categoryName: 'Makanan',
          qty: isCash ? 2 : 1,
          price: 28000,
          status: OrderItemStatus.pending,
        ),
      ],
    );

    ref.read(incomingOrdersProvider.notifier).insertIncomingOrder(order);
    ref.read(kasirNavProvider.notifier).select(KasirNavItem.incomingOrders);
    ref.read(kasirOrderPageIndexProvider.notifier).select(0);
    ref.read(selectedOrderIdProvider.notifier).select(order.id);
    announce(order);
  }
}
