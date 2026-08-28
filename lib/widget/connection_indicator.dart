import 'package:flutter/material.dart';

import '../resources/app_typography.dart';
import '../resources/resources.dart';

/// Indikator koneksi realtime (SSE) di header kasir & dapur.
class ConnectionIndicator extends StatelessWidget {
  const ConnectionIndicator({super.key, this.isOnline = true, this.label});

  final bool isOnline;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final color = isOnline ? AppColors.successMain : AppColors.dangerMain;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isOnline ? AppColors.successSoft : AppColors.dangerSurface,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Text(
            label ?? (isOnline ? 'Online' : 'Offline'),
            style: AppTypography.bodySemiboldS.copyWith(
              color: color,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
