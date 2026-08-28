import 'package:flutter/material.dart';

enum KasirNavItem {
  // TODO: ganti Material icon ini dengan asset ikon final.
  incomingOrders('Pesanan Masuk', Icons.receipt_long_rounded),
  transactions('Riwayat Transaksi', Icons.history_rounded),
  menu('Kelola Menu', Icons.restaurant_menu_rounded),
  shift('Shift', Icons.access_time_rounded),
  settings('Pengaturan', Icons.settings_rounded);

  const KasirNavItem(this.label, this.icon);

  final String label;
  final IconData icon;
}
