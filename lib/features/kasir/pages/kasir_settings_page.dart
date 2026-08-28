import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/kasir_page_header.dart';
import '../widgets/kasir_settings_builder.dart';

class KasirSettingsPage extends ConsumerWidget {
  const KasirSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 18,
        children: [
          const KasirPageHeader(
            title: 'Pengaturan',
            subtitle: 'Konfigurasi perangkat kasir dan preferensi toko.',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 760),
                child: const KasirSettingsBuilder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
