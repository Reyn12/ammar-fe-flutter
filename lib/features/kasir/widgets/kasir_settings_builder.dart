import 'package:flutter/material.dart';

import '../../../resources/resources.dart';
import '../../../widget/custom_snackbar.dart';
import '../../../widget/surface_card.dart';
import 'kasir_setting_tile_item.dart';

class KasirSettingsBuilder extends StatelessWidget {
  const KasirSettingsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          KasirSettingTileItem(
            icon: Icons.store_rounded,
            title: 'Informasi Toko',
            subtitle: 'Nama cabang, alamat, dan pajak yang berlaku.',
            onTap: () => _showComingSoon(context),
          ),
          const Divider(height: 1, color: AppColors.neutral30),
          KasirSettingTileItem(
            icon: Icons.print_rounded,
            title: 'Printer Struk',
            subtitle: 'Sambungkan printer thermal untuk cetak struk.',
            onTap: () => _showComingSoon(context),
          ),
          const Divider(height: 1, color: AppColors.neutral30),
          KasirSettingTileItem(
            icon: Icons.notifications_active_rounded,
            title: 'Notifikasi',
            subtitle: 'Atur suara dan push notifikasi pesanan baru.',
            onTap: () => _showComingSoon(context),
          ),
          const Divider(height: 1, color: AppColors.neutral30),
          KasirSettingTileItem(
            icon: Icons.wifi_tethering_rounded,
            title: 'Koneksi Realtime',
            subtitle: 'Status koneksi SSE ke server pesanan.',
            onTap: () => _showComingSoon(context),
          ),
        ],
      ),
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
