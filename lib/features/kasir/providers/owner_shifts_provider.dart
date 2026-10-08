import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../mocks/shift_mocks.dart';
import '../../../models/order_enums.dart';
import '../../../models/shift_model.dart';

part 'owner_shifts_provider.g.dart';

/// Manajemen shift dari sisi owner (pantau + force close).
@Riverpod(keepAlive: true)
class OwnerShifts extends _$OwnerShifts {
  @override
  Future<List<ShiftModel>> build() async {
    // TODO: ganti mock ini dengan GET /v1/shifts.
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return [...ShiftMocks.managementList];
  }

  /// Owner menutup paksa shift kasir yang masih aktif.
  Future<void> forceClose({
    required int shiftId,
    required int actualCash,
  }) async {
    // TODO: ganti dengan POST /v1/shifts/{id}/force-close.
    await Future<void>.delayed(const Duration(milliseconds: 500));

    state = AsyncData([
      for (final shift in state.value ?? <ShiftModel>[])
        if (shift.id == shiftId)
          shift.copyWith(
            endTime: DateTime.now(),
            status: ShiftStatus.closed,
            actualCash: actualCash,
          )
        else
          shift,
    ]);
  }
}
