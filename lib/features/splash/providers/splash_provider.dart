import 'dart:async';

import 'package:ammar_fe_flutter/features/auth/models/auth_type.dart';
import 'package:ammar_fe_flutter/features/auth/providers/auth_provider.dart';
import 'package:ammar_fe_flutter/routes/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/push_notification_service.dart';
import '../../../routes/app_paths.dart';
import '../../auth/models/app_role.dart';
import '../../auth/storage/auth_storage.dart';

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

      if (await ref.read(authProvider.notifier).checkToken() !=
          AuthType.AUTHENTICATED) {
        appRouter.go(AppPaths.login);
        return;
      }

      final user = await AuthStorage().getUser();
      if (!ref.mounted) return;

      ref.read(sessionProvider.notifier).setUser(user);
      unawaited(ref.read(pushNotificationServiceProvider).register());
      appRouter.go(AppRole.fromValue(user?.role)?.homePath ?? AppPaths.login);
    } finally {
      keepAliveLink.close();
    }
  }

  Future<void> checkVersion() async {
    // TODO: implement check app version / force update
    // bypass sementara
  }
}
