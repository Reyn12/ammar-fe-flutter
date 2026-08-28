import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/resources.dart';
import '../providers/kasir_nav_provider.dart';
import '../widgets/kasir_header.dart';
import '../widgets/kasir_sidebar.dart';
import 'kasir_incoming_orders_page.dart';
import 'kasir_menu_page.dart';
import 'kasir_settings_page.dart';
import 'kasir_shift_page.dart';
import 'kasir_transaction_page.dart';

class KasirShellPage extends ConsumerWidget {
  const KasirShellPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.neutral20,
      body: SafeArea(
        child: Row(
          children: [
            const KasirSidebar(),
            Expanded(
              child: Column(
                children: [
                  const KasirHeader(),
                  Expanded(
                    child: IndexedStack(
                      index: ref.watch(kasirNavProvider).index,
                      children: const [
                        KasirIncomingOrdersPage(),
                        KasirTransactionPage(),
                        KasirMenuPage(),
                        KasirShiftPage(),
                        KasirSettingsPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
