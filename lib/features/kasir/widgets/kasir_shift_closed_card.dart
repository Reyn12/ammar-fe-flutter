import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../helper/format_time_helper.dart';
import '../../../models/shift_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/surface_card.dart';
import '../providers/kasir_shift_provider.dart';
import 'kasir_shift_summary_item.dart';

class KasirShiftClosedCard extends ConsumerWidget {
  const KasirShiftClosedCard({super.key, required this.shift});

  final ShiftModel shift;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SurfaceCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rekap Shift Selesai',
                style: AppTypography.h7Bold.copyWith(
                  color: AppColors.neutral100,
                  height: 1.2,
                ),
              ),
              Text(
                '${shift.startTime == null ? '-' : formatDateTimeShort(shift.startTime!)}'
                ' s/d ${shift.endTime == null ? '-' : formatClock(shift.endTime!)}',
                style: AppTypography.bodyRegularM.copyWith(
                  color: AppColors.neutral70,
                  height: 1.3,
                ),
              ),
            ],
          ),
          Row(
            spacing: 14,
            children: [
              Expanded(
                child: KasirShiftSummaryItem(
                  icon: Icons.savings_rounded,
                  label: 'Modal Awal',
                  value: formatRupiah(shift.startingCash ?? 0),
                ),
              ),
              Expanded(
                child: KasirShiftSummaryItem(
                  icon: Icons.calculate_rounded,
                  label: 'Perkiraan Kas',
                  value: formatRupiah(shift.expectedCash ?? 0),
                ),
              ),
              Expanded(
                child: KasirShiftSummaryItem(
                  icon: Icons.account_balance_wallet_rounded,
                  label: 'Uang Fisik',
                  value: formatRupiah(shift.actualCash ?? 0),
                ),
              ),
              Expanded(
                child: KasirShiftSummaryItem(
                  icon: shift.cashDifference == 0
                      ? Icons.check_circle_rounded
                      : Icons.error_outline_rounded,
                  label: shift.cashDifference < 0 ? 'Selisih Kurang' : 'Selisih Lebih',
                  value: formatRupiah(shift.cashDifference.abs()),
                  valueColor: shift.cashDifference == 0
                      ? AppColors.successMain
                      : AppColors.dangerMain,
                  backgroundColor: shift.cashDifference == 0
                      ? AppColors.successSoft
                      : AppColors.dangerSurface,
                ),
              ),
            ],
          ),
          PrimaryButton(
            text: 'Buka Shift Baru',
            height: 52,
            leading: const Icon(
              // TODO: ganti Material icon ini dengan asset ikon final.
              Icons.restart_alt_rounded,
              color: AppColors.neutral10,
            ),
            onPressed: () => ref.read(kasirShiftProvider.notifier).reset(),
          ),
        ],
      ),
    );
  }
}
