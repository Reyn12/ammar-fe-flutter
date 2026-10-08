import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/primary_button.dart';
import '../../../widget/status_pill.dart';
import '../../../widget/surface_card.dart';
import '../models/table_account_model.dart';

class KasirTableItem extends StatelessWidget {
  const KasirTableItem({
    super.key,
    required this.table,
    required this.onShowQr,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  final TableAccountModel table;
  final VoidCallback onShowQr;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleActive;

  @override
  Widget build(BuildContext context) {
    final active = table.isActive;

    return SurfaceCard(
      padding: const EdgeInsets.all(16),
      borderColor: active ? AppColors.neutral30 : AppColors.neutral40,
      backgroundColor: active ? AppColors.neutral10 : AppColors.neutral20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  table.label,
                  style: AppTypography.h8Bold.copyWith(
                    color: active
                        ? AppColors.neutral100
                        : AppColors.neutral70,
                    height: 1.15,
                  ),
                ),
              ),
              StatusPill(
                label: active ? 'Aktif' : 'Nonaktif',
                foregroundColor: active
                    ? AppColors.successMain
                    : AppColors.neutral70,
                backgroundColor: active
                    ? AppColors.successSoft
                    : AppColors.neutral30,
                dense: true,
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Opacity(
                opacity: active ? 1 : 0.35,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.neutral10,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.neutral30),
                  ),
                  child: QrImageView(
                    data: table.qrPayload,
                    size: 132,
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
            ),
          ),
          PrimaryButton(
            text: 'Lihat QR',
            height: 44,
            leading: const Icon(
              // TODO: ganti Material icon ini dengan asset ikon final.
              Icons.qr_code_2_rounded,
              color: AppColors.neutral10,
              size: 18,
            ),
            onPressed: onShowQr,
          ),
          Row(
            children: [
              Text(
                active ? 'Tersedia' : 'Nonaktif',
                style: AppTypography.bodyRegularS.copyWith(
                  color: AppColors.neutral70,
                ),
              ),
              Switch(
                value: active,
                activeTrackColor: AppColors.successMain,
                onChanged: (_) => onToggleActive(),
              ),
              const Spacer(),
              IconButton(
                onPressed: onEdit,
                tooltip: 'Edit meja',
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primarySurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: const Icon(
                  Icons.edit_rounded,
                  size: 18,
                  color: AppColors.primaryMain,
                ),
              ),
              IconButton(
                onPressed: onDelete,
                tooltip: 'Hapus meja',
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.dangerSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // TODO: ganti Material icon ini dengan asset ikon final.
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  size: 18,
                  color: AppColors.dangerMain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
