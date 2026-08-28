import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KasirOrderSummaryRow extends StatelessWidget {
  const KasirOrderSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: (isTotal ? AppTypography.h9Bold : AppTypography.bodyRegularM)
                .copyWith(
                  color: isTotal ? AppColors.neutral100 : AppColors.neutral70,
                  height: 1.3,
                ),
          ),
        ),
        Text(
          value,
          style: (isTotal ? AppTypography.h8Bold : AppTypography.bodySemiboldM)
              .copyWith(
                color: isTotal ? AppColors.primaryMain : AppColors.neutral90,
                height: 1.3,
              ),
        ),
      ],
    );
  }
}
