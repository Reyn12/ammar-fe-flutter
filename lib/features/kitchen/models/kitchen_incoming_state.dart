import 'kitchen_incoming_toast_model.dart';

class KitchenIncomingState {
  const KitchenIncomingState({
    this.newOrderIds = const {},
    this.toast,
  });

  final Set<int> newOrderIds;
  final KitchenIncomingToastModel? toast;

  bool isNew(int orderId) => newOrderIds.contains(orderId);

  KitchenIncomingState copyWith({
    Set<int>? newOrderIds,
    KitchenIncomingToastModel? toast,
    bool clearToast = false,
  }) {
    return KitchenIncomingState(
      newOrderIds: newOrderIds ?? this.newOrderIds,
      toast: clearToast ? null : (toast ?? this.toast),
    );
  }
}
