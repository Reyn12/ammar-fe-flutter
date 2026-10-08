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

  /// Update lokal setelah POST process batch sukses — kartu batch dihapus dari antrean.
  Future<void> applyProcessAll(int batchId, int productId) async {
    state = AsyncData([
      for (final batch in state.value ?? <KitchenBatchModel>[])
        if (batch.id != batchId) batch,
    ]);

    ref.read(kitchenOrdersProvider.notifier).applyMarkProductCooking(productId);
  }
}

/// Batch aktif di sidebar: cuma yang masih pending (belum Process All).
@riverpod
Future<Map<String, List<KitchenBatchModel>>> groupedKitchenBatches(
  Ref ref,
) async {
  final grouped = <String, List<KitchenBatchModel>>{};

  for (final batch in await ref.watch(kitchenBatchesProvider.future)) {
    if (batch.status != OrderItemStatus.pending) continue;
    grouped.putIfAbsent(batch.categoryName ?? 'Lainnya', () => []).add(batch);
  }

  return grouped;
}
