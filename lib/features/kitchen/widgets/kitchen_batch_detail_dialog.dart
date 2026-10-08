import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/order_enums.dart';
import '../../../models/order_item_model.dart';
import '../../../models/order_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';
import '../models/kitchen_batch_model.dart';
import '../models/kitchen_batch_table_model.dart';
import '../providers/kitchen_action_provider.dart';
import '../providers/kitchen_board_provider.dart';

class KitchenBatchDetailDialog extends ConsumerStatefulWidget {
  const KitchenBatchDetailDialog({super.key, required this.batch});

  final KitchenBatchModel batch;

  static Future<void> show(BuildContext context, KitchenBatchModel batch) {
    return showDialog<void>(
      context: context,
      builder: (_) => KitchenBatchDetailDialog(batch: batch),
    );
  }

  @override
  ConsumerState<KitchenBatchDetailDialog> createState() =>
      _KitchenBatchDetailDialogState();
}

class _KitchenBatchDetailDialogState
    extends ConsumerState<KitchenBatchDetailDialog> {
  late Set<int> selectedOrderIds;

  KitchenBatchModel get batch => widget.batch;

  List<KitchenBatchTableModel> get tables => batch.tables ?? [];

  @override
  void initState() {
    super.initState();
    // Default semua terpilih; koki tinggal uncheck yang belum sanggup.
    selectedOrderIds = {
      for (final table in tables)
        if (table.orderId != null) table.orderId!,
    };
  }

  int get selectedQty {
    var total = 0;
    for (final table in tables) {
      if (selectedOrderIds.contains(table.orderId)) {
        total += table.qty ?? 0;
      }
    }
    return total;
  }

  OrderItemModel? itemForTable(
    KitchenBatchTableModel table,
    List<OrderModel> orders,
  ) {
    for (final order in orders) {
      if (order.id != table.orderId) continue;
      for (final item in order.items ?? <OrderItemModel>[]) {
        if (item.productId == batch.productId &&
            item.status == OrderItemStatus.pending) {
          return item;
        }
      }
    }
    return null;
  }

  void toggleOrder(int orderId) {
    setState(() {
      if (selectedOrderIds.contains(orderId)) {
        selectedOrderIds.remove(orderId);
      } else {
        selectedOrderIds.add(orderId);
      }
    });
  }

  void toggleSelectAll() {
    setState(() {
      if (selectedOrderIds.length == tables.length) {
        selectedOrderIds.clear();
      } else {
        selectedOrderIds = {
          for (final table in tables)
            if (table.orderId != null) table.orderId!,
        };
      }
    });
  }

  Future<void> submit() async {
    final orderIds = selectedOrderIds.toList();
    Navigator.of(context).pop();
    await ref.read(kitchenActionControllerProvider.notifier).processBatch(
          batchId: batch.id ?? 0,
          productId: batch.productId ?? 0,
          orderIds: orderIds,
        );
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(kitchenOrdersProvider).value ?? <OrderModel>[];
    final isBusy = ref.watch(kitchenActionControllerProvider).isLoading;
    final allSelected =
        selectedOrderIds.length == tables.length && tables.isNotEmpty;

    return Dialog(
      backgroundColor: AppColors.neutral10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 640),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                          batch.productName ?? '-',
                          style: AppTypography.h8Bold.copyWith(
                            color: AppColors.neutral100,
                          ),
                        ),
                        Text(
                          'Pilih nota yang mau diproses sekarang. '
                          'Total batch: ${batch.totalQty ?? 0} porsi.',
                          style: AppTypography.bodyRegularM.copyWith(
                            color: AppColors.neutral70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: toggleSelectAll,
                    child: Text(
                      allSelected ? 'Hapus pilihan' : 'Pilih semua',
                      style: AppTypography.bodySemiboldS.copyWith(
                        color: AppColors.orangeMain,
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: tables.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final table = tables[index];
                    final orderId = table.orderId ?? 0;
                    final item = itemForTable(table, orders);
                    final isSelected = selectedOrderIds.contains(orderId);
                    final notes = item?.notes;
                    final addons = (item?.addons ?? [])
                        .map((addon) => addon.name)
                        .whereType<String>()
                        .join(', ');

                    return InkWell(
                      onTap: () => toggleOrder(orderId),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.orangeMain.withValues(alpha: 0.06)
                              : AppColors.neutral20,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.orangeMain
                                : AppColors.neutral30,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_box_rounded
                                  : Icons.check_box_outline_blank_rounded,
                              color: isSelected
                                  ? AppColors.orangeMain
                                  : AppColors.neutral50,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${table.tableLabel ?? '-'} · '
                                          '${table.orderCode ?? '-'}',
                                          style: AppTypography.bodySemiboldM
                                              .copyWith(
                                            color: AppColors.neutral100,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '×${table.qty ?? 0}',
                                        style: AppTypography.bodySemiboldM
                                            .copyWith(
                                          color: AppColors.neutral100,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (addons.isNotEmpty)
                                    Text(
                                      addons,
                                      style: AppTypography.bodyRegularS
                                          .copyWith(color: AppColors.neutral70),
                                    ),
                                  if ((notes ?? '').isNotEmpty)
                                    Text(
                                      'Catatan: $notes',
                                      style: AppTypography.bodyRegularS
                                          .copyWith(
                                        color: AppColors.warningPressed,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Batal',
                      reverse: true,
                      borderColor: AppColors.neutral40,
                      textColor: AppColors.neutral80,
                      height: 48,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: PrimaryButton(
                      text: selectedQty == 0
                          ? 'Pilih nota dulu'
                          : 'Proses $selectedQty porsi',
                      color: AppColors.orangeMain,
                      height: 48,
                      enabled: !isBusy && selectedQty > 0,
                      onPressed: submit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
