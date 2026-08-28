import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/resources.dart';

class KasirOrderListShimmer extends StatelessWidget {
  const KasirOrderListShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.neutral30,
      highlightColor: AppColors.neutral20,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, _) => Container(
          height: 148,
          decoration: BoxDecoration(
            color: AppColors.neutral10,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
