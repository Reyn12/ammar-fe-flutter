import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/helpers/auth_permission.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/kasir_nav_item.dart';
import '../providers/incoming_orders_provider.dart';
import '../providers/kasir_nav_provider.dart';
import 'kasir_sidebar_item.dart';

class KasirSidebarMenuBuilder extends ConsumerWidget {
  const KasirSidebarMenuBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final owner = isOwner(ref.watch(sessionProvider));

    return Column(
      spacing: 6,
      children: List.generate(KasirNavItem.values.length, (index) {
        final item = KasirNavItem.values[index];
        final label = item == KasirNavItem.shift && owner
            ? 'Manajemen Shift'
            : item.label;

        return KasirSidebarItem(
          label: label,
          icon: item.icon,
          isSelected: ref.watch(kasirNavProvider) == item,
          badgeCount: item == KasirNavItem.incomingOrders
              ? ref.watch(waitingCashCountProvider).value ?? 0
              : 0,
          onTap: () => ref.read(kasirNavProvider.notifier).select(item),
        );
      }),
    );
  }
}
