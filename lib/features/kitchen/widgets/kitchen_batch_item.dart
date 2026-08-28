import 'package:flutter/material.dart';

import '../../../helper/status_color_helper.dart';
import '../../../models/order_enums.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/status_pill.dart';
import '../../../widget/surface_card.dart';
import '../models/kitchen_batch_model.dart';
import 'kitchen_batch_table_chip_item.dart';

class KitchenBatchItem extends StatelessWidget {
  const KitchenBatchItem({
    super.key,
    required this.batch,
    required this.onProcessAll,
  });

  final KitchenBatchModel batch;
  final VoidCallback onProcessAll;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Expanded(
                child: Text(
                  batch.productName ?? '-',
                  style: AppTypography.bodySemiboldL.copyWith(
                    color: AppColors.neutral100,
                    height: 1.25,
                  ),
                ),
              ),
              Text(
                '${batch.totalQty ?? 0}',
                style: AppTypography.h5Bold.copyWith(
                  color: AppColors.orangeMain,
                  height: 1,
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate((batch.tables ?? []).length, (index) {
              return KitchenBatchTableChipItem(
                tableLabel: (batch.tables ?? [])[index].tableLabel ?? '-',
                qty: (batch.tables ?? [])[index].qty ?? 0,
              );
            }),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              StatusPill(
                label:
                    '${batch.notaCount}/${KitchenBatchModel.maxNotaPerBatch} nota',
                foregroundColor: batch.isFull
                    ? AppColors.dangerMain
                    : AppColors.neutral70,
                backgroundColor: batch.isFull
                    ? AppColors.dangerSurface
                    : AppColors.neutral20,
                dense: true,
              ),
              StatusPill(
                label: batch.status?.label ?? '-',
                foregroundColor: orderItemStatusColor(batch.status).foreground,
                backgroundColor: orderItemStatusColor(batch.status).background,
                dense: true,
              ),
            ],
          ),
          PrimaryButton(
            text: batch.status == OrderItemStatus.pending
                ? 'Process All'
                : 'Sudah Diproses',
            color: AppColors.orangeMain,
            height: 42,
            radiusValue: 10,
            enabled: batch.status == OrderItemStatus.pending,
            onPressed: onProcessAll,
          ),
        ],
      ),
    );
  }
}
