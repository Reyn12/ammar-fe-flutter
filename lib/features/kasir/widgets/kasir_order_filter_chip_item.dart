import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KasirOrderFilterChipItem extends StatelessWidget {
  const KasirOrderFilterChipItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

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
              color: isSelected ? AppColors.primaryMain : AppColors.neutral40,
            ),
          ),
          child: Text(
            label,
            style: AppTypography.bodySemiboldM.copyWith(
              color: isSelected ? AppColors.neutral10 : AppColors.neutral80,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
