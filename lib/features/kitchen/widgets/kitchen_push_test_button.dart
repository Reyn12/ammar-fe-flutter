import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/dialog_error_helper.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../providers/kitchen_push_test_provider.dart';

/// Ikon bel di header dapur untuk mengirim notifikasi tes dan memastikan push + bunyi berfungsi.
class KitchenPushTestButton extends ConsumerWidget {
  const KitchenPushTestButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<String?>>(kitchenPushTestProvider, (_, next) {
      next.whenOrNull(
        data: (message) {
          if (message != null) CustomSnackbar.success(context, message);
        },
        error: (error, _) {
          final parsed = parseDialogError(error);
          CustomSnackbar.error(context, parsed.message, title: parsed.title);
        },
      );
    });

    return IconButton(
      tooltip: 'Kirim notifikasi tes',
      onPressed: ref.watch(kitchenPushTestProvider).isLoading
          ? null
          : () => ref.read(kitchenPushTestProvider.notifier).send(),
      // TODO: ganti Material icon ini dengan asset ikon final.
      icon: const Icon(
        Icons.notifications_active_rounded,
        color: AppColors.neutral80,
      ),
    );
  }
}
