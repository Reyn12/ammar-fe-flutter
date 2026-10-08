import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../providers/incoming_orders_provider.dart';

/// Paginasi list Pesanan Masuk (mirip kitchen board).
class KasirOrderPagination extends ConsumerWidget {
  const KasirOrderPagination({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(kasirOrderPageIndexProvider);
    final totalPages = ref.watch(kasirOrderTotalPagesProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        IconButton(
          onPressed: pageIndex <= 0
              ? null
              : () => ref
                    .read(kasirOrderPageIndexProvider.notifier)
                    .select(pageIndex - 1),
          // TODO: ganti Material icon ini dengan asset ikon final.
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        Text(
          'Halaman ${pageIndex + 1} dari $totalPages',
          style: AppTypography.bodySemiboldM.copyWith(
            color: AppColors.neutral80,
          ),
        ),
        IconButton(
          onPressed: pageIndex >= totalPages - 1
              ? null
              : () => ref
                    .read(kasirOrderPageIndexProvider.notifier)
                    .select(pageIndex + 1),
          // TODO: ganti Material icon ini dengan asset ikon final.
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}
