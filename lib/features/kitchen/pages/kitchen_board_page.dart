import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/resources.dart';
import '../../../widget/dialog_mixin.dart';
import '../../../widget/empty_state.dart';
import '../providers/kitchen_action_provider.dart';
import '../providers/kitchen_board_provider.dart';
import '../widgets/kitchen_batch_sidebar.dart';
import '../widgets/kitchen_footer.dart';
import '../widgets/kitchen_header.dart';
import '../widgets/kitchen_order_grid_builder.dart';
import '../widgets/kitchen_order_grid_shimmer.dart';
import '../widgets/kitchen_pagination.dart';

class KitchenBoardPage extends ConsumerStatefulWidget {
  const KitchenBoardPage({super.key});

  @override
  ConsumerState<KitchenBoardPage> createState() => _KitchenBoardPageState();
}

class _KitchenBoardPageState extends ConsumerState<KitchenBoardPage>
    with DialogMixin {
  @override
  Widget build(BuildContext context) {
    listenAction<bool>(
      context: context,
      state: ref.watch(kitchenActionControllerProvider),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          children: [
            const KitchenBatchSidebar(),
            Expanded(
              child: Column(
                children: [
                  const KitchenHeader(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ref
                          .watch(pagedKitchenOrdersProvider)
                          .when(
                            skipLoadingOnReload: true,
                            skipLoadingOnRefresh: true,
                            loading: () => const KitchenOrderGridShimmer(),
                            error: (_, _) => const Center(
                              child: EmptyState(
                                title: 'Gagal memuat pesanan',
                                subtitle:
                                    'Cek koneksi ke server lalu muat ulang.',
                              ),
                            ),
                            data: (orders) =>
                                KitchenOrderGridBuilder(orders: orders),
                          ),
                    ),
                  ),
                  const KitchenPagination(),
                  const SizedBox(height: 8),
                  const KitchenFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
