import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helper/dialog_error_helper.dart';
import 'custom_snackbar.dart';
import 'loading_dialog.dart';

mixin DialogMixin {
  bool dialogShown = false;
  bool successHandled = false;
  String? lastErrorMessage;

  void loadingState(BuildContext context) {
    if (dialogShown) return;
    dialogShown = true;
    successHandled = false;
    lastErrorMessage = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LoadingDialog.show(context);
    });
  }

  void successState<T>(
    BuildContext context, {
    T? value,
    void Function()? onSuccess,
  }) {
    if (dialogShown) {
      dialogShown = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        LoadingDialog.hide(context);
        if (value != null && onSuccess != null) {
          onSuccess();
        }
      });
    } else if (value != null && onSuccess != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onSuccess();
      });
    }

    lastErrorMessage = null;
  }

  void errorState(
    BuildContext context, {
    required Object error,
  }) {
    if (dialogShown) {
      dialogShown = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        LoadingDialog.hide(context);
      });
    }

    final parsed = parseDialogError(error);
    final messageKey = '${parsed.title}|${parsed.message}';
    if (lastErrorMessage == messageKey) return;

    lastErrorMessage = messageKey;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomSnackbar.error(
        context,
        parsed.message,
        title: parsed.title,
      );
    });
  }

  void listenAction<T>({
    required BuildContext context,
    required AsyncValue<T?> state,
    void Function()? onSuccess,
  }) {
    state.when(
      loading: () => loadingState(context),
      error: (error, _) {
        successHandled = false;
        errorState(context, error: error);
      },
      data: (value) {
        if (value == null) {
          successHandled = false;
          if (dialogShown) {
            dialogShown = false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              LoadingDialog.hide(context);
            });
          }
          return;
        }

        if (successHandled) return;
        successHandled = true;

        successState<T>(
          context,
          value: value,
          onSuccess: onSuccess,
        );
      },
    );
  }
}

