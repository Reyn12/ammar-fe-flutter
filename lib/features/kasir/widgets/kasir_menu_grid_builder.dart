import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/product_model.dart';
import '../../../widget/empty_state.dart';
import '../providers/kasir_menu_provider.dart';
import 'kasir_menu_card_item.dart';
import 'kasir_menu_delete_dialog.dart';
import 'kasir_menu_form_dialog.dart';

class KasirMenuGridBuilder extends ConsumerWidget {
  const KasirMenuGridBuilder({
    super.key,
    required this.products,
    required this.canManage,
  });

  final List<ProductModel> products;
  final bool canManage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (products.isEmpty) {
      return Center(
        child: EmptyState(
          title: 'Belum ada menu',
          subtitle: canManage
              ? 'Tambah menu baru untuk kategori ini.'
              : 'Belum ada menu untuk kategori ini.',
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 8),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 260,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: canManage ? 0.72 : 0.88,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return KasirMenuCardItem(
          product: products[index],
          canManage: canManage,
          onToggleAvailability: () => ref
              .read(kasirMenuProvider.notifier)
              .toggleAvailability(products[index].id ?? 0),
          onEdit: () => KasirMenuFormDialog.show(context, products[index]),
          onDelete: () => KasirMenuDeleteDialog.show(context, products[index]),
        );
      },
    );
  }
}
