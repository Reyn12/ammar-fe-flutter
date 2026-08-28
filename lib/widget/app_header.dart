import 'package:flutter/material.dart';
import 'package:ammar_fe_flutter/resources/app_typography.dart';
import 'package:ammar_fe_flutter/resources/resources.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.title, this.leading});

  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 20,
        bottom: 20,
      ),
      decoration: const BoxDecoration(color: AppColors.neutral10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.h9Bold.copyWith(
              color: AppColors.neutral100,
              shadows: AppShadows.soft,
            ),
          ),
          if (leading != null)
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Center(child: leading),
            ),
        ],
      ),
    );
  }
}
