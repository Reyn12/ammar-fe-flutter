import 'package:flutter/material.dart';

import '../../../helper/format_time_helper.dart';
import '../../../models/order_enums.dart';
import '../../../models/order_item_model.dart';
import '../../../models/order_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/status_pill.dart';
import '../../../widget/surface_card.dart';
import 'kitchen_order_item_row.dart';

class KitchenOrderCardItem extends StatefulWidget {
  const KitchenOrderCardItem({
    super.key,
    required this.order,
    required this.isNew,
    required this.onProcess,
    required this.onServe,
    required this.onSeen,
  });

  final OrderModel order;
  final bool isNew;
  final void Function(List<int> itemIds) onProcess;
  final void Function(List<int> itemIds) onServe;
  final VoidCallback onSeen;

  @override
  State<KitchenOrderCardItem> createState() => _KitchenOrderCardItemState();
}

class _KitchenOrderCardItemState extends State<KitchenOrderCardItem>
    with SingleTickerProviderStateMixin {
  final Set<int> selectedItemIds = {};
  final ScrollController itemsScrollController = ScrollController();
  late final AnimationController pulseController;

  OrderModel get order => widget.order;

  List<OrderItemModel> get items => order.items ?? [];

  /// Warna timer makin mendesak seiring lamanya pesanan menunggu.
  Color get timerColor {
    if (order.createdAt == null) return AppColors.neutral70;
    if (DateTime.now().difference(order.createdAt!).inMinutes >= 10) {
      return AppColors.dangerMain;
    }
    if (DateTime.now().difference(order.createdAt!).inMinutes >= 5) {
      return AppColors.orangeMain;
    }
    return AppColors.successMain;
  }

  Color get borderColor {
    if (widget.isNew) return AppColors.orangeMain;
    if (order.status == OrderStatus.ready) return AppColors.successBorder;
    return AppColors.neutral30;
  }

  OrderItemModel? itemById(int id) {
    for (final item in items) {
      if (item.id == id) return item;
    }
    return null;
  }

  /// Status item yang lagi dipilih (pending = proses, cooking = sajikan).
  OrderItemStatus? get selectionStatus {
    for (final id in selectedItemIds) {
      final status = itemById(id)?.status;
      if (status != null) return status;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    if (widget.isNew) {
      pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant KitchenOrderCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isNew && !oldWidget.isNew) {
      pulseController.repeat(reverse: true);
    } else if (!widget.isNew && oldWidget.isNew) {
      pulseController.stop();
      pulseController.value = 0;
    }

    // Buang selection yang udah ready / hilang biar state tetap rapi.
    final validIds = items
        .where(
          (item) =>
              item.status == OrderItemStatus.pending ||
              item.status == OrderItemStatus.cooking,
        )
        .map((item) => item.id ?? 0)
        .where((id) => id != 0)
        .toSet();
    selectedItemIds.removeWhere((id) => !validIds.contains(id));
  }

  void toggleItem(OrderItemModel item) {
    final itemId = item.id ?? 0;
    if (itemId == 0) return;
    if (item.status == OrderItemStatus.ready) return;

    if (widget.isNew) widget.onSeen();

    setState(() {
      if (selectedItemIds.contains(itemId)) {
        selectedItemIds.remove(itemId);
        return;
      }

      // Satu aksi per klik button: jangan campur pending + cooking.
      final currentStatus = selectionStatus;
      if (currentStatus != null && currentStatus != item.status) {
        selectedItemIds.clear();
      }
      selectedItemIds.add(itemId);
    });
  }

  void runAction(void Function(List<int> itemIds) action) {
    if (widget.isNew) widget.onSeen();
    final ids = selectedItemIds.toList();
    setState(selectedItemIds.clear);
    action(ids);
  }

  @override
  void dispose() {
    pulseController.dispose();
    itemsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = selectedItemIds.length;
    final currentSelectionStatus = selectionStatus;

    return AnimatedBuilder(
      animation: pulseController,
      builder: (context, child) {
        final glow = widget.isNew ? pulseController.value * 0.35 : 0.0;
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
        padding: const EdgeInsets.all(16),
        borderColor: borderColor,
        borderWidth: widget.isNew ? 1.8 : 1,
        backgroundColor: widget.isNew
            ? AppColors.orangeMain.withValues(alpha: 0.04)
            : null,
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
                      Row(
                        spacing: 8,
                        children: [
                          Flexible(
                            child: Text(
                              order.code ?? '-',
                              style: AppTypography.h8Bold.copyWith(
                                color: AppColors.neutral100,
                                height: 1.2,
                              ),
                            ),
                          ),
                          if (widget.isNew)
                            StatusPill(
                              label: 'BARU',
                              foregroundColor: AppColors.neutral10,
                              backgroundColor: AppColors.orangeMain,
                              dense: true,
                            ),
                        ],
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
                  foregroundColor: timerColor,
                  backgroundColor: timerColor.withValues(alpha: 0.12),
                ),
              ],
            ),
            const Divider(height: 1, color: AppColors.neutral30),
            Expanded(
              child: Scrollbar(
                controller: itemsScrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: itemsScrollController,
                  padding: const EdgeInsets.only(right: 4),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return KitchenOrderItemRow(
                      item: item,
                      isSelected: selectedItemIds.contains(item.id ?? 0),
                      onTap: () => toggleItem(item),
                    );
                  },
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.neutral30),
            if (order.status == OrderStatus.ready)
              PrimaryButton(
                text: 'Siap Disajikan',
                color: AppColors.successMain,
                height: 46,
                radiusValue: 10,
                enabled: false,
                onPressed: () {},
              )
            else if (currentSelectionStatus == OrderItemStatus.cooking)
              PrimaryButton(
                text: 'Sajikan Makanan · $selectedCount dipilih',
                color: AppColors.successMain,
                height: 46,
                radiusValue: 10,
                onPressed: () => runAction(widget.onServe),
              )
            else if (currentSelectionStatus == OrderItemStatus.pending)
              PrimaryButton(
                text: 'Proses Makanan · $selectedCount dipilih',
                color: AppColors.orangeMain,
                height: 46,
                radiusValue: 10,
                onPressed: () => runAction(widget.onProcess),
              )
            else
              PrimaryButton(
                text: 'Pilih menu · ${order.remainingItemCount} tersisa',
                color: AppColors.orangeMain,
                height: 46,
                radiusValue: 10,
                enabled: false,
                onPressed: () {},
              ),
          ],
        ),
      ),
    );
  }
}
