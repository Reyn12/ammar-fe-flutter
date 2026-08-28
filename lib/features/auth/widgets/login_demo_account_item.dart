import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class LoginDemoAccountItem extends StatelessWidget {
  const LoginDemoAccountItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  // TODO: ganti Material icon ini dengan asset ikon final.
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.neutral10.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neutral10.withValues(alpha: 0.22)),
      ),
      child: Row(
        spacing: 12,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.neutral10.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppColors.neutral10),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodySemiboldM.copyWith(
                    color: AppColors.neutral10,
                    height: 1.3,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodyRegularS.copyWith(
                    color: AppColors.neutral10.withValues(alpha: 0.75),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
