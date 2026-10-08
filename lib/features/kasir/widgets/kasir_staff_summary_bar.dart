import 'package:flutter/material.dart';

import '../../../resources/resources.dart';
import 'kasir_shift_summary_item.dart';

class KasirStaffSummaryBar extends StatelessWidget {
  const KasirStaffSummaryBar({
    super.key,
    required this.total,
    required this.activeCount,
    required this.roleLabel,
  });

  final int total;
  final int activeCount;
  final String roleLabel;

  int get _inactiveCount => total - activeCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 14,
      children: [
        Expanded(
          child: KasirShiftSummaryItem(
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: Icons.groups_rounded,
            label: 'Total $roleLabel',
            value: '$total akun',
          ),
        ),
        Expanded(
          child: KasirShiftSummaryItem(
            icon: Icons.check_circle_rounded,
            label: 'Aktif',
            value: '$activeCount akun',
            valueColor: AppColors.successMain,
            backgroundColor: AppColors.successSoft,
          ),
        ),
        Expanded(
          child: KasirShiftSummaryItem(
            icon: Icons.pause_circle_rounded,
            label: 'Nonaktif',
            value: '$_inactiveCount akun',
            valueColor: AppColors.neutral80,
            backgroundColor: AppColors.neutral20,
          ),
        ),
      ],
    );
  }
}
