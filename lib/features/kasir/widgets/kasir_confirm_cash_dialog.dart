import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/dialog_error_helper.dart';
import '../../../helper/format_currency_helper.dart';
import '../../../models/order_model.dart';
import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/primary_button.dart';
import '../providers/incoming_orders_provider.dart';
import 'kasir_cash_quick_amount_item.dart';
import 'kasir_order_summary_row.dart';

class KasirConfirmCashDialog extends ConsumerStatefulWidget {
  const KasirConfirmCashDialog({super.key, required this.order});

  final OrderModel order;

  static Future<void> show(BuildContext context, OrderModel order) {
    return showDialog<void>(
      context: context,
      builder: (_) => KasirConfirmCashDialog(order: order),
    );
  }

  @override
  ConsumerState<KasirConfirmCashDialog> createState() =>
      _KasirConfirmCashDialogState();
}

class _KasirConfirmCashDialogState
    extends ConsumerState<KasirConfirmCashDialog> {
  final receivedController = TextEditingController();
  bool isSubmitting = false;

  int get _total => widget.order.totalAmount ?? 0;

  int get _received =>
      int.tryParse(receivedController.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
      0;

  int get _change => _received - _total;

  /// Pilihan nominal cepat: uang pas lalu pembulatan ke atas per 50 ribu.
  List<int> get _quickAmounts => {
    _total,
    ((_total / 50000).ceil()) * 50000,
    ((_total / 50000).ceil() + 1) * 50000,
    ((_total / 100000).ceil() + 1) * 100000,
  }.toList();

  @override
  void dispose() {
    receivedController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => isSubmitting = true);
    try {
      await ref
          .read(incomingOrdersProvider.notifier)
          .confirmCashPayment(
            widget.order.id ?? 0,
            // Kosong = uang pas; backend menolak kalau kurang dari total.
            receivedAmount: _received > 0 ? _received : null,
          );
    } catch (error) {
      if (!mounted) return;
      setState(() => isSubmitting = false);
      final parsed = parseDialogError(error);
      CustomSnackbar.error(context, parsed.message, title: parsed.title);
      return;
    }

    if (!mounted) return;
    setState(() => isSubmitting = false);
    Navigator.of(context).pop();
    CustomSnackbar.success(
      context,
      'Pembayaran ${widget.order.code} sudah dikonfirmasi. '
      'Struk WhatsApp dikirim otomatis.',
      title: 'Pembayaran Lunas',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.neutral10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: FormBuilder(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 18,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.successSoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // TODO: ganti Material icon ini dengan asset ikon final.
                      child: const Icon(
                        Icons.payments_rounded,
                        color: AppColors.successMain,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Konfirmasi Pembayaran Tunai',
                            style: AppTypography.h8Bold.copyWith(
                              color: AppColors.neutral100,
                              height: 1.25,
                            ),
                          ),
                          Text(
                            '${widget.order.code} · ${widget.order.placeLabel}',
                            style: AppTypography.bodyRegularM.copyWith(
                              color: AppColors.neutral70,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Tagihan',
                        style: AppTypography.bodyRegularM.copyWith(
                          color: AppColors.primaryPressed,
                        ),
                      ),
                      Text(
                        formatRupiah(_total),
                        style: AppTypography.h6Bold.copyWith(
                          color: AppColors.primaryMain,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  name: 'received_amount',
                  label: 'Uang Diterima',
                  hint: 'Contoh: 100000',
                  keyboardType: TextInputType.number,
                  action: TextInputAction.done,
                  controller: receivedController,
                  isRequired: false,
                  onChanged: (_) => setState(() {}),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(_quickAmounts.length, (index) {
                    return KasirCashQuickAmountItem(
                      label: index == 0
                          ? 'Uang Pas'
                          : formatRupiah(_quickAmounts[index]),
                      onTap: () {
                        receivedController.text = '${_quickAmounts[index]}';
                        setState(() {});
                      },
                    );
                  }),
                ),
                Column(
                  spacing: 8,
                  children: [
                    KasirOrderSummaryRow(
                      label: 'Uang Diterima',
                      value: formatRupiah(_received),
                    ),
                    KasirOrderSummaryRow(
                      label: _change < 0 ? 'Kurang' : 'Kembalian',
                      value: formatRupiah(_change.abs()),
                      isTotal: true,
                    ),
                  ],
                ),
                if (_received > 0 && _change < 0)
                  Text(
                    'Nominal belum mencukupi total tagihan.',
                    style: AppTypography.bodyRegularS.copyWith(
                      color: AppColors.dangerMain,
                    ),
                  ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: 'Batal',
                        reverse: true,
                        borderColor: AppColors.neutral40,
                        textColor: AppColors.neutral80,
                        height: 48,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: PrimaryButton(
                        text: isSubmitting
                            ? 'Memproses...'
                            : 'Konfirmasi Pembayaran',
                        color: AppColors.successMain,
                        height: 48,
                        enabled: !isSubmitting && _received >= _total,
                        onPressed: _submit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
