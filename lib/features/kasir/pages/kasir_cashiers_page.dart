import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/resources.dart';
import '../../../widget/empty_state.dart';
import '../../../widget/primary_button.dart';
import '../providers/cashier_accounts_provider.dart';
import '../widgets/kasir_cashier_delete_dialog.dart';
import '../widgets/kasir_cashier_form_dialog.dart';
import '../widgets/kasir_cashier_item.dart';
import '../widgets/kasir_page_header.dart';
import '../widgets/kasir_staff_summary_bar.dart';

class KasirCashiersPage extends ConsumerWidget {
  const KasirCashiersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(cashierAccountsProvider);
    final activeCount = accounts.where((item) => item.isActive).length;

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
                subtitle:
                    'Atur akun kasir cabang. Nonaktifkan kalau staf sedang '
                    'tidak bertugas.',
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
              if (accounts.isNotEmpty)
                KasirStaffSummaryBar(
                  total: accounts.length,
                  activeCount: activeCount,
                  roleLabel: 'Kasir',
                ),
              Expanded(
                child: accounts.isEmpty
                    ? const Center(
                        child: EmptyState(
                          title: 'Belum ada akun kasir',
                          subtitle: 'Tambah kasir supaya staf bisa login.',
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.only(bottom: 8),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 260,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.82,
                            ),
                        itemCount: accounts.length,
                        itemBuilder: (context, index) {
                          final account = accounts[index];
                          return KasirCashierItem(
                            account: account,
                            onEdit: () =>
                                KasirCashierFormDialog.show(context, account),
                            onDelete: () =>
                                KasirCashierDeleteDialog.show(context, account),
                            onToggleActive: () => ref
                                .read(cashierAccountsProvider.notifier)
                                .toggleActive(account.id),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
