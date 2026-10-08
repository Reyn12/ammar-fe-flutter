import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../helper/validator.dart';
import '../../../models/shift_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/primary_button.dart';
import '../providers/owner_shifts_provider.dart';

class KasirOwnerForceCloseDialog extends ConsumerStatefulWidget {
  const KasirOwnerForceCloseDialog({super.key, required this.shift});

  final ShiftModel shift;

  static Future<void> show(BuildContext context, ShiftModel shift) {
    return showDialog<void>(
      context: context,
      builder: (_) => KasirOwnerForceCloseDialog(shift: shift),
    );
  }

  @override
  ConsumerState<KasirOwnerForceCloseDialog> createState() =>
      _KasirOwnerForceCloseDialogState();
}

class _KasirOwnerForceCloseDialogState
    extends ConsumerState<KasirOwnerForceCloseDialog> {
  final actualCashController = TextEditingController();
  bool isSubmitting = false;

  int get _actualCash =>
      int.tryParse(
        actualCashController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      ) ??
      0;

  @override
  void dispose() {
    actualCashController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => isSubmitting = true);
    await ref
        .read(ownerShiftsProvider.notifier)
        .forceClose(shiftId: widget.shift.id ?? 0, actualCash: _actualCash);

    if (!mounted) return;
    Navigator.of(context).pop();
    CustomSnackbar.success(
      context,
      'Shift ${widget.shift.userName ?? 'kasir'} ditutup paksa '
      'dengan uang fisik ${formatRupiah(_actualCash)}.',
      title: 'Shift Ditutup',
    );
  }

  @override
  Widget build(BuildContext context) {
    final expected = widget.shift.expectedCash ?? 0;

    return Dialog(
      backgroundColor: AppColors.neutral10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: FormBuilder(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 18,
              children: [
                Text(
                  'Paksa Tutup Shift?',
                  style: AppTypography.h8Bold.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                Text(
                  'Shift ${widget.shift.userName ?? 'kasir'} masih aktif. '
                  'Pakai ini kalau kasir lupa tutup atau ada kendala. '
                  'Perkiraan kas sistem: ${formatRupiah(expected)}.',
                  style: AppTypography.bodyRegularM.copyWith(
                    color: AppColors.neutral70,
                  ),
                ),
                CustomTextField(
                  name: 'actual_cash',
                  label: 'Uang Fisik di Laci',
                  hint: 'Contoh: 1245000',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: actualCashController,
                  validators: [Validator.required()],
                  onChanged: (_) => setState(() {}),
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
                        enabled: !isSubmitting,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Expanded(
                      child: PrimaryButton(
                        text: 'Tutup Paksa',
                        color: AppColors.dangerMain,
                        height: 48,
                        enabled:
                            !isSubmitting &&
                            actualCashController.text.trim().isNotEmpty,
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
