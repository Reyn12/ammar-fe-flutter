import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widget/connection_indicator.dart';
import '../providers/incoming_orders_provider.dart';
import '../widgets/kasir_incoming_toast.dart';
import '../widgets/kasir_order_detail_panel.dart';
import '../widgets/kasir_order_filter_tabs.dart';
import '../widgets/kasir_order_list_builder.dart';
import '../widgets/kasir_order_list_error.dart';
import '../widgets/kasir_order_list_shimmer.dart';
import '../widgets/kasir_page_header.dart';

class KasirIncomingOrdersPage extends ConsumerWidget {
  const KasirIncomingOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(incomingOrdersProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 18,
            children: [
              const KasirPageHeader(
                title: 'Pesanan Masuk',
                subtitle:
                    'Pesanan pelanggan yang sudah dibayar masuk otomatis ke sini.',
                trailing: ConnectionIndicator(label: 'Sinkron Realtime'),
              ),
              const KasirOrderFilterTabs(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 18,
                  children: [
                    Expanded(
                      flex: 5,
                      child: ordersAsync.when(
                        loading: () => const KasirOrderListShimmer(),
                        error: (_, _) => KasirOrderListError(
                          onRetry: () =>
                              ref.invalidate(incomingOrdersProvider),
                        ),
                        data: (_) => KasirOrderListBuilder(
                          orders: ref.watch(filteredIncomingOrdersProvider),
                        ),
                      ),
                    ),
                    const Expanded(flex: 4, child: KasirOrderDetailPanel()),
                  ],
                ),
              ),
            ],
          ),
          // Toast nimpa di bawah header — nggak geser filter/list.
          const Positioned(
            top: 72,
            left: 0,
            right: 0,
            child: KasirIncomingToast(),
          ),
        ],
      ),
    );
  }
}
