import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../resources/resources.dart';
import '../../../widget/dialog_mixin.dart';
import '../providers/kitchen_action_provider.dart';
import '../widgets/kitchen_batch_sidebar.dart';
import '../widgets/kitchen_footer.dart';
import '../widgets/kitchen_header.dart';
import '../widgets/kitchen_order_page_view.dart';
import '../widgets/kitchen_pagination.dart';

class KitchenBoardPage extends ConsumerStatefulWidget {
  const KitchenBoardPage({super.key});

  @override
  ConsumerState<KitchenBoardPage> createState() => _KitchenBoardPageState();
}

class _KitchenBoardPageState extends ConsumerState<KitchenBoardPage>
    with DialogMixin {
  @override
  Widget build(BuildContext context) {
    listenAction<bool>(
      context: context,
      state: ref.watch(kitchenActionControllerProvider),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          children: [
            const KitchenBatchSidebar(),
            Expanded(
              child: Column(
                children: [
                  const KitchenHeader(),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: KitchenOrderPageView(),
                    ),
                  ),
                  const KitchenPagination(),
                  const SizedBox(height: 8),
                  const KitchenFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
