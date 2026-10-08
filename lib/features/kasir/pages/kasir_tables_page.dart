import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/resources.dart';
import '../../../widget/empty_state.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/surface_card.dart';
import '../providers/table_accounts_provider.dart';
import '../widgets/kasir_page_header.dart';
import '../widgets/kasir_table_delete_dialog.dart';
import '../widgets/kasir_table_form_dialog.dart';
import '../widgets/kasir_table_item.dart';
import '../widgets/kasir_table_qr_dialog.dart';

class KasirTablesPage extends ConsumerWidget {
  const KasirTablesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tables = ref.watch(tableAccountsProvider);

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
                title: 'Kelola Meja',
                subtitle:
                    'Atur meja cabang, generate QR order, download, atau '
                    'generate ulang.',
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
                      text: 'Tambah Meja',
                      wrapContent: true,
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      leading: const Icon(
                        // TODO: ganti Material icon ini dengan asset ikon final.
                        Icons.add_rounded,
                        color: AppColors.neutral10,
                      ),
                      onPressed: () => KasirTableFormDialog.show(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: tables.isEmpty
                    ? const Center(
                        child: EmptyState(
                          title: 'Belum ada meja',
                          subtitle:
                              'Tambah meja supaya customer bisa scan QR order.',
                        ),
                      )
                    : SurfaceCard(
                        padding: EdgeInsets.zero,
                        child: ListView.separated(
                          itemCount: tables.length,
                          separatorBuilder: (_, _) => const Divider(
                            height: 1,
                            color: AppColors.neutral30,
                          ),
                          itemBuilder: (context, index) {
                            final table = tables[index];
                            return KasirTableItem(
                              table: table,
                              onShowQr: () =>
                                  KasirTableQrDialog.show(context, table),
                              onEdit: () =>
                                  KasirTableFormDialog.show(context, table),
                              onDelete: () =>
                                  KasirTableDeleteDialog.show(context, table),
                              onToggleActive: () => ref
                                  .read(tableAccountsProvider.notifier)
                                  .toggleActive(table.id),
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
