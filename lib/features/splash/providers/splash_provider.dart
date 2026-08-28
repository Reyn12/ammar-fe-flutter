import 'dart:async';

import 'package:ammar_fe_flutter/features/auth/models/auth_type.dart';
import 'package:ammar_fe_flutter/features/auth/providers/auth_provider.dart';
import 'package:ammar_fe_flutter/routes/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../routes/app_paths.dart';

part 'splash_provider.g.dart';

@riverpod
class Splash extends _$Splash {
  @override
  Future<void> build() async {
    final keepAliveLink = ref.keepAlive();
    try {
      await checkVersion();
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!ref.mounted) return;

      if (!await checkBoarding()) {
        if (!ref.mounted) return;
        ref.read(authProvider.notifier).setAuthType(AuthType.BOARDING);
        appRouter.go(AppPaths.onboarding);
        return;
      }

      if (!ref.mounted) return;

      if (await ref.read(authProvider.notifier).checkToken() ==
          AuthType.AUTHENTICATED) {
        appRouter.go(AppPaths.mainNavigation);
      } else {
        appRouter.go(AppPaths.login);
      }
    } finally {
      keepAliveLink.close();
    }
  }

  Future<void> checkVersion() async {
    // TODO: implement check app version / force update
    // bypass sementara
  }

  Future<bool> checkBoarding() async {
    return true;
  }
}
