import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/status_pill.dart';
import '../../../widget/surface_card.dart';
import '../models/kitchen_account_model.dart';

class KasirKitchenItem extends StatelessWidget {
  const KasirKitchenItem({
    super.key,
    required this.account,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  final KitchenAccountModel account;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleActive;

  String get _initials {
    final parts = account.name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final active = account.isActive;

    return SurfaceCard(
      padding: const EdgeInsets.all(16),
      borderColor: active ? AppColors.neutral30 : AppColors.neutral40,
      backgroundColor: active ? AppColors.neutral10 : AppColors.neutral20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14,
        children: [
          Row(
            children: [
              StatusPill(
                label: active ? 'Aktif' : 'Nonaktif',
                foregroundColor: active
                    ? AppColors.successMain
                    : AppColors.neutral70,
                backgroundColor: active
                    ? AppColors.successSoft
                    : AppColors.neutral30,
                dense: true,
              ),
              const Spacer(),
              Switch(
                value: active,
                activeTrackColor: AppColors.successMain,
                onChanged: (_) => onToggleActive(),
              ),
            ],
          ),
          Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: active
                    ? AppColors.orangeMain.withValues(alpha: 0.12)
                    : AppColors.neutral30,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                _initials,
                style: AppTypography.h7Bold.copyWith(
                  color: active
                      ? AppColors.orangeMain
                      : AppColors.neutral70,
                  height: 1,
                ),
              ),
            ),
          ),
          Column(
            spacing: 4,
            children: [
              Text(
                account.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.h9Bold.copyWith(
                  color: active
                      ? AppColors.neutral100
                      : AppColors.neutral70,
                  height: 1.2,
                ),
              ),
              Text(
                '@${account.username}',
                textAlign: TextAlign.center,
                style: AppTypography.bodyRegularM.copyWith(
                  color: AppColors.neutral70,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onEdit,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.orangeMain,
                    side: BorderSide(
                      color: AppColors.orangeMain.withValues(alpha: 0.35),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // TODO: ganti Material icon ini dengan asset ikon final.
                  icon: const Icon(Icons.edit_rounded, size: 16),
                  label: Text('Edit', style: AppTypography.bodySemiboldS),
                ),
              ),
              IconButton(
                onPressed: onDelete,
                tooltip: 'Hapus dapur',
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
        ],
      ),
    );
  }
}
