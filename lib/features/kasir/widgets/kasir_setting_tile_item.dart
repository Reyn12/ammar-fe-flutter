import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KasirSettingTileItem extends StatelessWidget {
  const KasirSettingTileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  // TODO: ganti Material icon ini dengan asset ikon final.
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            spacing: 14,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: AppColors.primaryMain),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.bodySemiboldL.copyWith(
                        color: AppColors.neutral100,
                        height: 1.3,
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
              // TODO: ganti Material icon ini dengan asset ikon final.
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.neutral60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
