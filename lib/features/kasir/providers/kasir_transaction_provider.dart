import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/order_mocks.dart';
import '../../../models/order_model.dart';

part 'kasir_transaction_provider.g.dart';

@riverpod
class KasirTransactions extends _$KasirTransactions {
  @override
  Future<List<OrderModel>> build() async {
    // TODO: ganti mock ini dengan GET /v1/orders?status=completed&shift_id=...
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return OrderMocks.historyOrders;
  }
}
