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
}
