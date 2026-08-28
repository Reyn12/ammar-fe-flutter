import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomSheetHelper {
  /// Bottom sheet with drag indicator bar.
  static Future<T?> showBar<T>(
    BuildContext context, {
    required Widget Function(BuildContext) builder,
    bool expand = false,
    bool enableDrag = true,
    bool isDismissible = true,
  }) {
    return showBarModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: builder,
      expand: expand,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      topControl: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Container(width: 52, height: 5, color: Colors.white),
      ),
    );
  }

  /// Bottom sheet without drag indicator.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget Function(BuildContext) builder,
    bool expand = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: builder,
      isDismissible: true,
      enableDrag: true,
    );
  }
}
