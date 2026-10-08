import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/status_pill.dart';
import '../models/cashier_account_model.dart';

class KasirCashierItem extends StatelessWidget {
  const KasirCashierItem({
    super.key,
    required this.account,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  final CashierAccountModel account;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        spacing: 12,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(12),
            ),
            // TODO: ganti Material icon ini dengan asset ikon final.
            child: const Icon(
              Icons.person_rounded,
              size: 20,
              color: AppColors.primaryMain,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  account.name,
                  style: AppTypography.bodySemiboldL.copyWith(
                    color: AppColors.neutral100,
                    height: 1.2,
                  ),
                ),
                Text(
                  '@${account.username}',
                  style: AppTypography.bodyRegularM.copyWith(
                    color: AppColors.neutral70,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          StatusPill(
            label: account.isActive ? 'Aktif' : 'Nonaktif',
            foregroundColor: account.isActive
                ? AppColors.successMain
                : AppColors.neutral70,
            backgroundColor: account.isActive
                ? AppColors.successSoft
                : AppColors.neutral20,
            dense: true,
          ),
          Switch(
            value: account.isActive,
            activeTrackColor: AppColors.successMain,
            onChanged: (_) => onToggleActive(),
          ),
          IconButton(
            onPressed: onEdit,
            tooltip: 'Edit kasir',
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: const Icon(Icons.edit_rounded, size: 18),
            color: AppColors.primaryMain,
          ),
          IconButton(
            onPressed: onDelete,
            tooltip: 'Hapus kasir',
            style: IconButton.styleFrom(
              backgroundColor: AppColors.dangerSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 18,
              color: AppColors.dangerMain,
            ),
          ),
        ],
      ),
    );
  }
}
