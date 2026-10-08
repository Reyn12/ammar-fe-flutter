import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/resources.dart';
import '../../../widget/surface_card.dart';

class KitchenOrderGridShimmer extends StatelessWidget {
  const KitchenOrderGridShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 420,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: itemCount,
      itemBuilder: (_, _) => const KitchenOrderCardShimmerItem(),
    );
  }
}

class KitchenOrderCardShimmerItem extends StatelessWidget {
  const KitchenOrderCardShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: AppColors.neutral30,
        highlightColor: AppColors.neutral20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            Row(
              spacing: 10,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      KitchenShimmerBone(width: 96, height: 18),
                      KitchenShimmerBone(width: 140, height: 12),
                    ],
                  ),
                ),
                const KitchenShimmerBone(width: 58, height: 24, radius: 20),
              ],
            ),
            const Divider(height: 1, color: AppColors.neutral30),
            const Expanded(
              child: Column(
                spacing: 12,
                children: [
                  KitchenShimmerItemRowBone(),
                  KitchenShimmerItemRowBone(),
                  KitchenShimmerItemRowBone(),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.neutral30),
            const KitchenShimmerBone(height: 46, radius: 10),
          ],
        ),
      ),
    );
  }
}

class KitchenShimmerItemRowBone extends StatelessWidget {
  const KitchenShimmerItemRowBone({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        KitchenShimmerBone(width: 20, height: 20, radius: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 6,
            children: [
              KitchenShimmerBone(width: 160, height: 14),
              KitchenShimmerBone(width: 100, height: 10),
            ],
          ),
        ),
        KitchenShimmerBone(width: 72, height: 22, radius: 20),
      ],
    );
  }
}

class KitchenShimmerBone extends StatelessWidget {
  const KitchenShimmerBone({
    super.key,
    this.width,
    required this.height,
    this.radius = 6,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.neutral30,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
