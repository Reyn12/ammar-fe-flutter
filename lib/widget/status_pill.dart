import 'package:flutter/material.dart';

import '../resources/app_typography.dart';

/// Badge status dengan warna kontekstual (dibayar, dimasak, siap, dst).
class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    required this.foregroundColor,
    required this.backgroundColor,
    this.icon,
    this.dense = false,
  });

  final String label;
  final Color foregroundColor;
  final Color backgroundColor;
  final IconData? icon;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 8 : 10,
        vertical: dense ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          if (icon != null)
            Icon(icon, size: dense ? 12 : 14, color: foregroundColor),
          Text(
            label,
            style:
                (dense
                        ? AppTypography.bodySemiboldXs
                        : AppTypography.bodySemiboldS)
                    .copyWith(color: foregroundColor, height: 1.2),
          ),
        ],
      ),
    );
  }
}
