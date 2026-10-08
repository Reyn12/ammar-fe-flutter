import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/order_enums.dart';
import '../../../network/api_service.dart';
import '../models/kitchen_batch_model.dart';
import '../models/kitchen_batch_table_model.dart';
import 'kitchen_board_provider.dart';

part 'kitchen_batch_provider.g.dart';

@riverpod
class KitchenBatches extends _$KitchenBatches {
  @override
  Future<List<KitchenBatchModel>> build() async {
    return ref.watch(apiServiceProvider).fetchKitchenBatches();
  }

  /// Proses sebagian/semua nota di batch.
  /// Nota terpilih dihapus; kalau habis, kartu batch ikut hilang.
  Future<void> applyProcessSelected({
    required int batchId,
    required int productId,
    required List<int> orderIds,
  }) async {
    if (orderIds.isEmpty) return;
    final selectedOrders = orderIds.toSet();

    state = AsyncData([
      for (final batch in state.value ?? <KitchenBatchModel>[])
        if (batch.id != batchId)
          batch
        else
          ?remainingBatch(batch, selectedOrders),
    ]);

    ref
        .read(kitchenOrdersProvider.notifier)
        .applyMarkProductCooking(productId: productId, orderIds: orderIds);
  }

  KitchenBatchModel? remainingBatch(
    KitchenBatchModel batch,
    Set<int> selectedOrders,
  ) {
    final remainingTables = <KitchenBatchTableModel>[
      for (final table in batch.tables ?? <KitchenBatchTableModel>[])
        if (!selectedOrders.contains(table.orderId)) table,
    ];
    if (remainingTables.isEmpty) return null;

    final totalQty = remainingTables.fold<int>(
      0,
      (sum, table) => sum + (table.qty ?? 0),
    );

    return batch.copyWith(tables: remainingTables, totalQty: totalQty);
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
