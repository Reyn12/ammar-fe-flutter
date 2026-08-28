import 'package:flutter/material.dart';
import 'package:ammar_fe_flutter/resources/resources.dart';
import 'package:ammar_fe_flutter/features/main_navigation/widgets/custom_bottom_nav_bar_item.dart';

class NavItem {
  final String label;
  final String iconPath;
  final String? activeIconPath;

  const NavItem({
    required this.label,
    required this.iconPath,
    this.activeIconPath,
  });
}

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<NavItem> navItems;
  final Function(int) onNavItemSelected;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.navItems,
    required this.onNavItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.shadowColor.withValues(alpha: 0.1),
        //     spreadRadius: 0,
        //     blurRadius: 7,
        //     offset: const Offset(0, -2),
        //   ),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: navItems
                    .asMap()
                    .entries
                    .map(
                      (entry) => Expanded(
                        child: CustomBottomNavBarItem(
                          isActive: entry.key == currentIndex,
                          index: entry.key,
                          label: entry.value.label,
                          iconPath: entry.value.iconPath,
                          activeIconPath: entry.value.activeIconPath,
                          onTap: () => onNavItemSelected(entry.key),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 3,
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: Alignment(
                    navItems.length <= 1
                        ? 0
                        : -1 + (2 * currentIndex / (navItems.length - 1)),
                    0,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 1 / navItems.length,
                    child: Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Container(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
