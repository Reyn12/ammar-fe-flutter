import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../network/staff_events_service.dart';
import '../../../resources/resources.dart';
import '../../../widget/dialog_mixin.dart';
import '../providers/kitchen_action_provider.dart';
import '../providers/kitchen_batch_provider.dart';
import '../providers/kitchen_board_provider.dart';
import '../providers/kitchen_incoming_provider.dart';
import '../widgets/kitchen_batch_sidebar.dart';
import '../widgets/kitchen_footer.dart';
import '../widgets/kitchen_header.dart';
import '../widgets/kitchen_order_page_view.dart';
import '../widgets/kitchen_pagination.dart';

class KitchenBoardPage extends ConsumerStatefulWidget {
  const KitchenBoardPage({super.key});

  @override
  ConsumerState<KitchenBoardPage> createState() => _KitchenBoardPageState();
}

class _KitchenBoardPageState extends ConsumerState<KitchenBoardPage>
    with DialogMixin {
  /// Event realtime: segarkan papan dan batch; pesanan yang baru lunas diumumkan (toast + sorot).
  Future<void> _onStaffEvent(StaffEvent event) async {
    try {
      await Future.wait([
        ref.read(kitchenOrdersProvider.notifier).refresh(),
        ref.read(kitchenBatchesProvider.notifier).refresh(),
      ]);

      final orderId = event.orderId;
      if (event.type != 'order.paid' || orderId == null || !mounted) return;

      // Koki tidak punya akses ke detail pesanan kasir; ambil dari daftar yang baru disegarkan.
      final orders = ref.read(kitchenOrdersProvider).value ?? const [];
      for (final order in orders) {
        if (order.id == orderId) {
          ref.read(kitchenIncomingAlertProvider.notifier).announce(order);
          break;
        }
      }
    } catch (_) {
      // Gagal menyegarkan: event berikutnya akan memperbaiki.
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<StaffEvent>>(staffEventsProvider, (_, next) {
      final event = next.value;
      if (event != null) unawaited(_onStaffEvent(event));
    });

    listenAction<bool>(
      context: context,
      state: ref.watch(kitchenActionControllerProvider),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          children: [
            const KitchenBatchSidebar(),
            Expanded(
              child: Column(
                children: [
                  const KitchenHeader(),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: KitchenOrderPageView(),
                    ),
                  ),
                  const KitchenPagination(),
                  const SizedBox(height: 8),
                  const KitchenFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
