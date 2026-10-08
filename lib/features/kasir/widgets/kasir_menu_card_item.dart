import 'package:flutter/material.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../models/product_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/image_load.dart';
import '../../../widget/surface_card.dart';

class KasirMenuCardItem extends StatelessWidget {
  const KasirMenuCardItem({
    super.key,
    required this.product,
    required this.canManage,
    required this.onToggleAvailability,
    required this.onEdit,
    required this.onDelete,
  });

  final ProductModel product;
  final bool canManage;
  final VoidCallback onToggleAvailability;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ColoredBox(
                color: AppColors.neutral20,
                child: (product.imageUrl ?? '').isEmpty
                    // TODO: ganti Material icon ini dengan asset ilustrasi final.
                    ? const Center(
                        child: Icon(
                          Icons.ramen_dining_rounded,
                          size: 42,
                          color: AppColors.neutral50,
                        ),
                      )
                    : ImageLoad(
                        src: product.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Text(
            product.name ?? '-',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodySemiboldL.copyWith(
              color: AppColors.neutral100,
              height: 1.25,
            ),
          ),
          Text(
            '${product.categoryName ?? '-'} · ${formatRupiah(product.price ?? 0)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodyRegularM.copyWith(
              color: AppColors.neutral70,
              height: 1.25,
            ),
          ),
          const Divider(height: 1, color: AppColors.neutral30),
          Row(
            children: [
              Expanded(
                child: Text(
                  product.isAvailable ?? false ? 'Tersedia' : 'Habis',
                  style: AppTypography.bodySemiboldS.copyWith(
                    color: product.isAvailable ?? false
                        ? AppColors.successMain
                        : AppColors.dangerMain,
                  ),
                ),
              ),
              if (canManage)
                Switch(
                  value: product.isAvailable ?? false,
                  activeTrackColor: AppColors.successMain,
                  onChanged: (_) => onToggleAvailability(),
                ),
            ],
          ),
          if (canManage)
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onEdit,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryMain,
                      side: const BorderSide(color: AppColors.primaryBorder),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // TODO: ganti Material icon ini dengan asset ikon final.
                    icon: const Icon(Icons.edit_rounded, size: 16),
                    label: Text('Edit', style: AppTypography.bodySemiboldS),
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  tooltip: 'Hapus menu',
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.dangerSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // TODO: ganti Material icon ini dengan asset ikon final.
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                    color: AppColors.dangerMain,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
