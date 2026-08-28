import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Center(
        child: CupertinoActivityIndicator(
          radius: (size ?? 0) <= 0 || size == null ? 16 : (size!),
          color: color,
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      );
    }
  }
}
