import 'package:flutter/material.dart';

import 'resources.dart';

class AppFonts {
  static const String kiro = 'Kiro';
}

class AppTheme {
  static ThemeData get light {
    const fontFamily = AppFonts.kiro;

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    );
  }
}
