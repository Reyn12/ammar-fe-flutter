import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/order_enums.dart';
import '../../../network/api_service.dart';
import '../models/kitchen_batch_model.dart';
import 'kitchen_board_provider.dart';

part 'kitchen_batch_provider.g.dart';

@riverpod
class KitchenBatches extends _$KitchenBatches {
  @override
  Future<List<KitchenBatchModel>> build() async {
    return ref.watch(apiServiceProvider).fetchKitchenBatches();
  }

  /// Update lokal setelah POST process batch sukses.
  Future<void> applyProcessAll(int batchId, int productId) async {
    state = AsyncData([
      for (final batch in state.value ?? <KitchenBatchModel>[])
        if (batch.id == batchId)
          batch.copyWith(status: OrderItemStatus.cooking)
        else
          batch,
    ]);

    ref.read(kitchenOrdersProvider.notifier).applyMarkProductCooking(productId);
  }
}

/// Batch dikelompokkan per kategori untuk sidebar dapur.
@riverpod
Future<Map<String, List<KitchenBatchModel>>> groupedKitchenBatches(
  Ref ref,
) async {
  final grouped = <String, List<KitchenBatchModel>>{};

  for (final batch in await ref.watch(kitchenBatchesProvider.future)) {
    grouped.putIfAbsent(batch.categoryName ?? 'Lainnya', () => []).add(batch);
  }

  return grouped;
}
