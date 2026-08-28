import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/shift_mocks.dart';
import '../../../models/order_enums.dart';
import '../../../models/shift_model.dart';

part 'kasir_shift_provider.g.dart';

@Riverpod(keepAlive: true)
class KasirShift extends _$KasirShift {
  @override
  Future<ShiftModel?> build() async {
    // TODO: ganti mock ini dengan GET /v1/shifts/active.
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return null;
  }

  /// SKPL-F-008 — buka shift dengan modal awal.
  Future<void> openShift(int startingCash) async {
    // TODO: ganti dengan POST /v1/shifts/open.
    await Future<void>.delayed(const Duration(milliseconds: 500));

    state = AsyncData(
      ShiftModel(
        id: ShiftMocks.activeShift.id,
        userId: ShiftMocks.activeShift.userId,
        userName: ShiftMocks.activeShift.userName,
        startTime: DateTime.now(),
        status: ShiftStatus.active,
        startingCash: startingCash,
        expectedCash: ShiftMocks.activeShift.expectedCash,
        cashOrderCount: ShiftMocks.activeShift.cashOrderCount,
        qrisOrderCount: ShiftMocks.activeShift.qrisOrderCount,
      ),
    );
  }

  /// SKPL-F-008 — tutup shift dan bandingkan uang fisik vs perkiraan sistem.
  Future<void> closeShift(int actualCash) async {
    // TODO: ganti dengan POST /v1/shifts/{id}/close.
    await Future<void>.delayed(const Duration(milliseconds: 500));

    state = AsyncData(
      state.value?.copyWith(
        endTime: DateTime.now(),
        status: ShiftStatus.closed,
        actualCash: actualCash,
      ),
    );
  }

  void reset() => state = const AsyncData(null);
}
