import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';
import '../../auth/helpers/auth_permission.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/kasir_menu_provider.dart';
import '../widgets/kasir_menu_category_tabs.dart';
import '../widgets/kasir_menu_form_dialog.dart';
import '../widgets/kasir_menu_grid_builder.dart';
import '../widgets/kasir_menu_grid_shimmer.dart';
import '../widgets/kasir_order_list_error.dart';
import '../widgets/kasir_page_header.dart';

class KasirMenuPage extends ConsumerWidget {
  const KasirMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manageMenu = canManageMenu(ref.watch(sessionProvider));

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 18,
        children: [
          KasirPageHeader(
            title: 'Kelola Menu',
            subtitle: manageMenu
                ? 'Atur daftar menu, harga, dan ketersediaan stok.'
                : 'Lihat daftar menu dan status ketersediaan.',
            trailing: manageMenu
                ? PrimaryButton(
                    text: 'Tambah Menu',
                    wrapContent: true,
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    leading: const Icon(
                      // TODO: ganti Material icon ini dengan asset ikon final.
                      Icons.add_rounded,
                      color: AppColors.neutral10,
                    ),
                    onPressed: () => KasirMenuFormDialog.show(context),
                  )
                : null,
          ),
          const KasirMenuCategoryTabs(),
          Expanded(
            child: ref
                .watch(filteredKasirMenuProvider)
                .when(
                  loading: () => const KasirMenuGridShimmer(),
                  error: (_, _) => KasirOrderListError(
                    onRetry: () => ref.invalidate(kasirMenuProvider),
                  ),
                  data: (products) => KasirMenuGridBuilder(
                    products: products,
                    canManage: manageMenu,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
