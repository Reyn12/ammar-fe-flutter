import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/validator.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/primary_button.dart';
import '../models/table_account_model.dart';
import '../providers/table_accounts_provider.dart';

class KasirTableFormDialog extends ConsumerStatefulWidget {
  const KasirTableFormDialog({super.key, this.table});

  final TableAccountModel? table;

  static Future<void> show(BuildContext context, [TableAccountModel? table]) {
    return showDialog<void>(
      context: context,
      builder: (_) => KasirTableFormDialog(table: table),
    );
  }

  @override
  ConsumerState<KasirTableFormDialog> createState() =>
      _KasirTableFormDialogState();
}

class _KasirTableFormDialogState extends ConsumerState<KasirTableFormDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final TextEditingController numberController;
  bool isSubmitting = false;

  bool get _isEdit => widget.table != null;

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController(
      text: widget.table?.tableNumber ?? '',
    );
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;

    setState(() => isSubmitting = true);
    try {
      await ref
          .read(tableAccountsProvider.notifier)
          .save(
            TableAccountModel(
              id: widget.table?.id ?? 0,
              branchId: widget.table?.branchId ?? 1,
              tableNumber: numberController.text.trim(),
              qrToken: widget.table?.qrToken ?? '',
              isActive: widget.table?.isActive ?? true,
            ),
          );
      if (!mounted) return;
      Navigator.of(context).pop();
      CustomSnackbar.success(
        context,
        _isEdit
            ? 'Nomor meja sudah diperbarui.'
            : 'Meja baru ditambah. QR sudah siap di-generate.',
        title: _isEdit ? 'Meja Diperbarui' : 'Meja Ditambah',
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => isSubmitting = false);
      CustomSnackbar.error(
        context,
        error.toString().replaceFirst('Exception: ', ''),
        title: 'Gagal Menyimpan',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.neutral10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 18,
              children: [
                Text(
                  _isEdit ? 'Edit Meja' : 'Tambah Meja',
                  style: AppTypography.h8Bold.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                Text(
                  _isEdit
                      ? 'Ubah nomor meja. Token QR tidak berubah kecuali '
                            'kamu generate ulang.'
                      : 'Nomor meja dipakai di label QR yang di-scan customer.',
                  style: AppTypography.bodyRegularM.copyWith(
                    color: AppColors.neutral70,
                  ),
                ),
                CustomTextField(
                  name: 'table_number',
                  label: 'Nomor Meja',
                  hint: 'Contoh: 01 atau 12',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 3,
                  controller: numberController,
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
                        text: _isEdit ? 'Simpan' : 'Tambah',
                        height: 48,
                        enabled:
                            !isSubmitting &&
                            numberController.text.trim().isNotEmpty,
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
