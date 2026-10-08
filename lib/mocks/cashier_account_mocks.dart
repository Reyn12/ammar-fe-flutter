import '../features/kasir/models/cashier_account_model.dart';

// TODO: hapus mock ini kalau endpoint kelola kasir sudah siap di backend.
class CashierAccountMocks {
  const CashierAccountMocks._();

  static const initial = <CashierAccountModel>[
    CashierAccountModel(
      id: 1,
      username: 'kasir',
      name: 'Rani Kasir',
      password: '123456',
    ),
    CashierAccountModel(
      id: 3,
      username: 'kasir2',
      name: 'Budi Kasir',
      password: '123456',
    ),
  ];
}
