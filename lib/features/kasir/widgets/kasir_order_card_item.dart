import 'package:flutter/material.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../helper/format_time_helper.dart';
import '../../../helper/status_color_helper.dart';
import '../../../models/order_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/status_pill.dart';
import '../../../widget/surface_card.dart';

class KasirOrderCardItem extends StatefulWidget {
  const KasirOrderCardItem({
    super.key,
    required this.order,
    required this.isSelected,
    required this.isNew,
    required this.onTap,
    required this.onSeen,
  });

  final OrderModel order;
  final bool isSelected;
  final bool isNew;
  final VoidCallback onTap;
  final VoidCallback onSeen;

  @override
  State<KasirOrderCardItem> createState() => _KasirOrderCardItemState();
}

class _KasirOrderCardItemState extends State<KasirOrderCardItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController pulseController;

  OrderModel get order => widget.order;

  String get _itemSummary => (order.items ?? [])
      .map((item) => '${item.qty ?? 0}× ${item.productName ?? '-'}')
      .join('  ·  ');

  Color get borderColor {
    if (widget.isNew) return AppColors.orangeMain;
    if (widget.isSelected) return AppColors.primaryMain;
    return AppColors.neutral30;
  }

  @override
  void initState() {
    super.initState();
    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    if (widget.isNew) pulseController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant KasirOrderCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isNew && !oldWidget.isNew) {
      pulseController.repeat(reverse: true);
    } else if (!widget.isNew && oldWidget.isNew) {
      pulseController.stop();
      pulseController.value = 0;
    }
  }

  @override
  void dispose() {
    pulseController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isNew) widget.onSeen();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseController,
      builder: (context, child) {
        final glow = widget.isNew ? pulseController.value * 0.18 : 0.0;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: widget.isNew
                ? [
                    BoxShadow(
                      color: AppColors.orangeMain.withValues(alpha: glow),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: child,
        );
      },
      child: SurfaceCard(
        onTap: _handleTap,
        borderColor: borderColor,
        borderWidth: widget.isNew || widget.isSelected ? 1.6 : 1,
        backgroundColor: widget.isNew
            ? AppColors.orangeMain.withValues(alpha: 0.04)
            : widget.isSelected
            ? AppColors.primarySurface.withValues(alpha: 0.45)
            : AppColors.neutral10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            Row(
              spacing: 8,
              children: [
                Flexible(
                  child: Row(
                    spacing: 8,
                    children: [
                      Flexible(
                        child: Text(
                          order.code ?? '-',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.h9Bold.copyWith(
                            color: AppColors.neutral100,
                            height: 1.2,
                          ),
                        ),
                      ),
                      if (widget.isNew)
                        const StatusPill(
                          label: 'BARU',
                          foregroundColor: AppColors.neutral10,
                          backgroundColor: AppColors.orangeMain,
                          dense: true,
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4,
                  children: [
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
      ),
    );
  }
}
