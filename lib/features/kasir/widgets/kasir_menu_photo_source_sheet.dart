import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/bottom_sheet_helper.dart';
import 'kasir_menu_photo_source_item.dart';

class KasirMenuPhotoSourceSheet extends StatelessWidget {
  const KasirMenuPhotoSourceSheet({super.key});

  static Future<ImageSource?> show(BuildContext context) {
    return BottomSheetHelper.show<ImageSource>(
      context,
      builder: (_) => const KasirMenuPhotoSourceSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Pilih sumber foto',
              style: AppTypography.h8Bold.copyWith(color: AppColors.neutral100),
            ),
            Text(
              'Ambil foto baru dari kamera atau pilih dari galeri.',
              style: AppTypography.bodyRegularM.copyWith(
                color: AppColors.neutral70,
              ),
            ),
            const SizedBox(height: 4),
            KasirMenuPhotoSourceItem(
              // TODO: ganti Material icon ini dengan asset ikon final.
              icon: Icons.photo_camera_rounded,
              title: 'Kamera',
              subtitle: 'Ambil foto menu sekarang',
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            const Divider(height: 1, color: AppColors.neutral30),
            KasirMenuPhotoSourceItem(
              // TODO: ganti Material icon ini dengan asset ikon final.
              icon: Icons.photo_library_rounded,
              title: 'Galeri',
              subtitle: 'Pilih foto dari perangkat',
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
