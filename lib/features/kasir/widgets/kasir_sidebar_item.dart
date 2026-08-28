import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KasirSidebarItem extends StatelessWidget {
  const KasirSidebarItem({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.badgeCount = 0,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primarySurface : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            spacing: 12,
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected ? AppColors.primaryMain : AppColors.neutral70,
              ),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      (isSelected
                              ? AppTypography.bodySemiboldM
                              : AppTypography.bodyRegularM)
                          .copyWith(
                            color: isSelected
                                ? AppColors.primaryMain
                                : AppColors.neutral80,
                            height: 1.2,
                          ),
                ),
              ),
              if (badgeCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.dangerMain,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$badgeCount',
                    style: AppTypography.bodySemiboldXs.copyWith(
                      color: AppColors.neutral10,
                      height: 1.4,
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
