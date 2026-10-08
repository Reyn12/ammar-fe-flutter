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
  final Set<int> _selectedItemIds = {};

  OrderModel get order => widget.order;

  List<OrderItemModel> get _items => order.items ?? [];

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

  OrderItemModel? _itemById(int id) {
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }

  /// Status item yang lagi dipilih (pending = proses, cooking = sajikan).
  OrderItemStatus? get _selectionStatus {
    for (final id in _selectedItemIds) {
      final status = _itemById(id)?.status;
      if (status != null) return status;
    }
    return null;
  }

  @override
  void didUpdateWidget(covariant KitchenOrderCardItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Buang selection yang udah ready / hilang biar state tetap rapi.
    final validIds = _items
        .where(
          (item) =>
              item.status == OrderItemStatus.pending ||
              item.status == OrderItemStatus.cooking,
        )
        .map((item) => item.id ?? 0)
        .where((id) => id != 0)
        .toSet();
    _selectedItemIds.removeWhere((id) => !validIds.contains(id));
  }

  void _toggleItem(OrderItemModel item) {
    final itemId = item.id ?? 0;
    if (itemId == 0) return;
    if (item.status == OrderItemStatus.ready) return;

    setState(() {
      if (_selectedItemIds.contains(itemId)) {
        _selectedItemIds.remove(itemId);
        return;
      }

      // Satu aksi per klik button: jangan campur pending + cooking.
      final currentStatus = _selectionStatus;
      if (currentStatus != null && currentStatus != item.status) {
        _selectedItemIds.clear();
      }
      _selectedItemIds.add(itemId);
    });
  }

  void _runAction(void Function(List<int> itemIds) action) {
    final ids = _selectedItemIds.toList();
    setState(_selectedItemIds.clear);
    action(ids);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _selectedItemIds.length;
    final selectionStatus = _selectionStatus;

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
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return KitchenOrderItemRow(
                  item: item,
                  isSelected: _selectedItemIds.contains(item.id ?? 0),
                  onTap: () => _toggleItem(item),
                );
              },
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
          else if (selectionStatus == OrderItemStatus.cooking)
            PrimaryButton(
              text: 'Sajikan Makanan · $selectedCount dipilih',
              color: AppColors.successMain,
              height: 46,
              radiusValue: 10,
              onPressed: () => _runAction(widget.onServe),
            )
          else if (selectionStatus == OrderItemStatus.pending)
            PrimaryButton(
              text: 'Proses Makanan · $selectedCount dipilih',
              color: AppColors.orangeMain,
              height: 46,
              radiusValue: 10,
              onPressed: () => _runAction(widget.onProcess),
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
