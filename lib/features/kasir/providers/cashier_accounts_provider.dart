import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/cashier_account_mocks.dart';
import '../models/cashier_account_model.dart';

part 'cashier_accounts_provider.g.dart';

@Riverpod(keepAlive: true)
class CashierAccounts extends _$CashierAccounts {
  @override
  List<CashierAccountModel> build() => [...CashierAccountMocks.initial];

  Future<void> save(CashierAccountModel account) async {
    // TODO: ganti dengan POST/PUT /v1/users (role cashier).
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final username = account.username.trim().toLowerCase();
    final duplicate = state.any(
      (item) =>
          item.username.toLowerCase() == username && item.id != account.id,
    );
    if (duplicate) {
      throw Exception('Username "$username" sudah dipakai.');
    }

    if (account.id == 0) {
      state = [
        ...state,
        account.copyWith(
          id: DateTime.now().millisecondsSinceEpoch,
          username: username,
        ),
      ];
      return;
    }

    state = [
      for (final item in state)
        if (item.id == account.id)
          account.copyWith(username: username)
        else
          item,
    ];
  }

  Future<void> delete(int id) async {
    // TODO: ganti dengan DELETE /v1/users/{id}.
    await Future<void>.delayed(const Duration(milliseconds: 400));
    state = [for (final item in state) if (item.id != id) item];
  }

  Future<void> toggleActive(int id) async {
    // TODO: ganti dengan PUT /v1/users/{id}.
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(isActive: !item.isActive) else item,
    ];
  }
}
