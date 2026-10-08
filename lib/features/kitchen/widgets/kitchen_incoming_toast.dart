import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../models/kitchen_incoming_toast_model.dart';
import '../providers/kitchen_incoming_provider.dart';

class KitchenIncomingToast extends ConsumerWidget {
  const KitchenIncomingToast({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toast = ref.watch(
      kitchenIncomingAlertProvider.select((state) => state.toast),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: toast == null
          ? const SizedBox.shrink(key: ValueKey('toast-empty'))
          : KitchenIncomingToastCard(
              key: ValueKey('toast-${toast.orderId}'),
              toast: toast,
              onClose: () =>
                  ref.read(kitchenIncomingAlertProvider.notifier).dismissToast(),
            ),
    );
  }
}

class KitchenIncomingToastCard extends StatelessWidget {
  const KitchenIncomingToastCard({
    super.key,
    required this.toast,
    required this.onClose,
  });

  final KitchenIncomingToastModel toast;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.neutral10,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.orangeMain, width: 1.4),
          boxShadow: AppShadows.soft,
        ),
        child: Row(
          spacing: 8,
          children: [
            const Icon(
              Icons.notifications_active_rounded,
              size: 18,
              color: AppColors.orangeMain,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pesanan baru · ${toast.orderCode}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySemiboldS.copyWith(
                      color: AppColors.orangeMain,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    '${toast.placeLabel} · ${toast.customerName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodyRegularS.copyWith(
                      color: AppColors.neutral70,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onClose,
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.all(2),
                child: Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: AppColors.neutral60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
