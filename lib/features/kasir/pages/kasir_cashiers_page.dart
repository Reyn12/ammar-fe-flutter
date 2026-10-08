import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/resources.dart';
import '../../../widget/empty_state.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/surface_card.dart';
import '../providers/cashier_accounts_provider.dart';
import '../widgets/kasir_cashier_delete_dialog.dart';
import '../widgets/kasir_cashier_form_dialog.dart';
import '../widgets/kasir_cashier_item.dart';
import '../widgets/kasir_page_header.dart';

class KasirCashiersPage extends ConsumerWidget {
  const KasirCashiersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(cashierAccountsProvider);

    return Scaffold(
      backgroundColor: AppColors.neutral20,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 18,
            children: [
              KasirPageHeader(
                title: 'Kelola Kasir',
                subtitle: 'Tambah, edit, nonaktifkan, atau hapus akun kasir.',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    PrimaryButton(
                      text: 'Kembali',
                      wrapContent: true,
                      height: 46,
                      reverse: true,
                      borderColor: AppColors.neutral40,
                      textColor: AppColors.neutral80,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    PrimaryButton(
                      text: 'Tambah Kasir',
                      wrapContent: true,
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      leading: const Icon(
                        // TODO: ganti Material icon ini dengan asset ikon final.
                        Icons.add_rounded,
                        color: AppColors.neutral10,
                      ),
                      onPressed: () => KasirCashierFormDialog.show(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: accounts.isEmpty
                    ? const Center(
                        child: EmptyState(
                          title: 'Belum ada akun kasir',
                          subtitle: 'Tambah kasir supaya staf bisa login.',
                        ),
                      )
                    : SurfaceCard(
                        padding: EdgeInsets.zero,
                        child: ListView.separated(
                          itemCount: accounts.length,
                          separatorBuilder: (_, _) => const Divider(
                            height: 1,
                            color: AppColors.neutral30,
                          ),
                          itemBuilder: (context, index) {
                            final account = accounts[index];
                            return KasirCashierItem(
                              account: account,
                              onEdit: () => KasirCashierFormDialog.show(
                                context,
                                account,
                              ),
                              onDelete: () => KasirCashierDeleteDialog.show(
                                context,
                                account,
                              ),
                              onToggleActive: () => ref
                                  .read(cashierAccountsProvider.notifier)
                                  .toggleActive(account.id),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
