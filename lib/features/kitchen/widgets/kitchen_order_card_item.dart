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
    required this.onProcess,
    required this.onServe,
  });

  final OrderModel order;
  final void Function(List<int> itemIds) onProcess;
  final void Function(List<int> itemIds) onServe;

  @override
  State<KitchenOrderCardItem> createState() => _KitchenOrderCardItemState();
}

class _KitchenOrderCardItemState extends State<KitchenOrderCardItem> {
  final Set<int> selectedItemIds = {};
  final ScrollController itemsScrollController = ScrollController();

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
  void didUpdateWidget(covariant KitchenOrderCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
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
    final ids = selectedItemIds.toList();
    setState(selectedItemIds.clear);
    action(ids);
  }

  @override
  void dispose() {
    itemsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = selectedItemIds.length;
    final currentSelectionStatus = selectionStatus;

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
                padding: EdgeInsets.zero,
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
    );
  }
}
