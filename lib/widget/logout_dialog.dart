import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/providers/auth_provider.dart';
import '../resources/app_typography.dart';
import '../resources/resources.dart';
import '../routes/app_paths.dart';
import 'primary_button.dart';

class LogoutDialog extends ConsumerWidget {
  const LogoutDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: AppColors.neutral10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Row(
                spacing: 12,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.dangerSurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // TODO: ganti Material icon ini dengan asset ikon final.
                    child: const Icon(
                      Icons.logout_rounded,
                      color: AppColors.dangerMain,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Keluar dari aplikasi?',
                      style: AppTypography.h8Bold.copyWith(
                        color: AppColors.neutral100,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Sesi kamu akan diakhiri dan kamu harus login ulang untuk '
                'melanjutkan pekerjaan.',
                style: AppTypography.bodyRegularM.copyWith(
                  color: AppColors.neutral70,
                ),
              ),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Batal',
                      reverse: true,
                      borderColor: AppColors.neutral40,
                      textColor: AppColors.neutral80,
                      height: 48,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Ya, Keluar',
                      color: AppColors.dangerMain,
                      height: 48,
                      onPressed: () async {
                        await ref.read(authProvider.notifier).logout();
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        context.go(AppPaths.login);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
