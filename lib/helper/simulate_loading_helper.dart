import 'package:flutter/material.dart';
import 'package:ammar_fe_flutter/widget/loading_dialog.dart';

class SimulateLoadingHelper {
  SimulateLoadingHelper._();

  /// Show loading dialog, wait [duration], then hide.
  /// Returns `false` if [context] is no longer mounted after the delay.
  static Future<bool> run(
    BuildContext context, {
    Duration duration = const Duration(milliseconds: 800),
  }) async {
    LoadingDialog.show(context);
    await Future<void>.delayed(duration);
    if (!context.mounted) return false;
    LoadingDialog.hide(context);
    return true;
  }
}
