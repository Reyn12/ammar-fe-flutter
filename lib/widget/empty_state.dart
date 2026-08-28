import 'package:flutter/material.dart';
import 'package:ammar_fe_flutter/resources/app_typography.dart';
import 'package:ammar_fe_flutter/resources/resources.dart';
import 'package:ammar_fe_flutter/widget/image_load.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    this.imagePath,
  });

  final String title;
  final String subtitle;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imagePath != null)
          ImageLoad(
            src: imagePath!,
            width: 200,
            fit: BoxFit.contain,
          )
        else
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: AppColors.neutral100.withValues(alpha: 0.5),
          ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.h8Bold.copyWith(color: AppColors.neutral100),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.bodyRegularS.copyWith(
            color: AppColors.neutral100,
          ),
        ),
      ],
    );
  }
}
