import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'network/push_notification_service.dart';
import 'resources/app_theme.dart';
import 'routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Aplikasi tablet kasir & dapur: hanya boleh landscape.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await PushNotificationService.initialize();

  runApp(
    ProviderScope(
      retry: (retryCount, error) {
        if (retryCount >= 1) return null;
        return const Duration(milliseconds: 300);
      },
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
