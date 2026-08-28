import 'package:flutter/material.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../helper/format_time_helper.dart';
import '../../../helper/status_color_helper.dart';
import '../../../models/order_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/status_pill.dart';
import '../../../widget/surface_card.dart';

class KasirOrderCardItem extends StatelessWidget {
  const KasirOrderCardItem({
    super.key,
    required this.order,
    required this.isSelected,
    required this.onTap,
  });

  final OrderModel order;
  final bool isSelected;
  final VoidCallback onTap;

  String get _itemSummary => (order.items ?? [])
      .map((item) => '${item.qty ?? 0}× ${item.productName ?? '-'}')
      .join('  ·  ');

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      onTap: onTap,
      borderColor: isSelected ? AppColors.primaryMain : AppColors.neutral30,
      borderWidth: isSelected ? 1.6 : 1,
      backgroundColor: isSelected
          ? AppColors.primarySurface.withValues(alpha: 0.45)
          : AppColors.neutral10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            spacing: 12,
            children: [
              Text(
                order.code ?? '-',
                style: AppTypography.h9Bold.copyWith(
                  color: AppColors.neutral100,
                  height: 1.2,
                ),
              ),
              const Spacer(),
              // TODO: ganti Material icon ini dengan asset ikon final.
              const Icon(
                Icons.schedule_rounded,
                size: 15,
                color: AppColors.neutral60,
              ),
              Text(
                order.createdAt == null
                    ? '-'
                    : '${formatClock(order.createdAt!)} · ${formatElapsed(order.createdAt!)}',
                style: AppTypography.bodyRegularS.copyWith(
                  color: AppColors.neutral70,
                  height: 1.2,
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              StatusPill(
                label: order.placeLabel,
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: order.isTakeaway
                    ? Icons.shopping_bag_rounded
                    : Icons.table_restaurant_rounded,
                foregroundColor: AppColors.neutral80,
                backgroundColor: AppColors.neutral20,
                dense: true,
              ),
              StatusPill(
                label: order.needCashConfirmation
                    ? 'Menunggu Konfirmasi Tunai'
                    : 'Dibayar · ${order.paymentMethod?.label ?? '-'}',
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: order.needCashConfirmation
                    ? Icons.pending_actions_rounded
                    : Icons.verified_rounded,
                foregroundColor: order.needCashConfirmation
                    ? paymentStatusColor(order.paymentStatus).foreground
                    : AppColors.successMain,
                backgroundColor: order.needCashConfirmation
                    ? paymentStatusColor(order.paymentStatus).background
                    : AppColors.successSoft,
                dense: true,
              ),
              StatusPill(
                label: order.status?.label ?? '-',
                foregroundColor: orderStatusColor(order.status).foreground,
                backgroundColor: orderStatusColor(order.status).background,
                dense: true,
              ),
            ],
          ),
          Text(
            _itemSummary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodyRegularM.copyWith(
              color: AppColors.neutral70,
              height: 1.35,
            ),
          ),
          const Divider(height: 1, color: AppColors.neutral30),
          Row(
            children: [
              Text(
                '${order.totalQty} item',
                style: AppTypography.bodyRegularS.copyWith(
                  color: AppColors.neutral70,
                ),
              ),
              const Spacer(),
              Text(
                formatRupiah(order.totalAmount ?? 0),
                style: AppTypography.h9Bold.copyWith(
                  color: AppColors.primaryMain,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
