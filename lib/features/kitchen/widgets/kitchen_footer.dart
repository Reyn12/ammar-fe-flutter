import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KitchenFooter extends StatelessWidget {
  const KitchenFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.neutral10,
        border: Border(top: BorderSide(color: AppColors.neutral30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.successMain,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            'Live Dashboard Synchronized',
            style: AppTypography.bodySemiboldS.copyWith(
              color: AppColors.successMain,
            ),
          ),
        ],
      ),
    );
  }
}
