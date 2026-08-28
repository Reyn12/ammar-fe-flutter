import 'package:flutter/material.dart';

import '../../../helper/status_color_helper.dart';
import '../../../models/order_enums.dart';
import '../../../models/order_item_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/status_pill.dart';

class KitchenOrderItemRow extends StatelessWidget {
  const KitchenOrderItemRow({super.key, required this.item, required this.onTap});

  final OrderItemModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            // TODO: ganti Material icon ini dengan asset ikon final.
            Icon(
              item.status == OrderItemStatus.ready
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              size: 20,
              color: orderItemStatusColor(item.status).foreground,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 3,
                children: [
                  Text(
                    '${item.qty ?? 0}× ${item.productName ?? '-'}',
                    style: AppTypography.bodySemiboldM.copyWith(
                      color: item.status == OrderItemStatus.ready
                          ? AppColors.neutral60
                          : AppColors.neutral100,
                      height: 1.3,
                      decoration: item.status == OrderItemStatus.ready
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  if ((item.addons ?? []).isNotEmpty)
                    Text(
                      (item.addons ?? []).map((addon) => addon.name).join(', '),
                      style: AppTypography.bodyRegularS.copyWith(
                        color: AppColors.neutral70,
                        height: 1.3,
                      ),
                    ),
                  if ((item.notes ?? '').isNotEmpty)
                    Text(
                      'Catatan: ${item.notes}',
                      style: AppTypography.bodyRegularS.copyWith(
                        color: AppColors.warningPressed,
                        height: 1.3,
                      ),
                    ),
                ],
              ),
            ),
            StatusPill(
              label: item.status?.label ?? '-',
              foregroundColor: orderItemStatusColor(item.status).foreground,
              backgroundColor: orderItemStatusColor(item.status).background,
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}
