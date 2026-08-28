import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/logout_dialog.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/kasir_shift_provider.dart';

class KasirSidebarFooter extends ConsumerWidget {
  const KasirSidebarFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.neutral20,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        spacing: 12,
        children: [
          Row(
            spacing: 10,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius: BorderRadius.circular(10),
                ),
                // TODO: ganti Material icon ini dengan asset avatar/ikon final.
                child: const Icon(
                  Icons.person_rounded,
                  size: 20,
                  color: AppColors.primaryMain,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ref.watch(sessionProvider)?.name ?? 'Kasir',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySemiboldM.copyWith(
                        color: AppColors.neutral100,
                        height: 1.3,
                      ),
                    ),
                    Text(
                      ref.watch(kasirShiftProvider).value?.isActive ?? false
                          ? 'Shift aktif'
                          : 'Belum buka shift',
                      style: AppTypography.bodyRegularS.copyWith(
                        color:
                            ref.watch(kasirShiftProvider).value?.isActive ??
                                false
                            ? AppColors.successMain
                            : AppColors.neutral70,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Keluar',
                onPressed: () => LogoutDialog.show(context),
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 20,
                  color: AppColors.dangerMain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
