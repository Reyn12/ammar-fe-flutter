import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/cashier_account_mocks.dart';
import '../../../network/api_service.dart';
import '../models/cashier_account_model.dart';

part 'cashier_accounts_provider.g.dart';

@Riverpod(keepAlive: true)
class CashierAccounts extends _$CashierAccounts {
  @override
  List<CashierAccountModel> build() => [...CashierAccountMocks.initial];

  Future<void> save(CashierAccountModel account) async {
    final api = ref.read(apiServiceProvider);
    final username = account.username.trim().toLowerCase();
    final duplicate = state.any(
      (item) =>
          item.username.toLowerCase() == username && item.id != account.id,
    );
    if (duplicate) {
      throw Exception('Username "$username" sudah dipakai.');
    }

    final payload = account.copyWith(username: username);
    final saved = account.id == 0
        ? await api.createCashier(payload)
        : await api.updateCashier(payload);

    if (account.id == 0) {
      state = [...state, saved];
      return;
    }

    state = [
      for (final item in state)
        if (item.id == account.id) saved else item,
    ];
  }

  Future<void> delete(int id) async {
    await ref.read(apiServiceProvider).deleteCashier(id);
    state = [for (final item in state) if (item.id != id) item];
  }

  Future<void> toggleActive(int id) async {
    CashierAccountModel? current;
    for (final item in state) {
      if (item.id == id) current = item;
    }
    if (current == null) return;

    final updated = await ref
        .read(apiServiceProvider)
        .updateCashier(current.copyWith(isActive: !current.isActive));

    state = [
      for (final item in state)
        if (item.id == id) updated else item,
    ];
  }
}
