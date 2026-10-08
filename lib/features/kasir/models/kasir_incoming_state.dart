import 'kasir_incoming_toast_model.dart';

class KasirIncomingState {
  const KasirIncomingState({
    this.newOrderIds = const {},
    this.toast,
  });

  final Set<int> newOrderIds;
  final KasirIncomingToastModel? toast;

  bool isNew(int orderId) => newOrderIds.contains(orderId);

  KasirIncomingState copyWith({
    Set<int>? newOrderIds,
    KasirIncomingToastModel? toast,
    bool clearToast = false,
  }) {
    return KasirIncomingState(
      newOrderIds: newOrderIds ?? this.newOrderIds,
      toast: clearToast ? null : (toast ?? this.toast),
    );
  }
}
