import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/kasir_nav_item.dart';
import '../providers/incoming_orders_provider.dart';
import '../providers/kasir_nav_provider.dart';
import 'kasir_sidebar_item.dart';

class KasirSidebarMenuBuilder extends ConsumerWidget {
  const KasirSidebarMenuBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 6,
      children: List.generate(KasirNavItem.values.length, (index) {
        return KasirSidebarItem(
          label: KasirNavItem.values[index].label,
          icon: KasirNavItem.values[index].icon,
          isSelected: ref.watch(kasirNavProvider) == KasirNavItem.values[index],
          badgeCount: KasirNavItem.values[index] == KasirNavItem.incomingOrders
              ? ref.watch(waitingCashCountProvider).value ?? 0
              : 0,
          onTap: () => ref
              .read(kasirNavProvider.notifier)
              .select(KasirNavItem.values[index]),
        );
      }),
    );
  }
}
