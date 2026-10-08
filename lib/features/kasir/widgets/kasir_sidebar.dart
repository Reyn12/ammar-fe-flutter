import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../auth/helpers/auth_permission.dart';
import '../../auth/providers/auth_provider.dart';
import 'kasir_sidebar_footer.dart';
import 'kasir_sidebar_menu_builder.dart';

class KasirSidebar extends ConsumerWidget {
  const KasirSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final owner = isOwner(ref.watch(sessionProvider));

    return Container(
      width: 248,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.neutral10,
        border: Border(right: BorderSide(color: AppColors.neutral30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          Row(
            spacing: 12,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primaryMain,
                  borderRadius: BorderRadius.circular(12),
                ),
                // TODO: ganti Material icon ini dengan logo RM Ayam Bakar Ammar.
                child: const Icon(
                  Icons.local_fire_department_rounded,
                  size: 24,
                  color: AppColors.neutral10,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ammar POS',
                      style: AppTypography.h9Bold.copyWith(
                        color: AppColors.neutral100,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      owner ? 'Mode Owner' : 'Mode Kasir',
                      style: AppTypography.bodyRegularS.copyWith(
                        color: AppColors.neutral70,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Expanded(
            child: SingleChildScrollView(child: KasirSidebarMenuBuilder()),
          ),
          const KasirSidebarFooter(),
        ],
      ),
    );
  }
}
