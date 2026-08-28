import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KasirOrderDetailEmpty extends StatelessWidget {
  const KasirOrderDetailEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          // TODO: ganti Material icon ini dengan asset ilustrasi final.
          const Icon(
            Icons.receipt_long_rounded,
            size: 62,
            color: AppColors.neutral50,
          ),
          Text(
            'Pilih pesanan',
            style: AppTypography.h9Bold.copyWith(color: AppColors.neutral90),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Ketuk salah satu kartu pesanan di sebelah kiri untuk melihat '
              'rincian item dan aksi pembayaran.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyRegularM.copyWith(
                color: AppColors.neutral70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
