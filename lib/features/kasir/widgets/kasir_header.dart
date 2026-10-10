import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/status_color_helper.dart';
import '../../../network/staff_events_service.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/connection_indicator.dart';
import '../../../widget/live_clock.dart';
import '../../../widget/status_pill.dart';
import '../providers/incoming_orders_provider.dart';
import '../providers/kasir_incoming_alert_provider.dart';
import '../providers/kasir_shift_provider.dart';

class KasirHeader extends ConsumerWidget {
  const KasirHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.neutral10,
        border: Border(bottom: BorderSide(color: AppColors.neutral30)),
      ),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RM Ayam Bakar Ammar',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.h9Bold.copyWith(
                    color: AppColors.neutral100,
                    height: 1.2,
                  ),
                ),
                Text(
                  'Cabang Pusat',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodyRegularS.copyWith(
                    color: AppColors.neutral70,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          StatusPill(
            label: ref.watch(kasirShiftProvider).value?.isActive ?? false
                ? 'Shift Aktif'
                : 'Belum Buka Shift',
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: Icons.access_time_rounded,
            foregroundColor:
                ref.watch(kasirShiftProvider).value?.isActive ?? false
                ? AppColors.successMain
                : AppColors.warningPressed,
            backgroundColor:
                ref.watch(kasirShiftProvider).value?.isActive ?? false
                ? AppColors.successSoft
                : AppColors.warningSurface,
          ),
          StatusPill(
            label: '${ref.watch(waitingCashCountProvider)} Tunai',
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: Icons.payments_rounded,
            foregroundColor: paymentStatusColor(null).foreground,
            backgroundColor: paymentStatusColor(null).background,
          ),
          ConnectionIndicator(isOnline: ref.watch(staffEventsConnectionProvider)),
          // TODO: hapus tombol simulate setelah SSE pesanan baru siap.
          IconButton(
            tooltip: 'Simulasi pesanan baru',
            onPressed: () => ref
                .read(kasirIncomingAlertProvider.notifier)
                .simulateIncomingOrder(),
            icon: const Icon(
              Icons.add_alert_rounded,
              color: AppColors.orangeMain,
            ),
          ),
          IconButton(
            tooltip: 'Muat ulang pesanan',
            onPressed: () => ref.invalidate(incomingOrdersProvider),
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: const Icon(Icons.refresh_rounded, color: AppColors.neutral80),
          ),
          const LiveClock(),
        ],
      ),
    );
  }
}
