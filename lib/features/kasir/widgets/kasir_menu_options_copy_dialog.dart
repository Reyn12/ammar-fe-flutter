import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';

/// Pilih menu lain untuk menyalin grup pilihannya (Level Es, Level Gula, dst).
/// Menghasilkan menu yang dipilih, atau `null` kalau dibatalkan.
class KasirMenuOptionsCopyDialog extends StatefulWidget {
  const KasirMenuOptionsCopyDialog({super.key, required this.products});

  /// Hanya menu yang punya grup pilihan.
  final List<ProductModel> products;

  static Future<ProductModel?> show(
    BuildContext context,
    List<ProductModel> products,
  ) {
    return showDialog<ProductModel>(
      context: context,
      builder: (_) => KasirMenuOptionsCopyDialog(products: products),
    );
  }

  @override
  State<KasirMenuOptionsCopyDialog> createState() =>
      _KasirMenuOptionsCopyDialogState();
}

class _KasirMenuOptionsCopyDialogState
    extends State<KasirMenuOptionsCopyDialog> {
  String query = '';

  List<ProductModel> get results {
    final keyword = query.trim().toLowerCase();
    if (keyword.isEmpty) return widget.products;

    return [
      for (final product in widget.products)
        if ((product.name ?? '').toLowerCase().contains(keyword) ||
            (product.categoryName ?? '').toLowerCase().contains(keyword))
          product,
    ];
  }

  /// "Level Es · Level Gula · Tambahan"
  String _groupsSummary(ProductModel product) => [
    for (final group in product.addonGroups ?? const [])
      if ((group.name ?? '').isNotEmpty) group.name,
  ].join(' · ');

  @override
  Widget build(BuildContext context) {
    final items = results;

    return Dialog(
      backgroundColor: AppColors.neutral10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 14,
            children: [
              Text(
                'Salin Pilihan dari Menu Lain',
                style: AppTypography.h8Bold.copyWith(
                  color: AppColors.neutral100,
                ),
              ),
              Text(
                'Semua grup pilihan dari menu yang kamu pilih akan ditambahkan ke menu ini.',
                style: AppTypography.bodyRegularS.copyWith(
                  color: AppColors.neutral70,
                ),
              ),
              TextField(
                autofocus: true,
                onChanged: (value) => setState(() => query = value),
                decoration: InputDecoration(
                  hintText: 'Cari menu atau kategori',
                  isDense: true,
                  // TODO: ganti Material icon ini dengan asset ikon final.
                  prefixIcon: const Icon(Icons.search_rounded),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: AppColors.neutral40),
                  ),
                ),
              ),
              Flexible(
                child: items.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            'Menu tidak ditemukan.',
                            style: AppTypography.bodyRegularM.copyWith(
                              color: AppColors.neutral70,
                            ),
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const Divider(
                          height: 1,
                          color: AppColors.neutral30,
                        ),
                        itemBuilder: (context, index) {
                          final product = items[index];
                          return InkWell(
                            onTap: () => Navigator.of(context).pop(product),
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 2,
                                children: [
                                  Text(
                                    product.name ?? '-',
                                    style: AppTypography.bodySemiboldM.copyWith(
                                      color: AppColors.neutral100,
                                    ),
                                  ),
                                  Text(
                                    _groupsSummary(product),
                                    style: AppTypography.bodyRegularS.copyWith(
                                      color: AppColors.neutral70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              PrimaryButton(
                text: 'Batal',
                reverse: true,
                borderColor: AppColors.neutral40,
                textColor: AppColors.neutral80,
                height: 48,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
