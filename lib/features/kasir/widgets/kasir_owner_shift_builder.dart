import 'package:flutter/material.dart';

import '../../../models/shift_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/empty_state.dart';
import '../../../widget/surface_card.dart';
import 'kasir_owner_force_close_dialog.dart';
import 'kasir_owner_shift_item.dart';
import 'kasir_owner_shift_summary_bar.dart';

class KasirOwnerShiftBuilder extends StatelessWidget {
  const KasirOwnerShiftBuilder({super.key, required this.shifts});

  final List<ShiftModel> shifts;

  @override
  Widget build(BuildContext context) {
    if (shifts.isEmpty) {
      return const Center(
        child: EmptyState(
          title: 'Belum ada data shift',
          subtitle: 'Shift kasir yang dibuka atau ditutup akan muncul di sini.',
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 18,
      children: [
        KasirOwnerShiftSummaryBar(shifts: shifts),
        Expanded(
          child: SurfaceCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text('Kasir', style: _headerStyle),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('Modal', style: _headerStyle),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('Perkiraan', style: _headerStyle),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('Selisih', style: _headerStyle),
                      ),
                      const SizedBox(width: 72),
                      const SizedBox(width: 120),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: shifts.length,
                    separatorBuilder: (_, _) =>
                        const Divider(height: 1, color: AppColors.neutral30),
                    itemBuilder: (context, index) {
                      final shift = shifts[index];
                      return KasirOwnerShiftItem(
                        shift: shift,
                        onForceClose: shift.isActive
                            ? () => KasirOwnerForceCloseDialog.show(
                                context,
                                shift,
                              )
                            : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static final TextStyle _headerStyle = AppTypography.bodySemiboldS.copyWith(
    color: AppColors.neutral70,
    height: 1.2,
  );
}
