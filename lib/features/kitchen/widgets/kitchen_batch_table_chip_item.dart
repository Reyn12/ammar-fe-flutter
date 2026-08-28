import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KitchenBatchTableChipItem extends StatelessWidget {
  const KitchenBatchTableChipItem({
    super.key,
    required this.tableLabel,
    required this.qty,
  });

  final String tableLabel;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.neutral20,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$tableLabel ×$qty',
        style: AppTypography.bodySemiboldS.copyWith(
          color: AppColors.neutral80,
          height: 1.2,
        ),
      ),
    );
  }
}
