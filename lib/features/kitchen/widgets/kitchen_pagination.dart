import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../providers/kitchen_board_provider.dart';

/// Paginasi kartu order (murni tampilan, tidak terkait algoritma batching).
class KitchenPagination extends ConsumerWidget {
  const KitchenPagination({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        IconButton(
          onPressed: ref.watch(kitchenPageIndexProvider) <= 0
              ? null
              : () => ref
                    .read(kitchenPageIndexProvider.notifier)
                    .select(ref.watch(kitchenPageIndexProvider) - 1),
          // TODO: ganti Material icon ini dengan asset ikon final.
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        Text(
          'Halaman ${ref.watch(kitchenPageIndexProvider) + 1} '
          'dari ${ref.watch(kitchenTotalPagesProvider).value ?? 1}',
          style: AppTypography.bodySemiboldM.copyWith(
            color: AppColors.neutral80,
          ),
        ),
        IconButton(
          onPressed:
              ref.watch(kitchenPageIndexProvider) >=
                  (ref.watch(kitchenTotalPagesProvider).value ?? 1) - 1
              ? null
              : () => ref
                    .read(kitchenPageIndexProvider.notifier)
                    .select(ref.watch(kitchenPageIndexProvider) + 1),
          // TODO: ganti Material icon ini dengan asset ikon final.
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}
