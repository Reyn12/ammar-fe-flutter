import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class KasirMenuPhotoActionChip extends StatelessWidget {
  const KasirMenuPhotoActionChip({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
  });

  // TODO: ganti Material icon ini dengan asset ikon final.
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? AppColors.neutral10,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 18,
            color: iconColor ?? AppColors.neutral80,
          ),
        ),
      ),
    );
  }
}
