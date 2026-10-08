import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widget/custom_snackbar.dart';
import '../../auth/helpers/auth_permission.dart';
import '../../auth/providers/auth_provider.dart';
import '../pages/kasir_cashiers_page.dart';
import '../pages/kasir_kitchen_staff_page.dart';
import '../pages/kasir_tables_page.dart';
import 'kasir_change_password_dialog.dart';
import 'kasir_setting_section.dart';
import 'kasir_setting_tile_item.dart';

class KasirSettingsBuilder extends ConsumerWidget {
  const KasirSettingsBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final owner = isOwner(ref.watch(sessionProvider));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 22,
      children: [
        if (owner)
          KasirSettingSection(
            children: [
              KasirSettingTileItem(
                icon: Icons.badge_rounded,
                title: 'Kelola Kasir',
                subtitle: 'Tambah, edit, nonaktifkan, atau hapus akun kasir.',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const KasirCashiersPage(),
                    ),
                  );
                },
              ),
              KasirSettingTileItem(
                icon: Icons.soup_kitchen_rounded,
                title: 'Kelola Dapur',
                subtitle: 'Tambah, edit, nonaktifkan, atau hapus akun dapur.',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const KasirKitchenStaffPage(),
                    ),
                  );
                },
              ),
              KasirSettingTileItem(
                icon: Icons.table_restaurant_rounded,
                title: 'Kelola Meja',
                subtitle:
                    'Atur meja, generate QR order, download, atau generate ulang.',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const KasirTablesPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        if (owner)
          KasirSettingSection(
            title: 'Keamanan Akun',
            subtitle: 'Proteksi akses pemilik toko.',
            children: [
              KasirSettingTileItem(
                icon: Icons.lock_reset_rounded,
                title: 'Ganti Password Owner',
                subtitle: 'Perbarui password akun pemilik toko.',
                onTap: () => KasirChangePasswordDialog.show(context),
              ),
            ],
          ),
        KasirSettingSection(
          title: 'Toko & Perangkat',
          subtitle: 'Preferensi cabang, printer, dan koneksi realtime.',
          children: [
            KasirSettingTileItem(
              icon: Icons.store_rounded,
              title: 'Informasi Toko',
              subtitle: 'Nama cabang, alamat, dan pajak yang berlaku.',
              onTap: () => _showComingSoon(context),
            ),
            KasirSettingTileItem(
              icon: Icons.print_rounded,
              title: 'Printer Struk',
              subtitle: 'Sambungkan printer thermal untuk cetak struk.',
              onTap: () => _showComingSoon(context),
            ),
            KasirSettingTileItem(
              icon: Icons.notifications_active_rounded,
              title: 'Notifikasi',
              subtitle: 'Atur suara dan push notifikasi pesanan baru.',
              onTap: () => _showComingSoon(context),
            ),
            KasirSettingTileItem(
              icon: Icons.wifi_tethering_rounded,
              title: 'Koneksi Realtime',
              subtitle: 'Status koneksi SSE ke server pesanan.',
              onTap: () => _showComingSoon(context),
            ),
          ],
        ),
      ],
    );
  }

  void _showComingSoon(BuildContext context) {
    CustomSnackbar.info(
      context,
      'Menu pengaturan ini masih dalam pengembangan.',
      title: 'Coming Soon',
    );
  }
}
