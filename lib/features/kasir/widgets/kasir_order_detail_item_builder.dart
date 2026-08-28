import 'package:flutter/material.dart';

import '../../../models/order_item_model.dart';
import '../../../resources/resources.dart';
import 'kasir_order_detail_item.dart';

class KasirOrderDetailItemBuilder extends StatelessWidget {
  const KasirOrderDetailItemBuilder({super.key, required this.items});

  final List<OrderItemModel> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      separatorBuilder: (_, _) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Divider(height: 1, color: AppColors.neutral30),
      ),
      itemBuilder: (context, index) => KasirOrderDetailItem(item: items[index]),
    );
  }
}
