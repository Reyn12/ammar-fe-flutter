import 'package:flutter/material.dart';

class AppColors {
  // Color
  static const Color background = Color(0xFFFCFDFF);
  static const Color primary = Color(0xFF0050AA);
  static const Color orange = Color(0xFFFFB74D);
  static const Color orangeMain = Color(0xFFFF7817);
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  // Primary
  static const Color primaryMain = Color(0xFF0050AA);
  static const Color primaryBorder = Color(0xFFC9DBF9);
  static const Color primarySurface = Color(0xFFE3ECFB);
  static const Color primaryHover = Color(0xFF3470AB);
  static const Color primaryPressed = Color(0xFF1A3F64);

  // Shades Primary
  static const Color shadesPrimary10 = Color(0xFFE3ECFB);
  static const Color shadesPrimary20 = Color(0xFFC5D8F8);
  static const Color shadesPrimary30 = Color(0xFFA6C6F5);
  static const Color shadesPrimary40 = Color(0xFF83B3F2);
  static const Color shadesPrimary50 = Color(0xFF59A2EE);
  static const Color shadesPrimary60 = Color(0xFF448FD9);
  static const Color shadesPrimary70 = Color(0xFF3A7DBE);
  static const Color shadesPrimary80 = Color(0xFF316BA4);
  static const Color shadesPrimary90 = Color(0xFF285A8A);
  static const Color shadesPrimary100 = Color(0xFF23507C);

  // Neutral
  static const Color neutral10 = Color(0xFFFFFFFF);
  static const Color neutral20 = Color(0xFFF5F5F5);
  static const Color neutral30 = Color(0xFFEDEDED);
  static const Color neutral40 = Color(0xFFE0E0E0);
  static const Color neutral50 = Color(0xFFC2C2C2);
  static const Color neutral60 = Color(0xFF9E9E9E);
  static const Color neutral70 = Color(0xFF757575);
  static const Color neutral80 = Color(0xFF616161);
  static const Color neutral90 = Color(0xFF424242);
  static const Color neutral100 = Color(0xFF0A0A0A);

  // Danger
  static const Color dangerMain = Color(0xFFCB3A31);
  static const Color dangerSurface = Color(0xFFFFF4F2);
  static const Color dangerBorder = Color(0xFFEEB4B0);
  static const Color dangerHover = Color(0xFFBD251C);
  static const Color dangerPressed = Color(0xFF731912);

  // Success
  static const Color successMain = Color(0xFF43936C);
  static const Color successSurface = Color(0xFFF6FFF9);
  static const Color successSoft = Color(0xFFD8F5E7);
  static const Color successBorder = Color(0xFFB8DBCA);
  static const Color successHover = Color(0xFF367A59);
  static const Color successPressed = Color(0xFF20573D);

  // Warning
  static const Color warningMain = Color(0xFFEBBC46);
  static const Color warningYellow = Color(0xFFFFBA02);
  static const Color warningSurface = Color(0xFFFBF2DA);
  static const Color warningBorder = Color(0xFFEEC765);
  static const Color warningHover = Color(0xFFC49D3A);
  static const Color warningPressed = Color(0xFF9D7D2F);

  // Aliases (kompatibilitas pemakaian lama)
  static const Color scaffoldBackgroundColor = background;
  static const Color border = primaryBorder;
  static const Color error = dangerMain;
  static const Color errorSurface = dangerSurface;
  static const Color success = successMain;
  static const Color warning = warningMain;

  static const Color textColor10 = neutral10;
  static const Color textColor20 = neutral20;
  static const Color textColor30 = neutral50;
  static const Color textColor40 = neutral60;
  static const Color textColor50 = neutral70;
  static const Color textColor60 = neutral80;
  static const Color textColor70 = neutral80;
  static const Color textColor80 = neutral90;
  static const Color textColor90 = neutral90;
  static const Color textColor100 = neutral100;
}

class AppShadows {
  /// Drop shadow: x 0, y 2, blur 25, spread 0, #000 @ 7%
  static List<BoxShadow> get soft => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.07),
          blurRadius: 25,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ];

  static List<BoxShadow> get smooth => soft;
}