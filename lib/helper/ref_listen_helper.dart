import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dialog_error_helper.dart';
import '../widget/custom_snackbar.dart';

extension RefListenHelper on WidgetRef {
  void listenFuture<T>(
    BuildContext context,
    dynamic provider, {
    void Function(T value)? onSuccess,
  }) {
    listen<AsyncValue<T>>(provider, (_, next) {
      next.whenOrNull(
        error: (error, _) {
          final parsed = parseDialogError(error);
          CustomSnackbar.error(
            context,
            parsed.message,
            title: parsed.title,
          );
        },
        data: onSuccess,
      );
    });
  }
}
