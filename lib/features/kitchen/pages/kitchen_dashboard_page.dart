import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/kitchen_provider.dart';

class KitchenDashboardPage extends ConsumerWidget {
  const KitchenDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(kitchenProvider);
    return const Scaffold(body: SizedBox.shrink());
  }
}
