import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/resources.dart';

class KitchenOrderGridShimmer extends StatelessWidget {
  const KitchenOrderGridShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.neutral30,
      highlightColor: AppColors.neutral20,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 420,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.15,
        ),
        itemCount: itemCount,
        itemBuilder: (_, _) => Container(
          decoration: BoxDecoration(
            color: AppColors.neutral10,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
