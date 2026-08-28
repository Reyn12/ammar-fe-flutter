import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../models/shift_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/primary_button.dart';
import '../providers/kasir_shift_provider.dart';
import 'kasir_order_summary_row.dart';

class KasirShiftCloseDialog extends ConsumerStatefulWidget {
  const KasirShiftCloseDialog({super.key, required this.shift});

  final ShiftModel shift;

  static Future<void> show(BuildContext context, ShiftModel shift) {
    return showDialog<void>(
      context: context,
      builder: (_) => KasirShiftCloseDialog(shift: shift),
    );
  }

  @override
  ConsumerState<KasirShiftCloseDialog> createState() =>
      _KasirShiftCloseDialogState();
}

class _KasirShiftCloseDialogState extends ConsumerState<KasirShiftCloseDialog> {
  final actualCashController = TextEditingController();
  bool isSubmitting = false;

  int get _expected => widget.shift.expectedCash ?? 0;

  int get _actual =>
      int.tryParse(actualCashController.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
      0;

  int get _difference => _actual - _expected;

  Future<void> _submit() async {
    setState(() => isSubmitting = true);
    await ref.read(kasirShiftProvider.notifier).closeShift(_actual);

    if (!mounted) return;
    setState(() => isSubmitting = false);
    Navigator.of(context).pop();
    CustomSnackbar.success(
      context,
      _difference == 0
          ? 'Uang fisik cocok dengan perkiraan sistem.'
          : 'Selisih ${formatRupiah(_difference.abs())} '
                '(${_difference > 0 ? 'lebih' : 'kurang'}).',
      title: 'Shift Ditutup',
    );
  }

  @override
  void dispose() {
    actualCashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.neutral10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: FormBuilder(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 18,
              children: [
                Text(
                  'Tutup Shift',
                  style: AppTypography.h8Bold.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                Text(
                  'Hitung uang fisik di laci lalu masukkan nominalnya. Sistem '
                  'akan membandingkan dengan perkiraan kas.',
                  style: AppTypography.bodyRegularM.copyWith(
                    color: AppColors.neutral70,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    spacing: 8,
                    children: [
                      KasirOrderSummaryRow(
                        label: 'Modal Awal',
                        value: formatRupiah(widget.shift.startingCash ?? 0),
                      ),
                      KasirOrderSummaryRow(
                        label: 'Perkiraan Kas Sistem',
                        value: formatRupiah(_expected),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  name: 'actual_cash',
                  label: 'Uang Fisik di Laci',
                  hint: 'Contoh: 1245000',
                  keyboardType: TextInputType.number,
                  action: TextInputAction.done,
                  controller: actualCashController,
                  isRequired: false,
                  onChanged: (_) => setState(() {}),
                ),
                if (_actual > 0)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _difference == 0
                          ? AppColors.successSoft
                          : AppColors.warningSurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _difference == 0
                          ? 'Pas, tidak ada selisih.'
                          : 'Selisih ${formatRupiah(_difference.abs())} '
                                '(${_difference > 0 ? 'lebih' : 'kurang'}) dari '
                                'perkiraan sistem.',
                      style: AppTypography.bodySemiboldM.copyWith(
                        color: _difference == 0
                            ? AppColors.successMain
                            : AppColors.warningPressed,
                      ),
                    ),
                  ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: 'Batal',
                        reverse: true,
                        borderColor: AppColors.neutral40,
                        textColor: AppColors.neutral80,
                        height: 48,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Expanded(
                      child: PrimaryButton(
                        text: isSubmitting ? 'Memproses...' : 'Tutup Shift',
                        color: AppColors.dangerMain,
                        height: 48,
                        enabled: !isSubmitting && _actual > 0,
                        onPressed: _submit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
