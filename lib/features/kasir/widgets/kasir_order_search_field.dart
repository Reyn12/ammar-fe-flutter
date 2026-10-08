import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../providers/incoming_orders_provider.dart';

class KasirOrderSearchField extends ConsumerStatefulWidget {
  const KasirOrderSearchField({super.key});

  @override
  ConsumerState<KasirOrderSearchField> createState() =>
      _KasirOrderSearchFieldState();
}

class _KasirOrderSearchFieldState extends ConsumerState<KasirOrderSearchField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: ref.read(incomingOrderSearchQueryProvider),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(incomingOrderSearchQueryProvider);

    return TextField(
      controller: controller,
      onChanged: (value) =>
          ref.read(incomingOrderSearchQueryProvider.notifier).setQuery(value),
      style: AppTypography.bodyRegularM.copyWith(color: AppColors.neutral100),
      decoration: InputDecoration(
        hintText: 'Cari kode, meja, pelanggan, atau menu…',
        hintStyle: AppTypography.bodyRegularM.copyWith(
          color: AppColors.neutral60,
        ),
        filled: true,
        fillColor: AppColors.neutral10,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        prefixIcon: const Icon(
          // TODO: ganti Material icon ini dengan asset ikon final.
          Icons.search_rounded,
          size: 20,
          color: AppColors.neutral60,
        ),
        suffixIcon: query.isEmpty
            ? null
            : IconButton(
                tooltip: 'Hapus pencarian',
                onPressed: () {
                  controller.clear();
                  ref.read(incomingOrderSearchQueryProvider.notifier).clear();
                },
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: const Icon(Icons.close_rounded, size: 18),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.neutral40),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.neutral40),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryMain, width: 1.4),
        ),
      ),
    );
  }
}
