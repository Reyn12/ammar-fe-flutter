import 'package:flutter/material.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../models/shift_model.dart';
import '../../../resources/resources.dart';
import 'kasir_shift_summary_item.dart';

class KasirOwnerShiftSummaryBar extends StatelessWidget {
  const KasirOwnerShiftSummaryBar({super.key, required this.shifts});

  final List<ShiftModel> shifts;

  int get _activeCount => shifts.where((s) => s.isActive).length;

  int get _closedCount => shifts.where((s) => !s.isActive).length;

  int get _totalDiff => shifts
      .where((s) => !s.isActive)
      .fold(0, (sum, s) => sum + s.cashDifference);

  @override
  Widget build(BuildContext context) {
    final diffColor = _totalDiff == 0
        ? AppColors.successMain
        : _totalDiff < 0
        ? AppColors.dangerMain
        : AppColors.warningHover;

    return Row(
      spacing: 14,
      children: [
        Expanded(
          child: KasirShiftSummaryItem(
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: Icons.play_circle_rounded,
            label: 'Shift Aktif',
            value: '$_activeCount kasir',
            valueColor: AppColors.primaryMain,
            backgroundColor: AppColors.primarySurface,
          ),
        ),
        Expanded(
          child: KasirShiftSummaryItem(
            icon: Icons.history_rounded,
            label: 'Riwayat Ditutup',
            value: '$_closedCount shift',
          ),
        ),
        Expanded(
          child: KasirShiftSummaryItem(
            icon: Icons.balance_rounded,
            label: 'Total Selisih Kas',
            value: _totalDiff == 0
                ? 'Pas'
                : '${_totalDiff > 0 ? '+' : '-'}${formatRupiah(_totalDiff.abs())}',
            valueColor: diffColor,
            backgroundColor: _totalDiff == 0
                ? AppColors.successSoft
                : _totalDiff < 0
                ? AppColors.dangerSurface
                : AppColors.warningSurface,
          ),
        ),
      ],
    );
  }
}
