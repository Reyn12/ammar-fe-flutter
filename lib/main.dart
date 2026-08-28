import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'routes/app_router.dart';

void main() {
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
      routerConfig: appRouter,
    );
  }
}
