import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/kasir_provider.dart';

class KasirDashboardPage extends ConsumerWidget {
  const KasirDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(kasirProvider);
    return const Scaffold(body: SizedBox.shrink());
  }
}
