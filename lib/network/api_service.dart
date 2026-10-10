import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/mocks/user_mocks.dart';
import '../features/auth/models/auth_token_model.dart';
import '../features/auth/models/login_result_model.dart';
import '../features/auth/models/user_model.dart';
import '../features/kasir/models/cashier_account_model.dart';
import '../features/kasir/models/kitchen_account_model.dart';
import '../features/kasir/models/table_account_model.dart';
import '../features/kitchen/models/kitchen_batch_model.dart';
import '../mocks/cashier_account_mocks.dart';
import '../mocks/kitchen_account_mocks.dart';
import '../mocks/kitchen_batch_mocks.dart';
import '../mocks/order_mocks.dart';
import '../mocks/product_mocks.dart';
import '../mocks/shift_mocks.dart';
import '../mocks/table_account_mocks.dart';
import '../models/category_model.dart';
import '../models/order_enums.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/shift_model.dart';
import 'api/api_response.dart';
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

  // ---------------------------------------------------------------------------
  // Auth
  // ---------------------------------------------------------------------------

  /// POST /v1/auth/login
  Future<LoginResultModel> login({
    required String username,
    required String password,
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 900));
      final user = _mockLoginUser(username: username, password: password);
      if (user == null) {
        throw ApiError(message: 'Username atau password salah.');
      }
      return LoginResultModel(
        token: const AuthTokenModel(
          accessToken: 'mock-access-token',
          refreshToken: 'mock-refresh-token',
          tokenType: 'Bearer',
          expiresIn: 3600,
        ),
        user: user,
      );
    }

    final res = await dio.post(
      '/v1/auth/login',
      data: {'username': username, 'password': password},
    );
    return Converter.single(res.data, LoginResultModel.fromJson);
  }

  /// POST /v1/auth/logout
  Future<void> logout({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return;
    }
    await dio.post('/v1/auth/logout');
  }

  /// POST /v1/devices - daftarkan token FCM perangkat untuk push pesanan masuk.
  Future<void> registerDevice({required String token, bool? mock}) async {
    if (useMock(mock)) return;
    await dio.post(
      '/v1/devices',
      data: {'token': token, 'platform': 'android'},
    );
  }

  /// DELETE /v1/devices - lepas token FCM perangkat (saat logout).
  Future<void> unregisterDevice({required String token, bool? mock}) async {
    if (useMock(mock)) return;
    await dio.delete('/v1/devices', data: {'token': token});
  }

  /// POST /v1/auth/change-password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return;
    }

    await dio.post(
      '/v1/auth/change-password',
      data: {'current_password': currentPassword, 'new_password': newPassword},
    );
  }

  // ---------------------------------------------------------------------------
  // Orders (Kasir)
  // ---------------------------------------------------------------------------

  /// GET /v1/orders?status=paid|pending_cash
  Future<List<OrderModel>> fetchIncomingOrders({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      return OrderMocks.incomingOrders;
    }

    final res = await dio.get(
      '/v1/orders',
      queryParameters: {'status': 'paid,pending_cash'},
    );
    return Converter.list(res.data, OrderModel.fromJson);
  }

  /// GET /v1/orders?status=completed
  Future<List<OrderModel>> fetchTransactionHistory({
    int? shiftId,
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      return OrderMocks.historyOrders;
    }

    final res = await dio.get(
      '/v1/orders',
      queryParameters: {
        'status': 'completed',
        if (shiftId != null) 'shift_id': shiftId,
      },
    );
    return Converter.list(res.data, OrderModel.fromJson);
  }

  /// GET /v1/orders/{id}
  Future<OrderModel> fetchOrderDetail(int orderId, {bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      for (final order in [
        ...OrderMocks.incomingOrders,
        ...OrderMocks.historyOrders,
      ]) {
        if (order.id == orderId) return order;
      }
      throw ApiError(message: 'Order tidak ditemukan.');
    }

    final res = await dio.get('/v1/orders/$orderId');
    return Converter.single(res.data, OrderModel.fromJson);
  }

  /// POST /v1/orders/{id}/confirm-cash
  Future<OrderModel> confirmCashPayment({
    required int orderId,
    int? receivedAmount,
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      for (final order in OrderMocks.incomingOrders) {
        if (order.id == orderId) {
          return order.copyWith(paymentStatus: PaymentStatus.paid);
        }
      }
      throw ApiError(message: 'Order tidak ditemukan.');
    }

    final res = await dio.post(
      '/v1/orders/$orderId/confirm-cash',
      data: {if (receivedAmount != null) 'received_amount': receivedAmount},
    );
    return Converter.single(res.data, OrderModel.fromJson);
  }

  // ---------------------------------------------------------------------------
  // Shifts
  // ---------------------------------------------------------------------------

  /// GET /v1/shifts/active — null kalau belum buka shift.
  Future<ShiftModel?> fetchActiveShift({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      // Mock default: kasir belum buka shift → UI auto-prompt.
      return null;
    }

    final res = await dio.get('/v1/shifts/active');
    final envelope = ApiEnvelope.fromJson(
      (res.data as Map).cast<String, dynamic>(),
    );
    if (!envelope.success) {
      throw ApiError(message: envelope.message, errors: envelope.errors);
    }
    if (envelope.data == null) return null;
    if (envelope.data is! Map) {
      throw ApiError(message: 'Unexpected data format');
    }
    return ShiftModel.fromJson((envelope.data as Map).cast<String, dynamic>());
  }

  /// GET /v1/shifts — list untuk manajemen owner.
  Future<List<ShiftModel>> fetchShifts({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return [...ShiftMocks.managementList];
    }

    final res = await dio.get('/v1/shifts');
    return Converter.list(res.data, ShiftModel.fromJson);
  }

  /// POST /v1/shifts/open
  Future<ShiftModel> openShift({required int startingCash, bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return ShiftModel(
        id: ShiftMocks.activeShift.id,
        userId: ShiftMocks.activeShift.userId,
        userName: ShiftMocks.activeShift.userName,
        startTime: DateTime.now(),
        status: ShiftStatus.active,
        startingCash: startingCash,
        expectedCash: startingCash,
        cashOrderCount: 0,
        qrisOrderCount: 0,
      );
    }

    final res = await dio.post(
      '/v1/shifts/open',
      data: {'starting_cash': startingCash},
    );
    return Converter.single(res.data, ShiftModel.fromJson);
  }

  /// POST /v1/shifts/{id}/close
  Future<ShiftModel> closeShift({
    required int shiftId,
    required int actualCash,
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return ShiftMocks.activeShift.copyWith(
        endTime: DateTime.now(),
        status: ShiftStatus.closed,
        actualCash: actualCash,
      );
    }

    final res = await dio.post(
      '/v1/shifts/$shiftId/close',
      data: {'actual_cash': actualCash},
    );
    return Converter.single(res.data, ShiftModel.fromJson);
  }

  /// POST /v1/shifts/{id}/force-close — owner paksa tutup.
  Future<ShiftModel> forceCloseShift({
    required int shiftId,
    required int actualCash,
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      for (final shift in ShiftMocks.managementList) {
        if (shift.id == shiftId) {
          return shift.copyWith(
            endTime: DateTime.now(),
            status: ShiftStatus.closed,
            actualCash: actualCash,
          );
        }
      }
      throw ApiError(message: 'Shift tidak ditemukan.');
    }

    final res = await dio.post(
      '/v1/shifts/$shiftId/force-close',
      data: {'actual_cash': actualCash},
    );
    return Converter.single(res.data, ShiftModel.fromJson);
  }

  // ---------------------------------------------------------------------------
  // Products (Kelola Menu)
  // ---------------------------------------------------------------------------

  /// GET /v1/products
  Future<List<ProductModel>> fetchProducts({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      return ProductMocks.products;
    }

    final res = await dio.get('/v1/products');
    return Converter.list(res.data, ProductModel.fromJson);
  }

  /// GET /v1/categories
  Future<List<CategoryModel>> fetchCategories({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return ProductMocks.categories;
    }

    final res = await dio.get('/v1/categories');
    return Converter.list(res.data, CategoryModel.fromJson);
  }

  /// POST /v1/uploads/product-image (multipart) -> URL foto yang dipakai di `image_url` produk.
  Future<String> uploadProductImage(String filePath, {bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return filePath;
    }

    final form = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        filePath,
        filename: filePath.split(RegExp(r'[\\/]')).last,
      ),
    });
    final res = await dio.post('/v1/uploads/product-image', data: form);
    return Converter.single(res.data, (json) => json['url'].toString());
  }

  /// POST /v1/products
  Future<ProductModel> createProduct(ProductModel product, {bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return ProductModel(
        id: DateTime.now().millisecondsSinceEpoch,
        branchId: product.branchId,
        categoryId: product.categoryId,
        categoryName: product.categoryName,
        imageUrl: product.imageUrl,
        name: product.name,
        price: product.price,
        isAvailable: product.isAvailable,
        addonGroups: product.addonGroups,
      );
    }

    final res = await dio.post('/v1/products', data: _productBody(product));
    return Converter.single(res.data, ProductModel.fromJson);
  }

  /// PUT /v1/products/{id}
  Future<ProductModel> updateProduct(ProductModel product, {bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return product;
    }

    final res = await dio.put(
      '/v1/products/${product.id}',
      data: _productBody(product),
    );
    return Converter.single(res.data, ProductModel.fromJson);
  }

  /// PUT /v1/products/{id} — toggle ketersediaan.
  Future<ProductModel> updateProductAvailability({
    required int productId,
    required bool isAvailable,
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      for (final product in ProductMocks.products) {
        if (product.id == productId) {
          return product.copyWith(isAvailable: isAvailable);
        }
      }
      throw ApiError(message: 'Produk tidak ditemukan.');
    }

    final res = await dio.put(
      '/v1/products/$productId',
      data: {'is_available': isAvailable},
    );
    return Converter.single(res.data, ProductModel.fromJson);
  }

  /// DELETE /v1/products/{id}
  Future<void> deleteProduct(int productId, {bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return;
    }
    await dio.delete('/v1/products/$productId');
  }

  // ---------------------------------------------------------------------------
  // Cashiers (Owner)
  // ---------------------------------------------------------------------------

  /// GET /v1/users?role=cashier
  Future<List<CashierAccountModel>> fetchCashiers({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return [...CashierAccountMocks.initial];
    }

    final res = await dio.get(
      '/v1/users',
      queryParameters: {'role': 'cashier'},
    );
    return Converter.list(res.data, CashierAccountModel.fromJson);
  }

  /// POST /v1/users
  Future<CashierAccountModel> createCashier(
    CashierAccountModel account, {
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return account.copyWith(
        id: DateTime.now().millisecondsSinceEpoch,
        username: account.username.trim().toLowerCase(),
      );
    }

    final res = await dio.post('/v1/users', data: _cashierBody(account));
    return Converter.single(res.data, CashierAccountModel.fromJson);
  }

  /// PUT /v1/users/{id}
  Future<CashierAccountModel> updateCashier(
    CashierAccountModel account, {
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return account.copyWith(username: account.username.trim().toLowerCase());
    }

    final res = await dio.put(
      '/v1/users/${account.id}',
      data: _cashierBody(account),
    );
    return Converter.single(res.data, CashierAccountModel.fromJson);
  }

  /// DELETE /v1/users/{id}
  Future<void> deleteCashier(int userId, {bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return;
    }
    await dio.delete('/v1/users/$userId');
  }

  // ---------------------------------------------------------------------------
  // Kitchen staff (Owner)
  // ---------------------------------------------------------------------------

  /// GET /v1/users?role=kitchen
  Future<List<KitchenAccountModel>> fetchKitchenStaff({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return [...KitchenAccountMocks.initial];
    }

    final res = await dio.get(
      '/v1/users',
      queryParameters: {'role': 'kitchen'},
    );
    return Converter.list(res.data, KitchenAccountModel.fromJson);
  }

  /// POST /v1/users
  Future<KitchenAccountModel> createKitchenStaff(
    KitchenAccountModel account, {
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return account.copyWith(
        id: DateTime.now().millisecondsSinceEpoch,
        username: account.username.trim().toLowerCase(),
      );
    }

    final res = await dio.post('/v1/users', data: _kitchenBody(account));
    return Converter.single(res.data, KitchenAccountModel.fromJson);
  }

  /// PUT /v1/users/{id}
  Future<KitchenAccountModel> updateKitchenStaff(
    KitchenAccountModel account, {
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return account.copyWith(username: account.username.trim().toLowerCase());
    }

    final res = await dio.put(
      '/v1/users/${account.id}',
      data: _kitchenBody(account),
    );
    return Converter.single(res.data, KitchenAccountModel.fromJson);
  }

  /// DELETE /v1/users/{id}
  Future<void> deleteKitchenStaff(int userId, {bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return;
    }
    await dio.delete('/v1/users/$userId');
  }

  // ---------------------------------------------------------------------------
  // Tables (Owner)
  // ---------------------------------------------------------------------------

  /// GET /v1/tables
  Future<List<TableAccountModel>> fetchTables({bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return [...TableAccountMocks.initial];
    }

    final res = await dio.get('/v1/tables');
    return Converter.list(res.data, TableAccountModel.fromJson);
  }

  /// POST /v1/tables
  Future<TableAccountModel> createTable(
    TableAccountModel table, {
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      final number = table.tableNumber.trim().padLeft(2, '0');
      return table.copyWith(
        id: DateTime.now().millisecondsSinceEpoch,
        tableNumber: number,
        qrToken:
            'tbl$number-${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}',
      );
    }

    final res = await dio.post(
      '/v1/tables',
      data: {'branch_id': table.branchId, 'table_number': table.tableNumber},
    );
    return Converter.single(res.data, TableAccountModel.fromJson);
  }

  /// PUT /v1/tables/{id}
  Future<TableAccountModel> updateTable(
    TableAccountModel table, {
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return table.copyWith(
        tableNumber: table.tableNumber.trim().padLeft(2, '0'),
      );
    }

    final res = await dio.put(
      '/v1/tables/${table.id}',
      data: {'table_number': table.tableNumber, 'is_active': table.isActive},
    );
    return Converter.single(res.data, TableAccountModel.fromJson);
  }

  /// DELETE /v1/tables/{id}
  Future<void> deleteTable(int tableId, {bool? mock}) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return;
    }
    await dio.delete('/v1/tables/$tableId');
  }

  /// POST /v1/tables/{id}/regenerate-qr
  Future<TableAccountModel> regenerateTableQr(
    TableAccountModel table, {
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return table.copyWith(
        qrToken:
            'tbl${table.tableNumber}-${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}',
      );
    }

    final res = await dio.post('/v1/tables/${table.id}/regenerate-qr');
    return Converter.single(res.data, TableAccountModel.fromJson);
  }

  // ---------------------------------------------------------------------------
  // Kitchen
  // ---------------------------------------------------------------------------

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

  /// PATCH /v1/order-items/{id}/status
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
  Future<void> processKitchenBatch(
    int batchId, {
    List<int>? orderIds,
    bool? mock,
  }) async {
    if (useMock(mock)) {
      await Future<void>.delayed(const Duration(milliseconds: 800));
      return;
    }

    await dio.post(
      '/v1/kitchen/batches/$batchId/process',
      data: {if (orderIds != null) 'order_ids': orderIds},
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  UserModel? _mockLoginUser({
    required String username,
    required String password,
  }) {
    final normalized = username.trim().toLowerCase();
    if (password != UserMocks.demoPassword) return null;

    if (normalized == UserMocks.demoOwnerUsername) return UserMocks.owner;

    for (final kitchen in KitchenAccountMocks.initial) {
      if (kitchen.username.toLowerCase() != normalized) continue;
      if (!kitchen.isActive) return null;
      if (kitchen.password != password) return null;
      return UserMocks.kitchenFromAccount(
        id: kitchen.id,
        name: kitchen.name,
        username: kitchen.username,
      );
    }

    for (final cashier in CashierAccountMocks.initial) {
      if (cashier.username.toLowerCase() != normalized) continue;
      if (!cashier.isActive) return null;
      if (cashier.password != password) return null;
      return UserMocks.cashierFromAccount(
        id: cashier.id,
        name: cashier.name,
        username: cashier.username,
      );
    }
    return null;
  }

  Map<String, dynamic> _productBody(ProductModel product) => {
    'branch_id': product.branchId,
    'category_id': product.categoryId,
    'image_url': product.imageUrl,
    'name': product.name,
    'price': product.price,
    'is_available': product.isAvailable,
  };

  Map<String, dynamic> _cashierBody(CashierAccountModel account) => {
    'username': account.username,
    'name': account.name,
    'password': account.password,
    'role': 'cashier',
    'is_active': account.isActive,
  };

  Map<String, dynamic> _kitchenBody(KitchenAccountModel account) => {
    'username': account.username,
    'name': account.name,
    'password': account.password,
    'role': 'kitchen',
    'is_active': account.isActive,
  };
}
