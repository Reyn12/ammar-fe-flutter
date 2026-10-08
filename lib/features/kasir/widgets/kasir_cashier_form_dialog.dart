import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/validator.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/primary_button.dart';
import '../models/cashier_account_model.dart';
import '../providers/cashier_accounts_provider.dart';

class KasirCashierFormDialog extends ConsumerStatefulWidget {
  const KasirCashierFormDialog({super.key, this.account});

  final CashierAccountModel? account;

  static Future<void> show(
    BuildContext context, [
    CashierAccountModel? account,
  ]) {
    return showDialog<void>(
      context: context,
      builder: (_) => KasirCashierFormDialog(account: account),
    );
  }

  @override
  ConsumerState<KasirCashierFormDialog> createState() =>
      _KasirCashierFormDialogState();
}

class _KasirCashierFormDialogState
    extends ConsumerState<KasirCashierFormDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final TextEditingController nameController;
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  bool isSubmitting = false;

  bool get _isEdit => widget.account != null;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.account?.name ?? '');
    usernameController = TextEditingController(
      text: widget.account?.username ?? '',
    );
    passwordController = TextEditingController(
      text: widget.account?.password ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;

    setState(() => isSubmitting = true);
    try {
      await ref
          .read(cashierAccountsProvider.notifier)
          .save(
            CashierAccountModel(
              id: widget.account?.id ?? 0,
              name: nameController.text.trim(),
              username: usernameController.text.trim().toLowerCase(),
              password: passwordController.text,
              isActive: widget.account?.isActive ?? true,
            ),
          );
      if (!mounted) return;
      Navigator.of(context).pop();
      CustomSnackbar.success(
        context,
        _isEdit
            ? 'Data kasir sudah diperbarui.'
            : 'Akun kasir baru sudah ditambahkan.',
        title: _isEdit ? 'Kasir Diperbarui' : 'Kasir Ditambah',
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
        constraints: const BoxConstraints(maxWidth: 460),
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
                  _isEdit ? 'Edit Kasir' : 'Tambah Kasir',
                  style: AppTypography.h8Bold.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                Text(
                  _isEdit
                      ? 'Perbarui nama, username, atau password akun kasir.'
                      : 'Buat akun kasir baru untuk cabang ini.',
                  style: AppTypography.bodyRegularM.copyWith(
                    color: AppColors.neutral70,
                  ),
                ),
                CustomTextField(
                  name: 'name',
                  label: 'Nama',
                  hint: 'Contoh: Rani Kasir',
                  controller: nameController,
                  validators: [Validator.required()],
                  onChanged: (_) => setState(() {}),
                ),
                CustomTextField(
                  name: 'username',
                  label: 'Username',
                  hint: 'Contoh: kasir3',
                  controller: usernameController,
                  validators: [Validator.required()],
                  onChanged: (_) => setState(() {}),
                ),
                CustomTextField.password(
                  name: 'password',
                  label: 'Password',
                  hint: 'Minimal 6 karakter',
                  controller: passwordController,
                  validators: [
                    Validator.required(),
                    Validator.list([
                      (value) {
                        if ((value ?? '').length < 6) {
                          return 'Password minimal 6 karakter.';
                        }
                        return null;
                      },
                    ]),
                  ],
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
                            nameController.text.trim().isNotEmpty &&
                            usernameController.text.trim().isNotEmpty &&
                            passwordController.text.length >= 6,
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
