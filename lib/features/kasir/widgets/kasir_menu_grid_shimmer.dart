import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/resources.dart';

class KasirMenuGridShimmer extends StatelessWidget {
  const KasirMenuGridShimmer({super.key, this.itemCount = 8});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.neutral30,
      highlightColor: AppColors.neutral20,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 260,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.72,
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
