import 'package:flutter/material.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../helper/format_time_helper.dart';
import '../../../models/shift_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/status_pill.dart';

class KasirOwnerShiftItem extends StatelessWidget {
  const KasirOwnerShiftItem({
    super.key,
    required this.shift,
    this.onForceClose,
  });

  final ShiftModel shift;
  final VoidCallback? onForceClose;

  @override
  Widget build(BuildContext context) {
    final active = shift.isActive;
    final diff = shift.cashDifference;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        spacing: 12,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: active
                  ? AppColors.primarySurface
                  : AppColors.neutral20,
              borderRadius: BorderRadius.circular(12),
            ),
            // TODO: ganti Material icon ini dengan asset ikon final.
            child: Icon(
              active
                  ? Icons.play_circle_rounded
                  : Icons.check_circle_rounded,
              size: 20,
              color: active ? AppColors.primaryMain : AppColors.neutral70,
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  shift.userName ?? 'Kasir',
                  style: AppTypography.bodySemiboldL.copyWith(
                    color: AppColors.neutral100,
                    height: 1.2,
                  ),
                ),
                Text(
                  shift.startTime == null
                      ? '-'
                      : active
                      ? 'Mulai ${formatDateTimeShort(shift.startTime!)} · '
                            '${formatDuration(shift.runningDuration)}'
                      : '${formatDateTimeShort(shift.startTime!)}'
                            '${shift.endTime == null ? '' : ' – ${formatClock(shift.endTime!)}'}',
                  style: AppTypography.bodyRegularM.copyWith(
                    color: AppColors.neutral70,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              formatRupiah(shift.startingCash ?? 0),
              style: AppTypography.bodyRegularM.copyWith(
                color: AppColors.neutral80,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              formatRupiah(shift.expectedCash ?? 0),
              style: AppTypography.bodyRegularM.copyWith(
                color: AppColors.neutral80,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: active
                ? Text(
                    '-',
                    style: AppTypography.bodyRegularM.copyWith(
                      color: AppColors.neutral60,
                    ),
                  )
                : Text(
                    diff == 0
                        ? 'Pas'
                        : '${diff > 0 ? '+' : '-'}${formatRupiah(diff.abs())}',
                    style: AppTypography.bodySemiboldM.copyWith(
                      color: diff == 0
                          ? AppColors.successMain
                          : diff < 0
                          ? AppColors.dangerMain
                          : AppColors.warningHover,
                    ),
                  ),
          ),
          StatusPill(
            label: active ? 'Aktif' : 'Ditutup',
            foregroundColor: active
                ? AppColors.primaryMain
                : AppColors.neutral70,
            backgroundColor: active
                ? AppColors.primarySurface
                : AppColors.neutral20,
            dense: true,
          ),
          SizedBox(
            width: 120,
            child: active
                ? PrimaryButton(
                    text: 'Paksa Tutup',
                    height: 40,
                    wrapContent: false,
                    color: AppColors.dangerMain,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    onPressed: onForceClose ?? () {},
                  )
                : Text(
                    '${(shift.cashOrderCount ?? 0) + (shift.qrisOrderCount ?? 0)} nota',
                    textAlign: TextAlign.end,
                    style: AppTypography.bodyRegularM.copyWith(
                      color: AppColors.neutral70,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
