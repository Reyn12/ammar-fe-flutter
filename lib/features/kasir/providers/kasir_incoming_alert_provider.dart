import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helper/order_sound_provider.dart';
import '../../../models/order_model.dart';
import '../models/kasir_incoming_state.dart';
import '../models/kasir_incoming_toast_model.dart';

part 'kasir_incoming_alert_provider.g.dart';

/// Alert pesanan baru di kasir (toast + highlight card + badge filter).
/// Dipicu event SSE dari backend (lihat KasirShellPage / KitchenBoardPage).
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

    unawaited(ref.read(orderSoundProvider).play());

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
}
