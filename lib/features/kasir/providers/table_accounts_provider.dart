import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/table_account_mocks.dart';
import '../../../network/api_service.dart';
import '../models/table_account_model.dart';

part 'table_accounts_provider.g.dart';

@Riverpod(keepAlive: true)
class TableAccounts extends _$TableAccounts {
  @override
  List<TableAccountModel> build() => [...TableAccountMocks.initial];

  Future<void> save(TableAccountModel table) async {
    final api = ref.read(apiServiceProvider);
    final number = table.tableNumber.trim().padLeft(2, '0');
    final duplicate = state.any(
      (item) => item.tableNumber == number && item.id != table.id,
    );
    if (duplicate) {
      throw Exception('Nomor meja $number sudah ada.');
    }

    final payload = table.copyWith(tableNumber: number);
    final saved = table.id == 0
        ? await api.createTable(payload)
        : await api.updateTable(payload);

    if (table.id == 0) {
      state = [...state, saved]
        ..sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
      return;
    }

    state = [
      for (final item in state)
        if (item.id == table.id) saved else item,
    ]..sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
  }

  Future<void> delete(int id) async {
    await ref.read(apiServiceProvider).deleteTable(id);
    state = [for (final item in state) if (item.id != id) item];
  }

  Future<void> toggleActive(int id) async {
    TableAccountModel? current;
    for (final item in state) {
      if (item.id == id) current = item;
    }
    if (current == null) return;

    final updated = await ref
        .read(apiServiceProvider)
        .updateTable(current.copyWith(isActive: !current.isActive));

    state = [
      for (final item in state)
        if (item.id == id) updated else item,
    ];
  }

  Future<TableAccountModel> regenerateQr(int id) async {
    TableAccountModel? current;
    for (final item in state) {
      if (item.id == id) current = item;
    }
    if (current == null) {
      throw Exception('Meja tidak ditemukan.');
    }

    final updated = await ref
        .read(apiServiceProvider)
        .regenerateTableQr(current);
    state = [
      for (final item in state)
        if (item.id == id) updated else item,
    ];
    return updated;
  }
}
