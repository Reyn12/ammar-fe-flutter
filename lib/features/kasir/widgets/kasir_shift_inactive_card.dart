import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/surface_card.dart';
import 'kasir_shift_open_dialog.dart';

class KasirShiftInactiveCard extends StatelessWidget {
  const KasirShiftInactiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SurfaceCard(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 14,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: AppColors.warningSurface,
                  borderRadius: BorderRadius.circular(20),
                ),
                // TODO: ganti Material icon ini dengan asset ilustrasi final.
                child: const Icon(
                  Icons.lock_clock_rounded,
                  size: 34,
                  color: AppColors.warningPressed,
                ),
              ),
              Text(
                'Kamu belum membuka shift',
                style: AppTypography.h7Bold.copyWith(
                  color: AppColors.neutral100,
                  height: 1.25,
                ),
              ),
              Text(
                'Buka shift dulu supaya bisa menerima pesanan dan '
                'mengonfirmasi pembayaran tunai.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyRegularL.copyWith(
                  color: AppColors.neutral70,
                ),
              ),
              PrimaryButton(
                text: 'Buka Shift',
                wrapContent: true,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                leading: const Icon(
                  // TODO: ganti Material icon ini dengan asset ikon final.
                  Icons.play_circle_fill_rounded,
                  color: AppColors.neutral10,
                ),
                onPressed: () => KasirShiftOpenDialog.show(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
