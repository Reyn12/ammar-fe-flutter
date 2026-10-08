import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KasirOrderFilterChipItem extends StatelessWidget {
  const KasirOrderFilterChipItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badgeCount = 0,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primaryMain : AppColors.neutral10,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: badgeCount > 0 && !isSelected
                  ? AppColors.orangeMain
                  : isSelected
                  ? AppColors.primaryMain
                  : AppColors.neutral40,
              width: badgeCount > 0 && !isSelected ? 1.4 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Text(
                label,
                style: AppTypography.bodySemiboldM.copyWith(
                  color: isSelected
                      ? AppColors.neutral10
                      : AppColors.neutral80,
                  height: 1.2,
                ),
              ),
              if (badgeCount > 0)
                Container(
                  constraints: const BoxConstraints(minWidth: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.neutral10
                        : AppColors.orangeMain,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$badgeCount',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySemiboldS.copyWith(
                      color: isSelected
                          ? AppColors.orangeMain
                          : AppColors.neutral10,
                      height: 1.1,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
