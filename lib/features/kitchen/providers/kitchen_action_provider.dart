import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/order_enums.dart';
import '../../../network/api_service.dart';
import 'kitchen_batch_provider.dart';
import 'kitchen_board_provider.dart';

part 'kitchen_action_provider.g.dart';

/// Aksi kitchen (proses/sajikan/process-all) — loading dialog via DialogMixin.
@riverpod
class KitchenActionController extends _$KitchenActionController {
  @override
  FutureOr<bool?> build() => null;

  Future<void> processSelectedItems(int orderId, List<int> itemIds) async {
    if (itemIds.isEmpty) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(apiServiceProvider).updateOrderItemsStatus(
            itemIds: itemIds,
            status: OrderItemStatus.cooking,
          );
      ref
          .read(kitchenOrdersProvider.notifier)
          .applyProcessSelected(orderId, itemIds);
      return true;
    });
    resetAfterAction();
  }

  Future<void> serveSelectedItems(int orderId, List<int> itemIds) async {
    if (itemIds.isEmpty) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(apiServiceProvider).updateOrderItemsStatus(
            itemIds: itemIds,
            status: OrderItemStatus.ready,
          );
      ref
          .read(kitchenOrdersProvider.notifier)
          .applyServeSelected(orderId, itemIds);
      return true;
    });
    resetAfterAction();
  }

  Future<void> processBatch(int batchId, int productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(apiServiceProvider).processKitchenBatch(batchId);
      await ref
          .read(kitchenBatchesProvider.notifier)
          .applyProcessAll(batchId, productId);
      return true;
    });
    resetAfterAction();
  }

  /// Biar aksi berikutnya bisa trigger listenAction lagi.
  void resetAfterAction() {
    Future<void>.microtask(() {
      if (!ref.mounted) return;
      if (state.hasValue) {
        state = const AsyncData(null);
      }
    });
  }
}
