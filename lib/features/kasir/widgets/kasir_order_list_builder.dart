import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/order_model.dart';
import '../../../widget/empty_state.dart';
import '../providers/incoming_orders_provider.dart';
import '../providers/kasir_incoming_alert_provider.dart';
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

    final newOrderIds = ref.watch(
      kasirIncomingAlertProvider.select((state) => state.newOrderIds),
    );

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 8),
      itemCount: orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = orders[index];
        final orderId = order.id ?? 0;
        final isNew = newOrderIds.contains(orderId);

        return KasirOrderCardItem(
          key: ValueKey('kasir-order-$orderId'),
          order: order,
          isSelected: ref.watch(selectedOrderIdProvider) == order.id,
          isNew: isNew,
          onTap: () =>
              ref.read(selectedOrderIdProvider.notifier).select(order.id),
          onSeen: () =>
              ref.read(kasirIncomingAlertProvider.notifier).clearNew(orderId),
        );
      },
    );
  }
}
