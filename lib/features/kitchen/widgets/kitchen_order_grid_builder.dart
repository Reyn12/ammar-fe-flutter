import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/order_model.dart';
import '../../../widget/empty_state.dart';
import '../providers/kitchen_board_provider.dart';
import 'kitchen_order_card_item.dart';

class KitchenOrderGridBuilder extends ConsumerWidget {
  const KitchenOrderGridBuilder({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (orders.isEmpty) {
      return const Center(
        child: EmptyState(
          title: 'Tidak ada pesanan',
          subtitle: 'Semua pesanan sudah selesai diproses. Kerja bagus!',
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 420,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.15,
      ),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return KitchenOrderCardItem(
          order: orders[index],
          onProcess: (itemIds) => ref
              .read(kitchenOrdersProvider.notifier)
              .processSelectedItems(orders[index].id ?? 0, itemIds),
          onServe: (itemIds) => ref
              .read(kitchenOrdersProvider.notifier)
              .serveSelectedItems(orders[index].id ?? 0, itemIds),
        );
      },
    );
  }
}
