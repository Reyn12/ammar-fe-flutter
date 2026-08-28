import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ammar_fe_flutter/features/home/pages/home_page.dart';
import 'package:ammar_fe_flutter/features/main_navigation/providers/main_navigation_provider.dart';
import 'package:ammar_fe_flutter/features/main_navigation/widgets/custom_bottom_nav.dart';
import 'package:ammar_fe_flutter/gen/assets.gen.dart';
import 'package:ammar_fe_flutter/widget/custom_snackbar.dart';

class MainNavigationPage extends HookConsumerWidget {
  const MainNavigationPage({super.key});

  static List<NavItem> navItems = [
    NavItem(
      label: 'Beranda',
      iconPath: Assets.icons.icHome.path,
      activeIconPath: Assets.icons.icHomeActive.path,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitedLazyTabs = useState<Set<int>>({});

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await CustomSnackbar.doubleBackToExit(context);
        if (shouldExit) {
          SystemNavigator.pop();
        }
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          body: IndexedStack(
            index: ref.watch(mainNavigationProvider),
            children: [const HomePage(key: ValueKey('home'))],
          ),
          bottomNavigationBar: CustomBottomNav(
            currentIndex: ref.watch(mainNavigationProvider),
            navItems: navItems,
            onNavItemSelected: (index) {
              if (index == 1 || index == 2) {
                visitedLazyTabs.value = {...visitedLazyTabs.value, index};
              }
              ref.read(mainNavigationProvider.notifier).changePage(index);
            },
          ),
        ),
      ),
    );
  }
}
