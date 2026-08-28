import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/product_model.dart';
import '../../../widget/empty_state.dart';
import '../providers/kasir_menu_provider.dart';
import 'kasir_menu_card_item.dart';
import 'kasir_menu_delete_dialog.dart';
import 'kasir_menu_form_dialog.dart';

class KasirMenuGridBuilder extends ConsumerWidget {
  const KasirMenuGridBuilder({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (products.isEmpty) {
      return const Center(
        child: EmptyState(
          title: 'Belum ada menu',
          subtitle: 'Tambah menu baru untuk kategori ini.',
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 260,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return KasirMenuCardItem(
          product: products[index],
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
