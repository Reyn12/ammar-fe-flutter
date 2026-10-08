import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/validator.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/primary_button.dart';
import '../providers/owner_auth_provider.dart';

class KasirChangePasswordDialog extends ConsumerStatefulWidget {
  const KasirChangePasswordDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const KasirChangePasswordDialog(),
    );
  }

  @override
  ConsumerState<KasirChangePasswordDialog> createState() =>
      _KasirChangePasswordDialogState();
}

class _KasirChangePasswordDialogState
    extends ConsumerState<KasirChangePasswordDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isSubmitting = false;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;

    setState(() => isSubmitting = true);
    try {
      await ref
          .read(ownerAuthProvider.notifier)
          .changePassword(
            currentPassword: currentPasswordController.text,
            newPassword: newPasswordController.text,
          );
      if (!mounted) return;
      Navigator.of(context).pop();
      CustomSnackbar.success(
        context,
        'Password owner berhasil diganti. Pakai password baru saat login berikutnya.',
        title: 'Password Diganti',
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => isSubmitting = false);
      CustomSnackbar.error(
        context,
        error.toString().replaceFirst('Exception: ', ''),
        title: 'Gagal Mengganti',
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
                  'Ganti Password Owner',
                  style: AppTypography.h8Bold.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                Text(
                  'Password lama wajib diisi. Password baru minimal 8 karakter '
                  'dengan huruf besar, kecil, dan angka.',
                  style: AppTypography.bodyRegularM.copyWith(
                    color: AppColors.neutral70,
                  ),
                ),
                CustomTextField.password(
                  name: 'current_password',
                  label: 'Password Lama',
                  hint: 'Masukkan password saat ini',
                  controller: currentPasswordController,
                  validators: [Validator.required()],
                  onChanged: (_) => setState(() {}),
                ),
                CustomTextField.password(
                  name: 'new_password',
                  label: 'Password Baru',
                  hint: 'Minimal 8 karakter',
                  controller: newPasswordController,
                  validators: [Validator.newPassword()],
                  onChanged: (_) => setState(() {}),
                ),
                CustomTextField.password(
                  name: 'confirm_password',
                  label: 'Konfirmasi Password Baru',
                  hint: 'Ulangi password baru',
                  controller: confirmPasswordController,
                  validators: [
                    Validator.confirmPassword(
                      () => newPasswordController.text,
                    ),
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
                        text: 'Simpan',
                        height: 48,
                        enabled: !isSubmitting,
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
