import 'package:go_router/go_router.dart';
import 'package:ammar_fe_flutter/routes/root_navigator.dart';
import 'package:ammar_fe_flutter/routes/app_paths.dart';
import 'package:ammar_fe_flutter/routes/cupertino_page_helper.dart';

import '../features/auth/screens/login_page.dart';

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppPaths.splash,
  routes: [
    GoRoute(
      path: AppPaths.splash,
      pageBuilder: (context, state) =>
          buildCupertinoPage(key: state.pageKey, child: const SplashPage()),
    ),
  ],
);
