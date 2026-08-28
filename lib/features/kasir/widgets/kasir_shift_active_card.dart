import 'package:flutter/material.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../helper/format_time_helper.dart';
import '../../../models/shift_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/status_pill.dart';
import '../../../widget/surface_card.dart';
import 'kasir_shift_close_dialog.dart';
import 'kasir_shift_summary_item.dart';

class KasirShiftActiveCard extends StatelessWidget {
  const KasirShiftActiveCard({super.key, required this.shift});

  final ShiftModel shift;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shift ${shift.userName ?? 'Kasir'}',
                      style: AppTypography.h7Bold.copyWith(
                        color: AppColors.neutral100,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'Dibuka ${shift.startTime == null ? '-' : formatDateTimeShort(shift.startTime!)}'
                      ' · berjalan ${formatDuration(shift.runningDuration)}',
                      style: AppTypography.bodyRegularM.copyWith(
                        color: AppColors.neutral70,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const StatusPill(
                label: 'Shift Aktif',
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: Icons.bolt_rounded,
                foregroundColor: AppColors.successMain,
                backgroundColor: AppColors.successSoft,
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
                  icon: Icons.trending_up_rounded,
                  label: 'Perkiraan Kas',
                  value: formatRupiah(shift.expectedCash ?? 0),
                  valueColor: AppColors.primaryMain,
                  backgroundColor: AppColors.primarySurface,
                ),
              ),
              Expanded(
                child: KasirShiftSummaryItem(
                  icon: Icons.payments_rounded,
                  label: 'Transaksi Tunai',
                  value: '${shift.cashOrderCount ?? 0} nota',
                ),
              ),
              Expanded(
                child: KasirShiftSummaryItem(
                  icon: Icons.qr_code_rounded,
                  label: 'Transaksi QRIS',
                  value: '${shift.qrisOrderCount ?? 0} nota',
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.warningSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              spacing: 10,
              children: [
                // TODO: ganti Material icon ini dengan asset ikon final.
                const Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: AppColors.warningPressed,
                ),
                Expanded(
                  child: Text(
                    'Perkiraan kas dihitung sistem dari modal awal + seluruh '
                    'transaksi tunai selama shift berjalan.',
                    style: AppTypography.bodyRegularM.copyWith(
                      color: AppColors.warningPressed,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          PrimaryButton(
            text: 'Tutup Shift',
            color: AppColors.dangerMain,
            height: 52,
            leading: const Icon(
              // TODO: ganti Material icon ini dengan asset ikon final.
              Icons.stop_circle_rounded,
              color: AppColors.neutral10,
            ),
            onPressed: () => KasirShiftCloseDialog.show(context, shift),
          ),
        ],
      ),
    );
  }
}
