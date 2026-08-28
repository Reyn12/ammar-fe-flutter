import 'package:flutter/material.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../helper/format_time_helper.dart';
import '../../../helper/status_color_helper.dart';
import '../../../models/order_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/status_pill.dart';

class KasirTransactionItem extends StatelessWidget {
  const KasirTransactionItem({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              order.code ?? '-',
              style: AppTypography.bodySemiboldM.copyWith(
                color: AppColors.neutral100,
                height: 1.2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              order.createdAt == null ? '-' : formatClock(order.createdAt!),
              style: AppTypography.bodyRegularM.copyWith(
                color: AppColors.neutral70,
                height: 1.2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '${order.orderType?.label ?? '-'} · ${order.placeLabel}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodyRegularM.copyWith(
                color: AppColors.neutral70,
                height: 1.2,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: StatusPill(
                label: order.paymentMethod?.label ?? '-',
                foregroundColor: paymentStatusColor(
                  order.paymentStatus,
                ).foreground,
                backgroundColor: paymentStatusColor(
                  order.paymentStatus,
                ).background,
                dense: true,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              formatRupiah(order.totalAmount ?? 0),
              textAlign: TextAlign.end,
              style: AppTypography.bodySemiboldM.copyWith(
                color: AppColors.neutral100,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
