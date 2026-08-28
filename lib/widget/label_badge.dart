import 'package:flutter/material.dart';
import 'package:ammar_fe_flutter/resources/app_typography.dart';

class LabelBadge extends StatelessWidget {
  const LabelBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: AppTypography.bodyRegularS.copyWith(color: textColor),
      ),
    );
  }
}
