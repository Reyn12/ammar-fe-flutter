import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/primary_button.dart';
import '../models/cashier_account_model.dart';
import '../providers/cashier_accounts_provider.dart';

class KasirCashierDeleteDialog extends ConsumerWidget {
  const KasirCashierDeleteDialog({super.key, required this.account});

  final CashierAccountModel account;

  static Future<void> show(BuildContext context, CashierAccountModel account) {
    return showDialog<void>(
      context: context,
      builder: (_) => KasirCashierDeleteDialog(account: account),
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
              Text(
                'Hapus akun kasir?',
                style: AppTypography.h8Bold.copyWith(
                  color: AppColors.neutral100,
                ),
              ),
              Text(
                '"${account.name}" (@${account.username}) tidak bisa login '
                'lagi setelah dihapus.',
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
                      text: 'Hapus',
                      color: AppColors.dangerMain,
                      height: 48,
                      onPressed: () async {
                        await ref
                            .read(cashierAccountsProvider.notifier)
                            .delete(account.id);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        CustomSnackbar.success(
                          context,
                          '${account.name} sudah dihapus.',
                          title: 'Kasir Dihapus',
                        );
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
