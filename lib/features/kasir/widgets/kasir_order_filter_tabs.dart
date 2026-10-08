import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/incoming_order_filter.dart';
import '../providers/incoming_orders_provider.dart';
import '../providers/kasir_incoming_alert_provider.dart';
import 'kasir_order_filter_chip_item.dart';

class KasirOrderFilterTabs extends ConsumerWidget {
  const KasirOrderFilterTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(incomingOrdersProvider).value ?? [];
    final newOrderIds = ref.watch(
      kasirIncomingAlertProvider.select((state) => state.newOrderIds),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: List.generate(IncomingOrderFilter.values.length, (index) {
          final filter = IncomingOrderFilter.values[index];
          final badgeCount = orders
              .where(
                (order) =>
                    filter.matches(order) &&
                    order.id != null &&
                    newOrderIds.contains(order.id),
              )
              .length;

          return KasirOrderFilterChipItem(
            label: filter.label,
            badgeCount: badgeCount,
            isSelected: ref.watch(incomingOrderFilterStateProvider) == filter,
            onTap: () =>
                ref.read(incomingOrderFilterStateProvider.notifier).select(filter),
          );
        }),
      ),
    );
  }
}
