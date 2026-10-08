import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../resources/app_typography.dart';
import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/image_load.dart';
import 'kasir_menu_photo_action_chip.dart';
import 'kasir_menu_photo_source_sheet.dart';

class KasirMenuPhotoPicker extends StatelessWidget {
  const KasirMenuPhotoPicker({
    super.key,
    required this.imagePath,
    required this.onChanged,
  });

  /// Path lokal / URL foto menu yang sedang dipilih.
  final String? imagePath;
  final ValueChanged<String?> onChanged;

  Future<void> _pick(BuildContext context) async {
    final source = await KasirMenuPhotoSourceSheet.show(context);
    if (source == null || !context.mounted) return;

    try {
      final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1280,
        maxHeight: 1280,
        imageQuality: 85,
      );
      if (file == null) return;
      onChanged(file.path);
    } catch (_) {
      if (!context.mounted) return;
      CustomSnackbar.error(
        context,
        source == ImageSource.camera
            ? 'Gagal membuka kamera. Cek izin kamera di pengaturan.'
            : 'Gagal membuka galeri. Cek izin foto di pengaturan.',
        title: 'Gagal Ambil Foto',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          'Foto Menu',
          style: AppTypography.bodyRegularL.copyWith(
            color: AppColors.neutral100,
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _pick(context),
            borderRadius: BorderRadius.circular(14),
            child: Ink(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.neutral20,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.neutral40),
              ),
              child: imagePath == null || imagePath!.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8,
                      children: [
                        // TODO: ganti Material icon ini dengan asset ikon final.
                        const Icon(
                          Icons.add_a_photo_rounded,
                          size: 36,
                          color: AppColors.neutral60,
                        ),
                        Text(
                          'Ketuk untuk ambil dari kamera / galeri',
                          style: AppTypography.bodyRegularM.copyWith(
                            color: AppColors.neutral70,
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: ImageLoad(
                            src: imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 160,
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Row(
                            spacing: 8,
                            children: [
                              KasirMenuPhotoActionChip(
                                // TODO: ganti Material icon ini dengan asset ikon final.
                                icon: Icons.edit_rounded,
                                onTap: () => _pick(context),
                              ),
                              KasirMenuPhotoActionChip(
                                // TODO: ganti Material icon ini dengan asset ikon final.
                                icon: Icons.delete_outline_rounded,
                                backgroundColor: AppColors.dangerSurface,
                                iconColor: AppColors.dangerMain,
                                onTap: () => onChanged(null),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
