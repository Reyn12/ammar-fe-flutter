import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../network/api_service.dart';
import '../../../network/staff_events_service.dart';
import '../../../resources/resources.dart';
import '../../auth/helpers/auth_permission.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/kasir_nav_item.dart';
import '../providers/incoming_orders_provider.dart';
import '../providers/kasir_incoming_alert_provider.dart';
import '../providers/kasir_nav_provider.dart';
import '../providers/kasir_shift_provider.dart';
import '../widgets/kasir_header.dart';
import '../widgets/kasir_shift_open_dialog.dart';
import '../widgets/kasir_sidebar.dart';
import 'kasir_incoming_orders_page.dart';
import 'kasir_menu_page.dart';
import 'kasir_settings_page.dart';
import 'kasir_shift_page.dart';
import 'kasir_transaction_page.dart';

class KasirShellPage extends ConsumerStatefulWidget {
  const KasirShellPage({super.key});

  @override
  ConsumerState<KasirShellPage> createState() => _KasirShellPageState();
}

class _KasirShellPageState extends ConsumerState<KasirShellPage> {
  bool _shiftPromptHandled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkCashierShift());
  }

  /// Event realtime: segarkan daftar pesanan dan munculkan alert untuk pesanan yang
  /// perlu perhatian kasir (tunai baru menunggu konfirmasi, atau QRIS yang baru lunas).
  Future<void> _onStaffEvent(StaffEvent event) async {
    try {
      await ref.read(incomingOrdersProvider.notifier).refresh();

      if (event.type == 'order.paid' && !isOwner(ref.read(sessionProvider))) {
        unawaited(ref.read(kasirShiftProvider.notifier).refresh());
      }

      final needsAttention =
          (event.type == 'order.created' && event.paymentMethod == 'cash') ||
          (event.type == 'order.paid' && event.paymentMethod == 'qris');
      final orderId = event.orderId;
      if (!needsAttention || orderId == null) return;

      final order = await ref.read(apiServiceProvider).fetchOrderDetail(orderId);
      if (!mounted) return;
      ref.read(kasirIncomingAlertProvider.notifier).announce(order);
    } catch (_) {
      // Gagal menyegarkan: event berikutnya atau tombol muat ulang akan memperbaiki.
    }
  }

  /// Kasir masuk → cek GET /v1/shifts/active. Belum buka → pindah ke Shift + dialog.
  Future<void> _checkCashierShift() async {
    if (_shiftPromptHandled || !mounted) return;
    if (isOwner(ref.read(sessionProvider))) {
      _shiftPromptHandled = true;
      return;
    }

    final shift = await ref.read(kasirShiftProvider.future);
    if (!mounted) return;
    _shiftPromptHandled = true;

    if (shift != null) return;

    ref.read(kasirNavProvider.notifier).select(KasirNavItem.shift);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    await KasirShiftOpenDialog.show(context, forced: true);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<StaffEvent>>(staffEventsProvider, (_, next) {
      final event = next.value;
      if (event != null) unawaited(_onStaffEvent(event));
    });

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
