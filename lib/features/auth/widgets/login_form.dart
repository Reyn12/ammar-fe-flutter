import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/validator.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../routes/app_paths.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/dialog_mixin.dart';
import '../../../widget/primary_button.dart';
import '../models/app_role.dart';
import '../models/login_result_model.dart';
import '../providers/auth_provider.dart';
import 'login_demo_hint.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> with DialogMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listenAction<LoginResultModel>(
      context: context,
      state: ref.watch(loginControllerProvider),
      onSuccess: () {
        if (!context.mounted) return;
        context.go(
          AppRole.fromValue(
                ref.read(loginControllerProvider).value?.user?.role,
              )?.homePath ??
              AppPaths.kasirDashboard,
        );
      },
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 32),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 6,
                  children: [
                    Text(
                      'Selamat Datang',
                      style: AppTypography.h6Bold.copyWith(
                        color: AppColors.neutral100,
                      ),
                    ),
                    Text(
                      'Masuk pakai akun kasir atau dapur yang sudah '
                      'didaftarkan pemilik.',
                      style: AppTypography.bodyRegularM.copyWith(
                        color: AppColors.neutral70,
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  name: 'username',
                  label: 'Username',
                  hint: 'Masukkan username',
                  controller: usernameController,
                  validators: [Validator.required()],
                  onChanged: (_) => setState(() {}),
                ),
                CustomTextField.password(
                  name: 'password',
                  label: 'Kata Sandi',
                  hint: 'Masukkan kata sandi',
                  action: TextInputAction.done,
                  controller: passwordController,
                  validators: [Validator.required()],
                  onChanged: (_) => setState(() {}),
                ),
                const LoginDemoHint(),
                PrimaryButton(
                  text: 'Masuk',
                  enabled:
                      !ref.watch(loginControllerProvider).isLoading &&
                      usernameController.text.trim().isNotEmpty &&
                      passwordController.text.isNotEmpty,
                  onPressed: () {
                    if (!(_formKey.currentState?.saveAndValidate() ?? false)) {
                      return;
                    }
                    ref
                        .read(loginControllerProvider.notifier)
                        .login(
                          username: usernameController.text.trim(),
                          password: passwordController.text,
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
