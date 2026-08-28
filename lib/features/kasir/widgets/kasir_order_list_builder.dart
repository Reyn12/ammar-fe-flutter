import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/order_model.dart';
import '../../../widget/empty_state.dart';
import '../providers/incoming_orders_provider.dart';
import 'kasir_order_card_item.dart';

class KasirOrderListBuilder extends ConsumerWidget {
  const KasirOrderListBuilder({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (orders.isEmpty) {
      return const Center(
        child: EmptyState(
          title: 'Belum ada pesanan',
          subtitle: 'Pesanan yang sudah dibayar pelanggan akan muncul di sini.',
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return KasirOrderCardItem(
          order: orders[index],
          isSelected:
              ref.watch(selectedOrderIdProvider) == orders[index].id,
          onTap: () => ref
              .read(selectedOrderIdProvider.notifier)
              .select(orders[index].id),
        );
      },
    );
  }
}
