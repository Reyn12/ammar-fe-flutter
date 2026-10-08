import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/kitchen/models/kitchen_batch_model.dart';
import '../mocks/kitchen_batch_mocks.dart';
import '../mocks/order_mocks.dart';
import '../models/order_enums.dart';
import '../models/order_model.dart';
import 'api/converter.dart';
import 'dio_client_provider.dart';
import 'environment.dart';

part 'api_service.g.dart';

@riverpod
ApiService apiService(Ref ref) => ApiService(ref.watch(dioClientProvider));

class ApiService {
  ApiService(this.dio);

  final Dio dio;

  bool useMock(bool? mock) => mock ?? mockStatus;

  // Future<List<ProductModel>> fetchProducts({bool? mock}) async {
  //   if (useMock(mock)) return ProductMocks.list;

  //   final res = await dio.get('/products');
  //   return Converter.list(res.data, ProductModel.fromJson);
  // }

  // --- Kitchen ---

  /// GET /v1/kitchen/orders
  Future<List<OrderModel>> fetchKitchenOrders({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      return OrderMocks.kitchenOrders;
    }

    final res = await dio.get('/v1/kitchen/orders');
    return Converter.list(res.data, OrderModel.fromJson);
  }

  /// GET /v1/kitchen/batches
  Future<List<KitchenBatchModel>> fetchKitchenBatches({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      return KitchenBatchMocks.batches;
    }

    final res = await dio.get('/v1/kitchen/batches');
    return Converter.list(res.data, KitchenBatchModel.fromJson);
  }

  /// PATCH /v1/order-items/{id}/status — satu item.
  Future<void> updateOrderItemStatus({
    required int itemId,
    required OrderItemStatus status,
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return;
    }

    await dio.patch(
      '/v1/order-items/$itemId/status',
      data: {'status': status.value},
    );
  }

  /// Update status banyak item (simulasi hit API per item / siap buat BE).
  Future<void> updateOrderItemsStatus({
    required List<int> itemIds,
    required OrderItemStatus status,
    bool? mock,
  }) async {
    if (itemIds.isEmpty) return;

    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 800));
      return;
    }

    for (final itemId in itemIds) {
      await updateOrderItemStatus(itemId: itemId, status: status, mock: false);
    }
  }

  /// POST /v1/kitchen/batches/{id}/process
  Future<void> processKitchenBatch(int batchId, {bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 800));
      return;
    }

    await dio.post('/v1/kitchen/batches/$batchId/process');
  }
}
