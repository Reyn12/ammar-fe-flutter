import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ammar_fe_flutter/resources/resources.dart';

class CustomScrollScaffold extends StatefulWidget {
  const CustomScrollScaffold({
    super.key,
    required this.child,
    this.onRefresh,
    this.backgroundColor = AppColors.background,
    this.statusBarOverlayColor = AppColors.primary,
    this.physics = const ClampingScrollPhysics(),
    this.systemOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  });

  final Widget child;
  final Future<void> Function()? onRefresh;
  final Color backgroundColor;
  final Color statusBarOverlayColor;
  final ScrollPhysics physics;
  final SystemUiOverlayStyle systemOverlayStyle;

  @override
  State<CustomScrollScaffold> createState() => _CustomScrollScaffoldState();
}

class _CustomScrollScaffoldState extends State<CustomScrollScaffold> {
  bool _isScrolled = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: widget.systemOverlayStyle,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification ||
                    notification is ScrollEndNotification) {
                  final scrolled = notification.metrics.pixels > 0;
                  if (_isScrolled != scrolled) {
                    setState(() => _isScrolled = scrolled);
                  }
                }
                return false;
              },
              child: widget.onRefresh == null
                  ? SingleChildScrollView(
                      physics: widget.physics,
                      child: widget.child,
                    )
                  : RefreshIndicator(
                      color: AppColors.primary,
                      backgroundColor: AppColors.white,
                      onRefresh: widget.onRefresh!,
                      displacement: 48,
                      edgeOffset: MediaQuery.paddingOf(context).top,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(
                          parent: widget.physics,
                        ),
                        child: widget.child,
                      ),
                    ),
            ),
            if (_isScrolled)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: ColoredBox(
                    color: widget.statusBarOverlayColor,
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.paddingOf(context).top,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
