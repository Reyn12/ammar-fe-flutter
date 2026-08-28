import 'package:flutter/material.dart';
import 'package:ammar_fe_flutter/resources/app_typography.dart';
import 'package:ammar_fe_flutter/resources/resources.dart';

class CustomBottomNavBarItem extends StatelessWidget {
  final bool isActive;
  final int index;
  final String label;
  final String iconPath;
  final String? activeIconPath;
  final VoidCallback onTap;

  const CustomBottomNavBarItem({
    super.key,
    required this.isActive,
    required this.index,
    required this.label,
    required this.iconPath,
    this.activeIconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primary;
    final inactiveColor = AppColors.neutral50;
    final textColor = isActive ? activeColor : inactiveColor;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isActive && activeIconPath != null ? activeIconPath! : iconPath,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: AppTypography.h11Medium.fontSize,
                color: textColor,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
