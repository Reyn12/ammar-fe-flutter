import 'package:flutter/material.dart';

import '../../../models/order_model.dart';
import '../../../resources/resources.dart';
import '../../../widget/empty_state.dart';
import '../../../widget/surface_card.dart';
import 'kasir_transaction_item.dart';
import 'kasir_transaction_table_header.dart';

class KasirTransactionBuilder extends StatelessWidget {
  const KasirTransactionBuilder({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: EmptyState(
          title: 'Belum ada transaksi',
          subtitle: 'Transaksi yang selesai pada shift ini akan tercatat di sini.',
        ),
      );
    }

    return SurfaceCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const KasirTransactionTableHeader(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: orders.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, color: AppColors.neutral30),
              itemBuilder: (context, index) =>
                  KasirTransactionItem(order: orders[index]),
            ),
          ),
        ],
      ),
    );
  }
}
