import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/product_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/primary_button.dart';
import '../providers/kasir_menu_provider.dart';

class KasirMenuDeleteDialog extends ConsumerWidget {
  const KasirMenuDeleteDialog({super.key, required this.product});

  final ProductModel product;

  static Future<void> show(BuildContext context, ProductModel product) {
    return showDialog<void>(
      context: context,
      builder: (_) => KasirMenuDeleteDialog(product: product),
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
                'Hapus menu ini?',
                style: AppTypography.h8Bold.copyWith(
                  color: AppColors.neutral100,
                ),
              ),
              Text(
                '"${product.name ?? '-'}" akan dihapus dari daftar menu dan '
                'tidak bisa dipesan pelanggan lagi.',
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
                            .read(kasirMenuProvider.notifier)
                            .deleteProduct(product.id ?? 0);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                        CustomSnackbar.success(
                          context,
                          '${product.name ?? 'Menu'} sudah dihapus.',
                          title: 'Menu Dihapus',
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
