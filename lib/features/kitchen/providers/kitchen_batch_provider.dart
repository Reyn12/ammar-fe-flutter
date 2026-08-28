import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/kitchen_batch_mocks.dart';
import '../../../models/order_enums.dart';
import '../models/kitchen_batch_model.dart';
import 'kitchen_board_provider.dart';

part 'kitchen_batch_provider.g.dart';

@riverpod
class KitchenBatches extends _$KitchenBatches {
  @override
  Future<List<KitchenBatchModel>> build() async {
    // TODO: ganti mock ini dengan GET /v1/kitchen/batches.
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return KitchenBatchMocks.batches;
  }

  /// SKPL-F-010 — satu aksi memasak untuk banyak nota sekaligus.
  Future<void> processAll(int batchId) async {
    // TODO: ganti dengan POST /v1/kitchen/batches/{id}/process.
    state = AsyncData([
      for (final batch in state.value ?? <KitchenBatchModel>[])
        if (batch.id == batchId)
          batch.copyWith(status: OrderItemStatus.cooking)
        else
          batch,
    ]);

    for (final batch in state.value ?? <KitchenBatchModel>[]) {
      if (batch.id == batchId) {
        await ref
            .read(kitchenOrdersProvider.notifier)
            .markProductCooking(batch.productId ?? 0);
      }
    }
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
