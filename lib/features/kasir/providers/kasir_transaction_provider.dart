import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/order_model.dart';
import '../../../network/api_service.dart';

part 'kasir_transaction_provider.g.dart';

@riverpod
class KasirTransactions extends _$KasirTransactions {
  @override
  Future<List<OrderModel>> build() async {
    return ref.watch(apiServiceProvider).fetchTransactionHistory();
  }
}
