import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/surface_card.dart';

class KasirSettingSection extends StatelessWidget {
  const KasirSettingSection({
    super.key,
    this.title,
    this.subtitle,
    required this.children,
  });

  final String? title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final hasHeader = (title ?? '').isNotEmpty || (subtitle ?? '').isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: hasHeader ? 10 : 0,
      children: [
        if (hasHeader)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              if ((title ?? '').isNotEmpty)
                Text(
                  title!,
                  style: AppTypography.bodySemiboldL.copyWith(
                    color: AppColors.neutral100,
                    height: 1.25,
                  ),
                ),
              if ((subtitle ?? '').isNotEmpty)
                Text(
                  subtitle!,
                  style: AppTypography.bodyRegularM.copyWith(
                    color: AppColors.neutral70,
                    height: 1.3,
                  ),
                ),
            ],
          ),
        SurfaceCard(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1)
                  const Divider(height: 1, color: AppColors.neutral30),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
