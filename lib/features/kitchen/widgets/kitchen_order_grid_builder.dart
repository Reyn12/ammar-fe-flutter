import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/order_model.dart';
import '../../../widget/empty_state.dart';
import '../providers/kitchen_action_provider.dart';
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

    final isBusy = ref.watch(kitchenActionControllerProvider).isLoading;

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 420,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        // Card lebih tinggi biar list item + scrollbar kebaca.
        childAspectRatio: 0.9,
      ),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return KitchenOrderCardItem(
          order: order,
          onProcess: isBusy
              ? (_) {}
              : (itemIds) => ref
                    .read(kitchenActionControllerProvider.notifier)
                    .processSelectedItems(order.id ?? 0, itemIds),
          onServe: isBusy
              ? (_) {}
              : (itemIds) => ref
                    .read(kitchenActionControllerProvider.notifier)
                    .serveSelectedItems(order.id ?? 0, itemIds),
        );
      },
    );
  }
}
