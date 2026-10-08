import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../models/kitchen_batch_model.dart';
import 'kitchen_batch_item.dart';

class KitchenBatchGroupBuilder extends ConsumerWidget {
  const KitchenBatchGroupBuilder({super.key, required this.groupedBatches});

  final Map<String, List<KitchenBatchModel>> groupedBatches;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 18,
      children: List.generate(groupedBatches.length, (groupIndex) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            Text(
              groupedBatches.keys.elementAt(groupIndex).toUpperCase(),
              style: AppTypography.bodySemiboldS.copyWith(
                color: AppColors.neutral60,
                letterSpacing: 1.1,
              ),
            ),
            ...List.generate(
              groupedBatches.values.elementAt(groupIndex).length,
              (index) {
                final batch =
                    groupedBatches.values.elementAt(groupIndex)[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: KitchenBatchItem(batch: batch),
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
