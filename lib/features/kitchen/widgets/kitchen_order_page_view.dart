import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widget/empty_state.dart';
import '../providers/kitchen_board_provider.dart';
import 'kitchen_order_grid_builder.dart';
import 'kitchen_order_grid_shimmer.dart';

/// Area kanan board: PageView biar bisa swipe kiri/kanan antar halaman.
/// Pagination bawah tetap sync lewat [kitchenPageIndexProvider].
class KitchenOrderPageView extends ConsumerStatefulWidget {
  const KitchenOrderPageView({super.key});

  @override
  ConsumerState<KitchenOrderPageView> createState() =>
      _KitchenOrderPageViewState();
}

class _KitchenOrderPageViewState extends ConsumerState<KitchenOrderPageView> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: ref.read(kitchenPageIndexProvider),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void syncToPage(int page) {
    if (!pageController.hasClients) return;
    if (pageController.page?.round() == page) return;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(kitchenPageIndexProvider, (_, next) => syncToPage(next));

    return ref
        .watch(kitchenOrdersProvider)
        .when(
          skipLoadingOnReload: true,
          skipLoadingOnRefresh: true,
          loading: () => const KitchenOrderGridShimmer(),
          error: (_, _) => const Center(
            child: EmptyState(
              title: 'Gagal memuat pesanan',
              subtitle: 'Cek koneksi ke server lalu muat ulang.',
            ),
          ),
          data: (orders) {
            final active = activeKitchenOrders(orders);
            final totalPages = (active.length / kitchenOrdersPerPage)
                .ceil()
                .clamp(1, 999);

            if (active.isEmpty) {
              return const KitchenOrderGridBuilder(orders: []);
            }

            return PageView.builder(
              controller: pageController,
              itemCount: totalPages,
              onPageChanged: (index) {
                ref.read(kitchenPageIndexProvider.notifier).select(index);
              },
              itemBuilder: (context, index) {
                final pageOrders = active
                    .skip(index * kitchenOrdersPerPage)
                    .take(kitchenOrdersPerPage)
                    .toList();
                return KitchenOrderGridBuilder(orders: pageOrders);
              },
            );
          },
        );
  }
}
