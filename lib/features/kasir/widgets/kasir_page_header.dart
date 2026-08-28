import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KasirPageHeader extends StatelessWidget {
  const KasirPageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.h8Bold.copyWith(
                  color: AppColors.neutral100,
                  height: 1.25,
                ),
              ),
              Text(
                subtitle,
                style: AppTypography.bodyRegularM.copyWith(
                  color: AppColors.neutral70,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}
