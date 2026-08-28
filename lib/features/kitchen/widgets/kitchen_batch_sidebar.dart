import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/empty_state.dart';
import '../models/kitchen_batch_model.dart';
import '../providers/kitchen_batch_provider.dart';
import 'kitchen_batch_group_builder.dart';
import 'kitchen_batch_sidebar_shimmer.dart';

class KitchenBatchSidebar extends ConsumerWidget {
  const KitchenBatchSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.neutral20,
        border: Border(right: BorderSide(color: AppColors.neutral30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Batch Preparation',
                style: AppTypography.h8Bold.copyWith(
                  color: AppColors.neutral100,
                  height: 1.2,
                ),
              ),
              Text(
                'Menu yang sama digabung, maks '
                '${KitchenBatchModel.maxNotaPerBatch} nota per batch.',
                style: AppTypography.bodyRegularS.copyWith(
                  color: AppColors.neutral70,
                  height: 1.35,
                ),
              ),
            ],
          ),
          Expanded(
            child: ref
                .watch(groupedKitchenBatchesProvider)
                .when(
                  loading: () => const KitchenBatchSidebarShimmer(),
                  error: (_, _) => const Center(
                    child: EmptyState(
                      title: 'Gagal memuat batch',
                      subtitle: 'Cek koneksi ke server lalu muat ulang.',
                    ),
                  ),
                  data: (groupedBatches) => groupedBatches.isEmpty
                      ? const Center(
                          child: EmptyState(
                            title: 'Antrean kosong',
                            subtitle: 'Belum ada menu yang perlu dimasak.',
                          ),
                        )
                      : SingleChildScrollView(
                          child: KitchenBatchGroupBuilder(
                            groupedBatches: groupedBatches,
                          ),
                        ),
                ),
          ),
        ],
      ),
    );
  }
}
