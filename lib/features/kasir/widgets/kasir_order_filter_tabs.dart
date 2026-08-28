import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/incoming_order_filter.dart';
import '../providers/incoming_orders_provider.dart';
import 'kasir_order_filter_chip_item.dart';

class KasirOrderFilterTabs extends ConsumerWidget {
  const KasirOrderFilterTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: List.generate(IncomingOrderFilter.values.length, (index) {
          return KasirOrderFilterChipItem(
            label: IncomingOrderFilter.values[index].label,
            isSelected:
                ref.watch(incomingOrderFilterStateProvider) ==
                IncomingOrderFilter.values[index],
            onTap: () => ref
                .read(incomingOrderFilterStateProvider.notifier)
                .select(IncomingOrderFilter.values[index]),
          );
        }),
      ),
    );
  }
}
