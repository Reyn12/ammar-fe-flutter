import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/primary_button.dart';
import '../providers/kasir_shift_provider.dart';

class KasirShiftOpenDialog extends ConsumerStatefulWidget {
  const KasirShiftOpenDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const KasirShiftOpenDialog(),
    );
  }

  @override
  ConsumerState<KasirShiftOpenDialog> createState() =>
      _KasirShiftOpenDialogState();
}

class _KasirShiftOpenDialogState extends ConsumerState<KasirShiftOpenDialog> {
  final startingCashController = TextEditingController();
  bool isSubmitting = false;

  int get _startingCash =>
      int.tryParse(
        startingCashController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      ) ??
      0;

  @override
  void dispose() {
    startingCashController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => isSubmitting = true);
    await ref.read(kasirShiftProvider.notifier).openShift(_startingCash);

    if (!mounted) return;
    setState(() => isSubmitting = false);
    Navigator.of(context).pop();
    CustomSnackbar.success(
      context,
      'Shift dibuka dengan modal awal ${formatRupiah(_startingCash)}.',
      title: 'Shift Aktif',
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  'Buka Shift',
                  style: AppTypography.h8Bold.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                Text(
                  'Masukkan modal awal laci kas sebelum mulai menerima '
                  'pembayaran tunai.',
                  style: AppTypography.bodyRegularM.copyWith(
                    color: AppColors.neutral70,
                  ),
                ),
                CustomTextField(
                  name: 'starting_cash',
                  label: 'Modal Awal',
                  hint: 'Contoh: 300000',
                  keyboardType: TextInputType.number,
                  action: TextInputAction.done,
                  controller: startingCashController,
                  isRequired: false,
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
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Expanded(
                      child: PrimaryButton(
                        text: isSubmitting ? 'Memproses...' : 'Buka Shift',
                        height: 48,
                        enabled: !isSubmitting && _startingCash > 0,
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
