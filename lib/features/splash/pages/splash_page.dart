import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_ueu_flutter/gen/assets.gen.dart';
import 'package:mobile_ueu_flutter/resources/resources.dart';
import 'package:mobile_ueu_flutter/widget/image_load.dart';

import '../providers/splash_provider.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ImageLoad(src: Assets.images.logoMobileUeu.path, width: 220),
      ),
    );
  }
}
