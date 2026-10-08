import 'package:flutter/material.dart';

import '../../../resources/resources.dart';
import '../models/table_account_model.dart';
import 'kasir_shift_summary_item.dart';

class KasirTableSummaryBar extends StatelessWidget {
  const KasirTableSummaryBar({super.key, required this.tables});

  final List<TableAccountModel> tables;

  int get _activeCount => tables.where((table) => table.isActive).length;

  int get _inactiveCount => tables.length - _activeCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 14,
      children: [
        Expanded(
          child: KasirShiftSummaryItem(
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: Icons.table_restaurant_rounded,
            label: 'Total Meja',
            value: '${tables.length} meja',
          ),
        ),
        Expanded(
          child: KasirShiftSummaryItem(
            icon: Icons.check_circle_rounded,
            label: 'Aktif',
            value: '$_activeCount meja',
            valueColor: AppColors.successMain,
            backgroundColor: AppColors.successSoft,
          ),
        ),
        Expanded(
          child: KasirShiftSummaryItem(
            icon: Icons.pause_circle_rounded,
            label: 'Nonaktif',
            value: '$_inactiveCount meja',
            valueColor: AppColors.neutral80,
            backgroundColor: AppColors.neutral20,
          ),
        ),
      ],
    );
  }
}
