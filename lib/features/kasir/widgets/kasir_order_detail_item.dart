import 'package:flutter/material.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../helper/status_color_helper.dart';
import '../../../models/order_item_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/status_pill.dart';

class KasirOrderDetailItem extends StatelessWidget {
  const KasirOrderDetailItem({super.key, required this.item});

  final OrderItemModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.neutral20,
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            '${item.qty ?? 0}×',
            style: AppTypography.bodySemiboldS.copyWith(
              color: AppColors.neutral90,
              height: 1.2,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Text(
                      item.productName ?? '-',
                      style: AppTypography.bodySemiboldM.copyWith(
                        color: AppColors.neutral100,
                        height: 1.3,
                      ),
                    ),
                  ),
                  StatusPill(
                    label: item.status?.label ?? '-',
                    foregroundColor: orderItemStatusColor(
                      item.status,
                    ).foreground,
                    backgroundColor: orderItemStatusColor(
                      item.status,
                    ).background,
                    dense: true,
                  ),
                ],
              ),
              if ((item.addons ?? []).isNotEmpty)
                Text(
                  (item.addons ?? [])
                      .map(
                        (addon) => (addon.price ?? 0) > 0
                            ? '${addon.name} (+${formatRupiah(addon.price ?? 0)})'
                            : '${addon.name}',
                      )
                      .join(', '),
                  style: AppTypography.bodyRegularS.copyWith(
                    color: AppColors.neutral70,
                    height: 1.35,
                  ),
                ),
              if ((item.notes ?? '').isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    // TODO: ganti Material icon ini dengan asset ikon final.
                    const Icon(
                      Icons.sticky_note_2_outlined,
                      size: 14,
                      color: AppColors.warningPressed,
                    ),
                    Expanded(
                      child: Text(
                        item.notes ?? '',
                        style: AppTypography.bodyRegularS.copyWith(
                          color: AppColors.warningPressed,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        Text(
          formatRupiah(item.lineTotal),
          style: AppTypography.bodySemiboldM.copyWith(
            color: AppColors.neutral90,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
