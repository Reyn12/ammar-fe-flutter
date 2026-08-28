import 'package:ammar_fe_flutter/routes/app_paths.dart';
import 'package:ammar_fe_flutter/routes/cupertino_page_helper.dart';
import 'package:ammar_fe_flutter/routes/root_navigator.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/screens/login_page.dart';
import '../features/kasir/pages/kasir_shell_page.dart';
import '../features/kitchen/pages/kitchen_board_page.dart';
import '../features/splash/pages/splash_page.dart';

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppPaths.splash,
  routes: [
    GoRoute(
      path: AppPaths.splash,
      pageBuilder: (context, state) =>
          buildCupertinoPage(key: state.pageKey, child: const SplashPage()),
    ),
    GoRoute(
      path: AppPaths.login,
      pageBuilder: (context, state) =>
          buildCupertinoPage(key: state.pageKey, child: const LoginPage()),
    ),
    GoRoute(
      path: AppPaths.kasirDashboard,
      pageBuilder: (context, state) =>
          buildCupertinoPage(key: state.pageKey, child: const KasirShellPage()),
    ),
    GoRoute(
      path: AppPaths.kitchenDashboard,
      pageBuilder: (context, state) => buildCupertinoPage(
        key: state.pageKey,
        child: const KitchenBoardPage(),
      ),
    ),
  ],
);
