import '../models/order_enums.dart';
import '../models/shift_model.dart';

// TODO: hapus file ini kalau endpoint /v1/shifts sudah siap di backend.
class ShiftMocks {
  const ShiftMocks._();

  static ShiftModel get activeShift => ShiftModel(
    id: 1,
    userId: 1,
    userName: 'Rani Kasir',
    startTime: DateTime.now().subtract(const Duration(hours: 4, minutes: 20)),
    status: ShiftStatus.active,
    startingCash: 300000,
    expectedCash: 1245000,
    cashOrderCount: 12,
    qrisOrderCount: 27,
  );

  /// Riwayat shift ditutup — dipakai manajemen owner.
  static List<ShiftModel> get closedHistory {
    final now = DateTime.now();
    return [
      ShiftModel(
        id: 10,
        userId: 3,
        userName: 'Budi Kasir',
        startTime: now.subtract(const Duration(hours: 12)),
        endTime: now.subtract(const Duration(hours: 6)),
        status: ShiftStatus.closed,
        startingCash: 250000,
        expectedCash: 980000,
        actualCash: 975000,
        cashOrderCount: 8,
        qrisOrderCount: 15,
      ),
      ShiftModel(
        id: 9,
        userId: 1,
        userName: 'Rani Kasir',
        startTime: now.subtract(const Duration(days: 1, hours: 10)),
        endTime: now.subtract(const Duration(days: 1, hours: 2)),
        status: ShiftStatus.closed,
        startingCash: 300000,
        expectedCash: 1520000,
        actualCash: 1520000,
        cashOrderCount: 14,
        qrisOrderCount: 31,
      ),
      ShiftModel(
        id: 8,
        userId: 3,
        userName: 'Budi Kasir',
        startTime: now.subtract(const Duration(days: 2, hours: 9)),
        endTime: now.subtract(const Duration(days: 2, hours: 1)),
        status: ShiftStatus.closed,
        startingCash: 200000,
        expectedCash: 640000,
        actualCash: 655000,
        cashOrderCount: 5,
        qrisOrderCount: 9,
      ),
    ];
  }

  /// Seed awal list manajemen owner (ada 1 aktif + riwayat).
  static List<ShiftModel> get managementList => [
    activeShift,
    ...closedHistory,
  ];
}
