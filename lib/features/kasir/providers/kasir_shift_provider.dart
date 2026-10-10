import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/shift_model.dart';
import '../../../network/api_service.dart';

part 'kasir_shift_provider.g.dart';

@Riverpod(keepAlive: true)
class KasirShift extends _$KasirShift {
  @override
  Future<ShiftModel?> build() async {
    return ref.watch(apiServiceProvider).fetchActiveShift();
  }

  /// Ambil ulang shift aktif tanpa loading (angka transaksi berubah saat ada pesanan lunas).
  Future<void> refresh() async {
    state = AsyncData(await ref.read(apiServiceProvider).fetchActiveShift());
  }

  /// SKPL-F-008 — buka shift dengan modal awal.
  Future<void> openShift(int startingCash) async {
    final shift = await ref
        .read(apiServiceProvider)
        .openShift(startingCash: startingCash);
    state = AsyncData(shift);
  }

  /// SKPL-F-008 — tutup shift dan bandingkan uang fisik vs perkiraan sistem.
  Future<void> closeShift(int actualCash) async {
    final current = state.value;
    if (current?.id == null) return;

    final closed = await ref
        .read(apiServiceProvider)
        .closeShift(shiftId: current!.id!, actualCash: actualCash);
    state = AsyncData(closed);
  }

  void reset() => state = const AsyncData(null);
}
