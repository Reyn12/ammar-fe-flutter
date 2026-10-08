import '../features/kasir/models/kitchen_account_model.dart';

// TODO: hapus mock ini kalau endpoint kelola dapur sudah siap di backend.
class KitchenAccountMocks {
  const KitchenAccountMocks._();

  static const initial = <KitchenAccountModel>[
    KitchenAccountModel(
      id: 2,
      username: 'dapur',
      name: 'Pak Udin',
      password: '123456',
    ),
    KitchenAccountModel(
      id: 4,
      username: 'dapur2',
      name: 'Bu Sari',
      password: '123456',
    ),
  ];
}
