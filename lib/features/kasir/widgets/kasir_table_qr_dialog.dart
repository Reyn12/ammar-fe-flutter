import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/primary_button.dart';
import '../helpers/table_qr_download_helper.dart';
import '../models/table_account_model.dart';
import '../providers/table_accounts_provider.dart';

class KasirTableQrDialog extends ConsumerStatefulWidget {
  const KasirTableQrDialog({super.key, required this.tableId});

  final int tableId;

  static Future<void> show(BuildContext context, TableAccountModel table) {
    return showDialog<void>(
      context: context,
      builder: (_) => KasirTableQrDialog(tableId: table.id),
    );
  }

  @override
  ConsumerState<KasirTableQrDialog> createState() => _KasirTableQrDialogState();
}

class _KasirTableQrDialogState extends ConsumerState<KasirTableQrDialog> {
  bool isBusy = false;

  TableAccountModel? get _table {
    for (final item in ref.watch(tableAccountsProvider)) {
      if (item.id == widget.tableId) return item;
    }
    return null;
  }

  Future<void> _download(TableAccountModel table) async {
    setState(() => isBusy = true);
    try {
      await TableQrDownloadHelper.download(table);
      if (!mounted) return;
      CustomSnackbar.success(
        context,
        'QR ${table.label} sudah disimpan dan dibuka.',
        title: 'QR Terunduh',
      );
    } catch (error) {
      if (!mounted) return;
      CustomSnackbar.error(
        context,
        error.toString().replaceFirst('Exception: ', ''),
        title: 'Gagal Unduh',
      );
    } finally {
      if (mounted) setState(() => isBusy = false);
    }
  }

  Future<void> _regenerate() async {
    setState(() => isBusy = true);
    try {
      await ref
          .read(tableAccountsProvider.notifier)
          .regenerateQr(widget.tableId);
      if (!mounted) return;
      CustomSnackbar.success(
        context,
        'QR lama sudah diganti. Print ulang sticker meja ini.',
        title: 'QR Digenerate Ulang',
      );
    } catch (error) {
      if (!mounted) return;
      CustomSnackbar.error(
        context,
        error.toString().replaceFirst('Exception: ', ''),
        title: 'Gagal Generate',
      );
    } finally {
      if (mounted) setState(() => isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final table = _table;
    if (table == null) {
      return const SizedBox.shrink();
    }

    return Dialog(
      backgroundColor: AppColors.neutral10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              Text(
                'QR ${table.label}',
                style: AppTypography.h8Bold.copyWith(
                  color: AppColors.neutral100,
                ),
              ),
              Text(
                'Customer scan QR ini buat buka menu & pesan. '
                'Ini QR meja (order), bukan QRIS pembayaran Midtrans.',
                style: AppTypography.bodyRegularM.copyWith(
                  color: AppColors.neutral70,
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral10,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.neutral30),
                  ),
                  child: QrImageView(
                    data: table.qrPayload,
                    size: 220,
                    backgroundColor: AppColors.neutral10,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: AppColors.neutral100,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: AppColors.neutral100,
                    ),
                  ),
                ),
              ),
              SelectableText(
                table.qrPayload,
                style: AppTypography.bodyRegularS.copyWith(
                  color: AppColors.neutral70,
                ),
              ),
              PrimaryButton(
                text: 'Download QR',
                height: 48,
                enabled: !isBusy,
                leading: const Icon(
                  // TODO: ganti Material icon ini dengan asset ikon final.
                  Icons.download_rounded,
                  color: AppColors.neutral10,
                ),
                onPressed: () => _download(table),
              ),
              PrimaryButton(
                text: 'Generate Ulang QR',
                height: 48,
                reverse: true,
                borderColor: AppColors.orangeMain,
                textColor: AppColors.orangeMain,
                enabled: !isBusy,
                leading: Icon(
                  // TODO: ganti Material icon ini dengan asset ikon final.
                  Icons.refresh_rounded,
                  color: AppColors.orangeMain,
                ),
                onPressed: _regenerate,
              ),
              PrimaryButton(
                text: 'Tutup',
                height: 48,
                reverse: true,
                borderColor: AppColors.neutral40,
                textColor: AppColors.neutral80,
                enabled: !isBusy,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
