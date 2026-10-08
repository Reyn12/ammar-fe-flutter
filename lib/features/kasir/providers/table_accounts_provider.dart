import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/table_account_mocks.dart';
import '../models/table_account_model.dart';

part 'table_accounts_provider.g.dart';

@Riverpod(keepAlive: true)
class TableAccounts extends _$TableAccounts {
  @override
  List<TableAccountModel> build() => [...TableAccountMocks.initial];

  String _newToken(String tableNumber) {
    final stamp = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
    return 'tbl$tableNumber-$stamp';
  }

  Future<void> save(TableAccountModel table) async {
    // TODO: ganti dengan POST/PUT /v1/tables.
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final number = table.tableNumber.trim().padLeft(2, '0');
    final duplicate = state.any(
      (item) => item.tableNumber == number && item.id != table.id,
    );
    if (duplicate) {
      throw Exception('Nomor meja $number sudah ada.');
    }

    if (table.id == 0) {
      state = [
        ...state,
        table.copyWith(
          id: DateTime.now().millisecondsSinceEpoch,
          tableNumber: number,
          qrToken: _newToken(number),
        ),
      ]..sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
      return;
    }

    state = [
      for (final item in state)
        if (item.id == table.id)
          table.copyWith(tableNumber: number)
        else
          item,
    ]..sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
  }

  Future<void> delete(int id) async {
    // TODO: ganti dengan DELETE /v1/tables/{id}.
    await Future<void>.delayed(const Duration(milliseconds: 400));
    state = [for (final item in state) if (item.id != id) item];
  }

  Future<void> toggleActive(int id) async {
    // TODO: ganti dengan PUT /v1/tables/{id}.
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(isActive: !item.isActive) else item,
    ];
  }

  /// Generate ulang token QR — QR lama tidak valid lagi.
  Future<TableAccountModel> regenerateQr(int id) async {
    // TODO: ganti dengan POST /v1/tables/{id}/regenerate-qr.
    await Future<void>.delayed(const Duration(milliseconds: 400));

    late TableAccountModel updated;
    state = [
      for (final item in state)
        if (item.id == id)
          updated = item.copyWith(qrToken: _newToken(item.tableNumber))
        else
          item,
    ];
    return updated;
  }
}
