// Tes alur penuh terhadap backend SUNGGUHAN: pelanggan memesan -> kasir konfirmasi tunai ->
// dapur memproses -> pesanan selesai -> kasir tutup shift, sambil mendengarkan event SSE.
//
// MEMBUAT DATA. Jalankan hanya terhadap backend lokal dengan database seed (password akun = "password"):
//
//   flutter test test/api_e2e_test.dart --dart-define=API_E2E=true \
//     --dart-define=API_BASE_URL=http://127.0.0.1:8010/api
import 'dart:io';

import 'package:ammar_fe_flutter/models/order_enums.dart';
import 'package:ammar_fe_flutter/network/api_service.dart';
import 'package:ammar_fe_flutter/network/dio_client_provider.dart';
import 'package:ammar_fe_flutter/network/staff_events_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _enabled = bool.fromEnvironment('API_E2E');
const _baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://127.0.0.1:8010/api',
);
const _password = String.fromEnvironment(
  'API_E2E_PASSWORD',
  defaultValue: 'password',
);

Future<(ApiService, Dio)> _loginAs(String username) async {
  final dio = Dio(BaseOptions(baseUrl: _baseUrl));
  final api = ApiService(dio);
  final result = await api.login(username: username, password: _password);
  dio.options.headers['Authorization'] = 'Bearer ${result.token!.accessToken}';
  return (api, dio);
}

void main() {
  setUpAll(() => HttpOverrides.global = null);

  test(
    'pesan -> kasir -> dapur -> selesai, dengan event SSE',
    skip: _enabled ? null : 'set --dart-define=API_E2E=true (membuat data!)',
    timeout: const Timeout(Duration(minutes: 2)),
    () async {
      final (kasir, kasirDio) = await _loginAs('kasir1');
      final (koki, kokiDio) = await _loginAs('koki1');

      // --- dengarkan SSE sebagai kasir lewat provider asli
      final container = ProviderContainer(
        overrides: [dioClientProvider.overrideWithValue(kasirDio)],
      );
      addTearDown(container.dispose);
      final events = <StaffEvent>[];
      container.listen<AsyncValue<StaffEvent>>(staffEventsProvider, (_, next) {
        final event = next.value;
        if (event != null) events.add(event);
      });
      await Future<void>.delayed(const Duration(seconds: 3));
      expect(
        container.read(staffEventsConnectionProvider),
        isTrue,
        reason: 'SSE harus tersambung',
      );

      // --- pelanggan membuat pesanan tunai (takeaway)
      final customer = Dio(BaseOptions(baseUrl: _baseUrl));
      final menu = await customer.get('/v1/branches/1/menu', queryParameters: {'q': 'Nasi Putih Porsi'});
      final product = (menu.data['data'][0]['products'] as List).first as Map;
      final created = await customer.post('/v1/orders', data: {
        'branch_id': 1,
        'order_type': 'takeaway',
        'payment_method': 'cash',
        'customer': {'name': 'Tes Flutter', 'phone': '081200000001'},
        'items': [
          {'product_id': product['id'], 'qty': 2, 'notes': 'tes e2e'},
        ],
      });
      final code = created.data['data']['code'] as String;
      final total = created.data['data']['total_amount'] as int;

      // --- kasir: belum buka shift, buka shift, lihat pesanan tunai menunggu
      expect(await kasir.fetchActiveShift(), isNull);
      final shift = await kasir.openShift(startingCash: 100000);
      expect(shift.status, ShiftStatus.active);
      expect(shift.expectedCash, 100000);

      final incoming = await kasir.fetchIncomingOrders();
      final order = incoming.firstWhere((o) => o.code == code);
      expect(order.needCashConfirmation, isTrue);
      expect(order.orderType, OrderType.takeaway);
      expect(order.placeLabel, 'Takeaway');
      expect(order.items!.single.productName, 'Nasi Putih Porsi');
      expect(order.items!.single.qty, 2);
      expect(order.items!.single.notes, 'tes e2e');
      expect(order.totalAmount, total);

      // --- uang kurang ditolak, uang cukup diterima
      await expectLater(
        kasir.confirmCashPayment(orderId: order.id!, receivedAmount: 1000),
        throwsA(isA<DioException>().having(
          (e) => (e.response?.data as Map)['message'],
          'message',
          'Uang yang diterima kurang dari total tagihan.',
        )),
      );
      final paid = await kasir.confirmCashPayment(
        orderId: order.id!,
        receivedAmount: total + 5000,
      );
      expect(paid.paymentStatus, PaymentStatus.paid);

      // --- dapur: pesanan dan batch muncul
      final kitchenOrders = await koki.fetchKitchenOrders();
      final kitchenOrder = kitchenOrders.firstWhere((o) => o.code == code);
      expect(kitchenOrder.status, OrderStatus.pending);

      final batches = await koki.fetchKitchenBatches();
      final batch = batches.firstWhere((b) => b.productName == 'Nasi Putih Porsi');
      expect(batch.totalQty, 2);
      expect(batch.tables!.single.orderCode, code);
      expect(batch.tables!.single.tableLabel, 'Takeaway');
      expect(batch.tables!.single.qty, 2);

      // --- dapur memproses lalu menyajikan
      await koki.processKitchenBatch(batch.id!);
      final cooking = (await koki.fetchKitchenOrders()).firstWhere((o) => o.code == code);
      expect(cooking.status, OrderStatus.cooking);
      expect(cooking.items!.single.status, OrderItemStatus.cooking);
      expect((await koki.fetchKitchenBatches()).where((b) => b.id == batch.id), isEmpty);

      await koki.updateOrderItemStatus(
        itemId: cooking.items!.single.id!,
        status: OrderItemStatus.ready,
      );
      expect((await koki.fetchKitchenOrders()).where((o) => o.code == code), isEmpty);

      // --- kasir: pesanan masuk riwayat, lalu tutup shift
      final history = await kasir.fetchTransactionHistory();
      expect(history.firstWhere((o) => o.code == code).status, OrderStatus.completed);

      final active = await kasir.fetchActiveShift();
      expect(active!.cashOrderCount, 1);
      expect(active.expectedCash, 100000 + total);

      final closed = await kasir.closeShift(shiftId: shift.id!, actualCash: 100000 + total);
      expect(closed.status, ShiftStatus.closed);
      expect(closed.expectedCash, 100000 + total);
      expect(await kasir.fetchActiveShift(), isNull);

      // --- SSE: semua langkah tadi harus terpantau (beri waktu event terakhir sampai)
      await Future<void>.delayed(const Duration(seconds: 3));
      final types = events.map((e) => e.type).toList();
      expect(types, containsAll(['order.created', 'order.paid', 'kitchen.updated']));
      final created0 = events.firstWhere((e) => e.type == 'order.created');
      expect(created0.paymentMethod, 'cash');
      expect(created0.data['code'], code);

      kokiDio.close();
    },
  );
}
