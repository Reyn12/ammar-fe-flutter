import 'package:flutter/material.dart';
import 'package:ammar_fe_flutter/resources/app_typography.dart';
import 'package:ammar_fe_flutter/resources/resources.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.title,
    required this.description,
    this.logoPath,
  });

  final String title;
  final String description;
  final String? logoPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children: [
        // ImageLoad(
        //   src: logoPath ?? Assets.images.logoMobileUeuTransparent.path,
        //   width: 180,
        //   height: 180,
        //   fit: BoxFit.contain,
        // ),
        Column(
          spacing: 4,
          children: [
            Text(
              title,
              style: AppTypography.bodySemiboldXl.copyWith(
                color: AppColors.neutral100,
              ),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodyRegularL.copyWith(
                color: AppColors.neutral80,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
