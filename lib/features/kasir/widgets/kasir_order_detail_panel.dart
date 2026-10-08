import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/format_currency_helper.dart';
import '../../../helper/format_time_helper.dart';
import '../../../helper/status_color_helper.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/status_pill.dart';
import '../../../widget/surface_card.dart';
import '../providers/incoming_orders_provider.dart';
import '../providers/kasir_shift_provider.dart';
import 'kasir_confirm_cash_dialog.dart';
import 'kasir_order_detail_empty.dart';
import 'kasir_order_detail_item_builder.dart';
import 'kasir_order_summary_row.dart';

class KasirOrderDetailPanel extends ConsumerWidget {
  const KasirOrderDetailPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(selectedIncomingOrderProvider);

    return SurfaceCard(
      padding: const EdgeInsets.all(20),
      child: order == null
          ? const KasirOrderDetailEmpty()
          : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 16,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.code ?? '-',
                                  style: AppTypography.h7Bold.copyWith(
                                    color: AppColors.neutral100,
                                    height: 1.2,
                                  ),
                                ),
                                Text(
                                  '${order.placeLabel} · ${order.orderType?.label ?? '-'}'
                                  '${order.createdAt == null ? '' : ' · ${formatClock(order.createdAt!)}'}',
                                  style: AppTypography.bodyRegularM.copyWith(
                                    color: AppColors.neutral70,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          StatusPill(
                            label: order.status?.label ?? '-',
                            foregroundColor: orderStatusColor(
                              order.status,
                            ).foreground,
                            backgroundColor: orderStatusColor(
                              order.status,
                            ).background,
                          ),
                        ],
                      ),
                      Row(
                        spacing: 8,
                        children: [
                          StatusPill(
                            label:
                                'Pembayaran ${order.paymentMethod?.label ?? '-'}',
                            // TODO: ganti Material icon ini dengan asset ikon final.
                            icon: Icons.account_balance_wallet_rounded,
                            foregroundColor: AppColors.neutral80,
                            backgroundColor: AppColors.neutral20,
                          ),
                          StatusPill(
                            label: order.needCashConfirmation
                                ? 'Menunggu Konfirmasi'
                                : 'Lunas',
                            foregroundColor: paymentStatusColor(
                              order.paymentStatus,
                            ).foreground,
                            backgroundColor: paymentStatusColor(
                              order.paymentStatus,
                            ).background,
                          ),
                          if ((order.customerName ?? '').isNotEmpty)
                            StatusPill(
                              label: order.customerName ?? '',
                              // TODO: ganti Material icon ini dengan asset ikon final.
                              icon: Icons.person_rounded,
                              foregroundColor: AppColors.neutral80,
                              backgroundColor: AppColors.neutral20,
                            ),
                        ],
                      ),
                      const Divider(height: 1, color: AppColors.neutral30),
                      Expanded(
                        child: KasirOrderDetailItemBuilder(
                          items: order.items ?? [],
                        ),
                      ),
                      const Divider(height: 1, color: AppColors.neutral30),
                      Column(
                        spacing: 8,
                        children: [
                          KasirOrderSummaryRow(
                            label: 'Subtotal',
                            value: formatRupiah(order.subtotal),
                          ),
                          KasirOrderSummaryRow(
                            label: 'Pajak',
                            value: formatRupiah(order.taxAmount ?? 0),
                          ),
                          KasirOrderSummaryRow(
                            label: 'Total',
                            value: formatRupiah(order.totalAmount ?? 0),
                            isTotal: true,
                          ),
                        ],
                      ),
                      if (order.needCashConfirmation)
                        PrimaryButton(
                          text: 'Konfirmasi Pembayaran Tunai',
                          color: AppColors.successMain,
                          height: 52,
                          leading: const Icon(
                            // TODO: ganti Material icon ini dengan asset ikon final.
                            Icons.check_circle_rounded,
                            color: AppColors.neutral10,
                          ),
                          onPressed: () {
                            if (!(ref
                                    .read(kasirShiftProvider)
                                    .value
                                    ?.isActive ??
                                false)) {
                              CustomSnackbar.warning(
                                context,
                                'Buka shift dulu sebelum menerima pembayaran '
                                'tunai.',
                                title: 'Shift Belum Dibuka',
                              );
                              return;
                            }
                            KasirConfirmCashDialog.show(context, order);
                          },
                        )
                      else
                        PrimaryButton(
                          text: 'Cetak Ulang Struk',
                          reverse: true,
                          borderColor: AppColors.primaryMain,
                          textColor: AppColors.primaryMain,
                          height: 52,
                          leading: const Icon(
                            // TODO: ganti Material icon ini dengan asset ikon final.
                            Icons.print_rounded,
                            color: AppColors.primaryMain,
                          ),
                          onPressed: () => CustomSnackbar.info(
                            context,
                            'Cetak struk masih dalam pengembangan.',
                            title: 'Coming Soon',
                          ),
                        ),
                    ],
                  ),
    );
  }
}
