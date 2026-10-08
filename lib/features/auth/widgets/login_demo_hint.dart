import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../mocks/user_mocks.dart';

class LoginDemoHint extends StatelessWidget {
  const LoginDemoHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Text(
            'Akun demo (mock)',
            style: AppTypography.bodySemiboldM.copyWith(
              color: AppColors.primaryMain,
            ),
          ),
          Text(
            'Owner: ${UserMocks.demoOwnerUsername} / ${UserMocks.demoPassword}',
            style: AppTypography.bodyRegularM.copyWith(
              color: AppColors.neutral80,
            ),
          ),
          Text(
            'Kasir: ${UserMocks.demoCashierUsername} / ${UserMocks.demoPassword}',
            style: AppTypography.bodyRegularM.copyWith(
              color: AppColors.neutral80,
            ),
          ),
          Text(
            'Dapur: ${UserMocks.demoKitchenUsername} / ${UserMocks.demoPassword}',
            style: AppTypography.bodyRegularM.copyWith(
              color: AppColors.neutral80,
            ),
          ),
        ],
      ),
    );
  }
}
