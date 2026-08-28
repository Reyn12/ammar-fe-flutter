import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ammar_fe_flutter/widget/custom_scroll_scaffold.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollScaffold(
      onRefresh: () async {
        // TODO: implement refresh
      },
      child: Column(
        spacing: 24,
        children: [const SizedBox(height: 55), const SizedBox(height: 24)],
      ),
    );
  }
}
