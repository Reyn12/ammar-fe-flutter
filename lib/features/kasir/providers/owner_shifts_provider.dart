import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/shift_model.dart';
import '../../../network/api_service.dart';

part 'owner_shifts_provider.g.dart';

/// Manajemen shift dari sisi owner (pantau + force close).
@Riverpod(keepAlive: true)
class OwnerShifts extends _$OwnerShifts {
  @override
  Future<List<ShiftModel>> build() async {
    return ref.watch(apiServiceProvider).fetchShifts();
  }

  /// Owner menutup paksa shift kasir yang masih aktif.
  Future<void> forceClose({
    required int shiftId,
    required int actualCash,
  }) async {
    final closed = await ref
        .read(apiServiceProvider)
        .forceCloseShift(shiftId: shiftId, actualCash: actualCash);

    state = AsyncData([
      for (final shift in state.value ?? <ShiftModel>[])
        if (shift.id == shiftId) closed else shift,
    ]);
  }
}
