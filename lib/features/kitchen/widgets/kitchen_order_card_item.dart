import 'package:flutter/material.dart';

import '../../../helper/format_time_helper.dart';
import '../../../models/order_enums.dart';
import '../../../models/order_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/status_pill.dart';
import '../../../widget/surface_card.dart';
import 'kitchen_order_item_row.dart';

class KitchenOrderCardItem extends StatelessWidget {
  const KitchenOrderCardItem({
    super.key,
    required this.order,
    required this.onProcess,
    required this.onServe,
    required this.onItemTap,
  });

  final OrderModel order;
  final VoidCallback onProcess;
  final VoidCallback onServe;
  final void Function(int itemId) onItemTap;

  /// Warna timer makin mendesak seiring lamanya pesanan menunggu.
  Color get _timerColor {
    if (order.createdAt == null) return AppColors.neutral70;
    if (DateTime.now().difference(order.createdAt!).inMinutes >= 10) {
      return AppColors.dangerMain;
    }
    if (DateTime.now().difference(order.createdAt!).inMinutes >= 5) {
      return AppColors.orangeMain;
    }
    return AppColors.successMain;
  }

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(16),
      borderColor: order.status == OrderStatus.ready
          ? AppColors.successBorder
          : AppColors.neutral30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.code ?? '-',
                      style: AppTypography.h8Bold.copyWith(
                        color: AppColors.neutral100,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      '${order.placeLabel} · ${order.customerName ?? '-'}',
                      style: AppTypography.bodyRegularM.copyWith(
                        color: AppColors.neutral70,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              StatusPill(
                label: order.createdAt == null
                    ? '-'
                    : formatElapsed(order.createdAt!),
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: Icons.timer_outlined,
                foregroundColor: _timerColor,
                backgroundColor: _timerColor.withValues(alpha: 0.12),
              ),
            ],
          ),
          const Divider(height: 1, color: AppColors.neutral30),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: (order.items ?? []).length,
              itemBuilder: (context, index) => KitchenOrderItemRow(
                item: (order.items ?? [])[index],
                onTap: () => onItemTap((order.items ?? [])[index].id ?? 0),
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.neutral30),
          if (order.status == OrderStatus.pending)
            PrimaryButton(
              text: 'Proses Makanan',
              color: AppColors.orangeMain,
              height: 46,
              radiusValue: 10,
              onPressed: onProcess,
            )
          else if (order.status == OrderStatus.ready)
            PrimaryButton(
              text: 'Siap Disajikan',
              color: AppColors.successMain,
              height: 46,
              radiusValue: 10,
              enabled: false,
              onPressed: () {},
            )
          else
            PrimaryButton(
              text: 'Sajikan Makanan · ${order.remainingItemCount} menu tersisa',
              color: AppColors.successMain,
              height: 46,
              radiusValue: 10,
              onPressed: onServe,
            ),
        ],
      ),
    );
  }
}
