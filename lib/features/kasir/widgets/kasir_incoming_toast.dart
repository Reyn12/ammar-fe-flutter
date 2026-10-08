import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../models/kasir_incoming_toast_model.dart';
import '../providers/kasir_incoming_alert_provider.dart';

class KasirIncomingToast extends ConsumerWidget {
  const KasirIncomingToast({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toast = ref.watch(
      kasirIncomingAlertProvider.select((state) => state.toast),
    );

    return IgnorePointer(
      ignoring: toast == null,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.15),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: toast == null
            ? const SizedBox.shrink(key: ValueKey('kasir-toast-empty'))
            : KasirIncomingToastCard(
                key: ValueKey('kasir-toast-${toast.orderId}'),
                toast: toast,
                onClose: () => ref
                    .read(kasirIncomingAlertProvider.notifier)
                    .dismissToast(),
              ),
      ),
    );
  }
}

class KasirIncomingToastCard extends StatelessWidget {
  const KasirIncomingToastCard({
    super.key,
    required this.toast,
    required this.onClose,
  });

  final KasirIncomingToastModel toast;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.neutral10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.orangeMain, width: 1.4),
          boxShadow: AppShadows.soft,
        ),
        child: Row(
          spacing: 10,
          children: [
            const Icon(
              Icons.notifications_active_rounded,
              size: 20,
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
                    style: AppTypography.bodySemiboldM.copyWith(
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
                  size: 18,
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
