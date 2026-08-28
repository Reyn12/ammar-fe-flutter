import 'package:flutter/material.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../models/order_enums.dart';
import '../../../models/order_model.dart';
import 'kasir_shift_summary_item.dart';

class KasirTransactionSummaryBar extends StatelessWidget {
  const KasirTransactionSummaryBar({super.key, required this.orders});

  final List<OrderModel> orders;

  int get _totalRevenue =>
      orders.fold(0, (total, order) => total + (order.totalAmount ?? 0));

  int get _cashCount => orders
      .where((order) => order.paymentMethod == PaymentMethod.cash)
      .length;

  int get _qrisCount => orders
      .where((order) => order.paymentMethod == PaymentMethod.qris)
      .length;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 14,
      children: [
        Expanded(
          child: KasirShiftSummaryItem(
            // TODO: ganti Material icon ini dengan asset ikon final.
            icon: Icons.receipt_rounded,
            label: 'Total Transaksi',
            value: '${orders.length} nota',
          ),
        ),
        Expanded(
          child: KasirShiftSummaryItem(
            icon: Icons.attach_money_rounded,
            label: 'Total Omzet',
            value: formatRupiah(_totalRevenue),
          ),
        ),
        Expanded(
          child: KasirShiftSummaryItem(
            icon: Icons.payments_rounded,
            label: 'Bayar Tunai',
            value: '$_cashCount nota',
          ),
        ),
        Expanded(
          child: KasirShiftSummaryItem(
            icon: Icons.qr_code_rounded,
            label: 'Bayar QRIS',
            value: '$_qrisCount nota',
          ),
        ),
      ],
    );
  }
}
