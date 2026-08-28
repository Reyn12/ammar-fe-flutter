import 'dart:async';

import 'package:flutter/material.dart';

import '../helper/format_time_helper.dart';
import '../resources/app_typography.dart';
import '../resources/resources.dart';

/// Jam berjalan di header kasir & dapur.
class LiveClock extends StatefulWidget {
  const LiveClock({super.key, this.textStyle, this.color, this.showDate = true});

  final TextStyle? textStyle;
  final Color? color;
  final bool showDate;

  @override
  State<LiveClock> createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formatClockWithSecond(_now),
          style:
              widget.textStyle ??
              AppTypography.h9Bold.copyWith(
                color: widget.color ?? AppColors.neutral100,
                height: 1.2,
              ),
        ),
        if (widget.showDate)
          Text(
            formatDateShort(_now),
            style: AppTypography.bodyRegularS.copyWith(
              color: AppColors.neutral70,
              height: 1.2,
            ),
          ),
      ],
    );
  }
}
