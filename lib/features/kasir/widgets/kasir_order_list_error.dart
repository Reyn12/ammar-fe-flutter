import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';

class KasirOrderListError extends StatelessWidget {
  const KasirOrderListError({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          // TODO: ganti Material icon ini dengan asset ilustrasi final.
          const Icon(
            Icons.cloud_off_rounded,
            size: 56,
            color: AppColors.neutral50,
          ),
          Text(
            'Gagal memuat pesanan',
            style: AppTypography.h9Bold.copyWith(color: AppColors.neutral100),
          ),
          Text(
            'Cek koneksi ke server lalu coba lagi.',
            style: AppTypography.bodyRegularM.copyWith(
              color: AppColors.neutral70,
            ),
          ),
          PrimaryButton(
            text: 'Coba Lagi',
            wrapContent: true,
            height: 44,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
