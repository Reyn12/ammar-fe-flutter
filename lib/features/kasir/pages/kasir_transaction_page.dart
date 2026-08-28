import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/kasir_transaction_provider.dart';
import '../widgets/kasir_order_list_error.dart';
import '../widgets/kasir_order_list_shimmer.dart';
import '../widgets/kasir_page_header.dart';
import '../widgets/kasir_transaction_builder.dart';
import '../widgets/kasir_transaction_summary_bar.dart';

class KasirTransactionPage extends ConsumerWidget {
  const KasirTransactionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 18,
        children: [
          const KasirPageHeader(
            title: 'Riwayat Transaksi',
            subtitle: 'Rekap pesanan yang sudah selesai pada shift berjalan.',
          ),
          Expanded(
            child: ref
                .watch(kasirTransactionsProvider)
                .when(
                  loading: () => const KasirOrderListShimmer(itemCount: 3),
                  error: (_, _) => KasirOrderListError(
                    onRetry: () => ref.invalidate(kasirTransactionsProvider),
                  ),
                  data: (orders) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 18,
                    children: [
                      KasirTransactionSummaryBar(orders: orders),
                      Expanded(child: KasirTransactionBuilder(orders: orders)),
                    ],
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
