import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../network/staff_events_service.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/connection_indicator.dart';
import '../../../widget/live_clock.dart';
import '../../../widget/logout_dialog.dart';
import '../providers/kitchen_batch_provider.dart';
import '../providers/kitchen_board_provider.dart';

class KitchenHeader extends ConsumerWidget {
  const KitchenHeader({super.key});

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
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.orangeMain,
              borderRadius: BorderRadius.circular(12),
            ),
            // TODO: ganti Material icon ini dengan logo RM Ayam Bakar Ammar.
            child: const Icon(
              Icons.soup_kitchen_rounded,
              size: 22,
              color: AppColors.neutral10,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kitchen Management',
                  style: AppTypography.h9Bold.copyWith(
                    color: AppColors.neutral100,
                    height: 1.2,
                  ),
                ),
                Text(
                  'RM Ayam Bakar Ammar · Cabang Pusat',
                  style: AppTypography.bodyRegularS.copyWith(
                    color: AppColors.neutral70,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          ConnectionIndicator(isOnline: ref.watch(staffEventsConnectionProvider)),
          IconButton(
            tooltip: 'Muat ulang antrean',
            onPressed: () {
              ref.invalidate(kitchenOrdersProvider);
              ref.invalidate(kitchenBatchesProvider);
            },
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: const Icon(Icons.refresh_rounded, color: AppColors.neutral80),
          ),
          const LiveClock(),
          IconButton(
            tooltip: 'Keluar',
            onPressed: () => LogoutDialog.show(context),
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: const Icon(
              Icons.logout_rounded,
              color: AppColors.dangerMain,
            ),
          ),
        ],
      ),
    );
  }
}
