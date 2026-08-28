import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ammar_fe_flutter/features/auth/widgets/login_header.dart';
import 'package:ammar_fe_flutter/helper/validator.dart';
import 'package:ammar_fe_flutter/resources/app_typography.dart';
import 'package:ammar_fe_flutter/resources/resources.dart';
import 'package:ammar_fe_flutter/routes/app_paths.dart';

import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/dialog_mixin.dart';
import '../../../widget/primary_button.dart';
import '../models/login_result_model.dart';
import '../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> with DialogMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    identifierController.dispose();
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
        context.go(AppPaths.mainNavigation);
      },
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: FormBuilder(
              key: _formKey,
              child: Column(
                spacing: 24,
                children: [
                  const LoginHeader(
                    title: 'Selamat Datang Kembali',
                    description:
                        'login pakai NIM dan password SSO kampusmu buat pantau '
                        'jadwal dan urus akademik hari ini.',
                  ),
                  Column(
                    spacing: 16,
                    children: [
                      CustomTextField(
                        name: 'identifier',
                        label: 'Email/NIM',
                        hint: 'Masukkan Email atau NIM',
                        keyboardType: TextInputType.text,
                        controller: identifierController,
                        isRequired: true,
                        validators: [Validator.required()],
                        onChanged: (_) => setState(() {}),
                      ),
                      CustomTextField.password(
                        name: 'password',
                        label: 'Kata Sandi',
                        hint: 'Masukkan Kata Sandi',
                        controller: passwordController,
                        validators: [Validator.required()],
                        onChanged: (_) => setState(() {}),
                      ),
                      GestureDetector(
                        onTap: () {
                          CustomSnackbar.info(
                            context,
                            'Fitur lupa kata sandi masih dalam pengembangan.',
                            title: 'Coming Soon',
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Lupa Kata Sandi?',
                            textAlign: TextAlign.end,
                            style: AppTypography.bodyRegularM.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      PrimaryButton(
                        enabled:
                            !ref.watch(loginControllerProvider).isLoading &&
                            identifierController.text.trim().isNotEmpty &&
                            passwordController.text.isNotEmpty,
                        text: 'Masuk',
                        onPressed: () async {
                          if (!(_formKey.currentState?.saveAndValidate() ??
                              false)) {
                            return;
                          }
                          // await ref
                          //     .read(loginControllerProvider.notifier)
                          //     .login(
                          //       identifier: identifierController.text.trim(),
                          //       password: passwordController.text,
                          //     );
                        },
                      ),
                      Text(
                        'Atau',
                        textAlign: TextAlign.end,
                        style: AppTypography.bodyRegularM.copyWith(
                          color: AppColors.neutral100,
                        ),
                      ),
                      PrimaryButton.loginWithSSO(
                        onPressed: () {
                          // TODO: Implement SSO login
                          // ref.read(loginControllerProvider.notifier).loginWithSSO();
                          CustomSnackbar.info(
                            context,
                            'Fitur login SSO masih dalam pengembangan.',
                            title: 'Coming Soon',
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
