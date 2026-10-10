// Tes kontrak: memanggil backend SUNGGUHAN dan memastikan semua model Flutter bisa mem-parse
// responsnya. Hanya baca data (tidak membuat/mengubah apa pun). Dilewati kalau password tidak diberikan:
//
//   flutter test test/api_contract_test.dart \
//     --dart-define=API_CONTRACT_PASSWORD=<password akun owner/kasir1/koki1> \
//     [--dart-define=API_BASE_URL=https://host/api]
import 'dart:io';

import 'package:ammar_fe_flutter/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

const _password = String.fromEnvironment('API_CONTRACT_PASSWORD');
const _baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://api-ammar.pranalatech.com/api',
);

Future<ApiService> _loginAs(String username) async {
  final dio = Dio(BaseOptions(baseUrl: _baseUrl));
  final api = ApiService(dio);
  final result = await api.login(username: username, password: _password);

  expect(result.token?.accessToken, isNotEmpty);
  dio.options.headers['Authorization'] = 'Bearer ${result.token!.accessToken}';
  return api;
}

void main() {
  final skip = _password.isEmpty
      ? 'isi --dart-define=API_CONTRACT_PASSWORD untuk menjalankan tes kontrak'
      : null;

  setUpAll(() => HttpOverrides.global = null); // izinkan koneksi jaringan asli

  group('backend contract', skip: skip, () {
    test('login: akun salah ditolak dengan pesan dari server', () async {
      final api = ApiService(Dio(BaseOptions(baseUrl: _baseUrl)));

      await expectLater(
        api.login(username: 'owner', password: 'salah-total'),
        throwsA(
          isA<DioException>().having(
            (e) => (e.response?.data as Map)['message'],
            'message',
            'Username atau password salah.',
          ),
        ),
      );
    });

    test('owner: kategori, menu, meja, akun staf, shift', () async {
      final api = await _loginAs('owner');

      final categories = await api.fetchCategories();
      expect(categories.length, greaterThanOrEqualTo(6));
      expect(categories.first.name, isNotEmpty);

      final products = await api.fetchProducts();
      expect(products.length, greaterThanOrEqualTo(90));
      final withOptions = products.where(
        (p) => (p.addonGroups ?? []).isNotEmpty,
      );
      expect(withOptions, isNotEmpty);
      final group = withOptions.first.addonGroups!.first;
      expect(group.name, isNotEmpty);
      expect(group.addons, isNotEmpty);

      final tables = await api.fetchTables();
      expect(tables.length, greaterThanOrEqualTo(20));
      expect(tables.first.qrToken, isNotEmpty);
      expect(tables.first.qrPayload, contains('?t=${tables.first.qrToken}'));
      expect(tables.first.qrUrl, isNotNull);

      expect(await api.fetchCashiers(), isNotEmpty);
      expect(await api.fetchKitchenStaff(), isNotEmpty);
      expect(await api.fetchShifts(), isA<List>());
    });

    test('kasir: shift aktif dan pesanan masuk', () async {
      final api = await _loginAs('kasir1');

      // Belum buka shift => null (bukan error).
      expect(await api.fetchActiveShift(), anyOf(isNull, isNotNull));
      expect(await api.fetchIncomingOrders(), isA<List>());
      expect(await api.fetchTransactionHistory(), isA<List>());
    });

    test('koki: papan pesanan dan batch', () async {
      final api = await _loginAs('koki1');

      expect(await api.fetchKitchenOrders(), isA<List>());
      expect(await api.fetchKitchenBatches(), isA<List>());
    });
  });
}
