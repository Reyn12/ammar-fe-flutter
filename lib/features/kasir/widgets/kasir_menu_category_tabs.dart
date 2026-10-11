import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../auth/helpers/auth_permission.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/kasir_menu_provider.dart';
import 'kasir_category_manage_dialog.dart';
import 'kasir_menu_category_item.dart';

class KasirMenuCategoryTabs extends ConsumerWidget {
  const KasirMenuCategoryTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: [
          KasirMenuCategoryItem(
            label: 'Semua',
            isSelected: ref.watch(kasirMenuCategoryProvider) == null,
            onTap: () =>
                ref.read(kasirMenuCategoryProvider.notifier).select(null),
          ),
          ...List.generate(ref.watch(kasirMenuCategoriesProvider).length, (
            index,
          ) {
            return KasirMenuCategoryItem(
              label:
                  ref.watch(kasirMenuCategoriesProvider)[index].name ?? '-',
              isSelected:
                  ref.watch(kasirMenuCategoryProvider) ==
                  ref.watch(kasirMenuCategoriesProvider)[index].id,
              onTap: () => ref
                  .read(kasirMenuCategoryProvider.notifier)
                  .select(ref.watch(kasirMenuCategoriesProvider)[index].id),
            );
          }),
          if (canManageMenu(ref.watch(sessionProvider)))
            TextButton.icon(
              onPressed: () => KasirCategoryManageDialog.show(context),
              // TODO: ganti Material icon ini dengan asset ikon final.
              icon: const Icon(Icons.tune_rounded, size: 18),
              label: Text(
                'Kelola Kategori',
                style: AppTypography.bodySemiboldM.copyWith(
                  color: AppColors.primaryMain,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
