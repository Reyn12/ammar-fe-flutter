import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KasirShiftSummaryItem extends StatelessWidget {
  const KasirShiftSummaryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.backgroundColor,
  });

  // TODO: ganti Material icon ini dengan asset ikon final.
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.neutral20,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            spacing: 8,
            children: [
              Icon(icon, size: 18, color: AppColors.neutral70),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodyRegularM.copyWith(
                    color: AppColors.neutral70,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: AppTypography.h8Bold.copyWith(
              color: valueColor ?? AppColors.neutral100,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
