import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/resources.dart';
import '../../../widget/surface_card.dart';
import 'kitchen_order_grid_shimmer.dart';

class KitchenBatchSidebarShimmer extends StatelessWidget {
  const KitchenBatchSidebarShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) => KitchenBatchCardShimmerItem(
        showCategory: index == 0 || index == 2,
      ),
    );
  }
}

class KitchenBatchCardShimmerItem extends StatelessWidget {
  const KitchenBatchCardShimmerItem({super.key, this.showCategory = false});

  final bool showCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 10,
      children: [
        if (showCategory)
          Shimmer.fromColors(
            baseColor: AppColors.neutral30,
            highlightColor: AppColors.neutral20,
            child: const KitchenShimmerBone(width: 88, height: 12),
          ),
        SurfaceCard(
          padding: const EdgeInsets.all(14),
          child: Shimmer.fromColors(
            baseColor: AppColors.neutral30,
            highlightColor: AppColors.neutral20,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Expanded(child: KitchenShimmerBone(height: 16)),
                    KitchenShimmerBone(width: 28, height: 24),
                  ],
                ),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    KitchenShimmerBone(width: 78, height: 26, radius: 8),
                    KitchenShimmerBone(width: 78, height: 26, radius: 8),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    KitchenShimmerBone(width: 72, height: 22, radius: 20),
                    KitchenShimmerBone(width: 72, height: 22, radius: 20),
                  ],
                ),
                KitchenShimmerBone(height: 42, radius: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
