import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/helpers/auth_permission.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/kasir_shift_provider.dart';
import '../providers/owner_shifts_provider.dart';
import '../widgets/kasir_order_list_error.dart';
import '../widgets/kasir_owner_shift_builder.dart';
import '../widgets/kasir_page_header.dart';
import '../widgets/kasir_shift_active_card.dart';
import '../widgets/kasir_shift_closed_card.dart';
import '../widgets/kasir_shift_inactive_card.dart';

class KasirShiftPage extends ConsumerWidget {
  const KasirShiftPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final owner = isOwner(ref.watch(sessionProvider));

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 18,
        children: [
          KasirPageHeader(
            title: owner ? 'Manajemen Shift' : 'Shift Kasir',
            subtitle: owner
                ? 'Pantau shift kasir aktif, riwayat tutup, dan selisih kas.'
                : 'Buka shift sebelum mulai bekerja, tutup shift saat pergantian.',
          ),
          Expanded(
            child: owner
                ? _OwnerShiftBody()
                : SingleChildScrollView(child: _CashierShiftBody()),
          ),
        ],
      ),
    );
  }
}

class _CashierShiftBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(kasirShiftProvider)
        .when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (_, _) => KasirOrderListError(
            onRetry: () => ref.invalidate(kasirShiftProvider),
          ),
          data: (shift) {
            if (shift == null) return const KasirShiftInactiveCard();
            if (shift.isActive) return KasirShiftActiveCard(shift: shift);
            return KasirShiftClosedCard(shift: shift);
          },
        );
  }
}

class _OwnerShiftBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(ownerShiftsProvider)
        .when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => KasirOrderListError(
            onRetry: () => ref.invalidate(ownerShiftsProvider),
          ),
          data: (shifts) => KasirOwnerShiftBuilder(shifts: shifts),
        );
  }
}
