import 'package:flutter/material.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';

class KasirTransactionTableHeader extends StatelessWidget {
  const KasirTransactionTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.neutral20,
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text('Kode', style: _style)),
          Expanded(flex: 3, child: Text('Waktu', style: _style)),
          Expanded(flex: 3, child: Text('Tipe', style: _style)),
          Expanded(flex: 3, child: Text('Pembayaran', style: _style)),
          Expanded(
            flex: 3,
            child: Text('Total', style: _style, textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }

  static final TextStyle _style = AppTypography.bodySemiboldS.copyWith(
    color: AppColors.neutral70,
    height: 1.2,
  );
}
