import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/resources.dart';
import '../widgets/login_brand_panel.dart';
import '../widgets/login_form.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: const Scaffold(
        backgroundColor: AppColors.neutral10,
        body: SafeArea(
          child: Row(
            children: [
              Expanded(flex: 5, child: LoginBrandPanel()),
              Expanded(flex: 4, child: LoginForm()),
            ],
          ),
        ),
      ),
    );
  }
}
