import '../features/kasir/models/table_account_model.dart';

// TODO: hapus mock ini kalau endpoint kelola meja sudah siap di backend.
class TableAccountMocks {
  const TableAccountMocks._();

  static const initial = <TableAccountModel>[
    TableAccountModel(
      id: 1,
      branchId: 1,
      tableNumber: '01',
      qrToken: 'tbl01-a1b2',
    ),
    TableAccountModel(
      id: 4,
      branchId: 1,
      tableNumber: '04',
      qrToken: 'tbl04-c3d4',
    ),
    TableAccountModel(
      id: 12,
      branchId: 1,
      tableNumber: '12',
      qrToken: 'tbl12-e5f6',
    ),
  ];
}
