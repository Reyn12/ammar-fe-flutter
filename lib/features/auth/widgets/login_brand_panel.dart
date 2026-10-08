import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/image_load.dart';
import '../mocks/user_mocks.dart';
import 'login_demo_account_item.dart';

class LoginBrandPanel extends StatelessWidget {
  const LoginBrandPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryMain, AppColors.shadesPrimary100],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 28,
        children: [
          ImageLoad(
            src: Assets.images.icLogoDapurself.path,
            width: 220,
            fit: BoxFit.contain,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(
                'Satu aplikasi\nuntuk Kasir & Dapur',
                style: AppTypography.h5Bold.copyWith(
                  color: AppColors.neutral10,
                  height: 1.25,
                ),
              ),
              Text(
                'Pesanan pelanggan langsung masuk ke layar kasir dan '
                'antrean batch dapur secara real-time.',
                style: AppTypography.bodyRegularL.copyWith(
                  color: AppColors.neutral10.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          Column(
            spacing: 12,
            children: [
              LoginDemoAccountItem(
                icon: Icons.storefront_rounded,
                title: 'Masuk sebagai Owner',
                subtitle:
                    '${UserMocks.demoOwnerUsername} / ${UserMocks.demoPassword}',
              ),
              LoginDemoAccountItem(
                icon: Icons.point_of_sale_rounded,
                title: 'Masuk sebagai Kasir',
                subtitle:
                    '${UserMocks.demoCashierUsername} / ${UserMocks.demoPassword}',
              ),
              LoginDemoAccountItem(
                icon: Icons.soup_kitchen_rounded,
                title: 'Masuk sebagai Koki',
                subtitle:
                    '${UserMocks.demoKitchenUsername} / ${UserMocks.demoPassword}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
