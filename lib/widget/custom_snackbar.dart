import 'package:flutter/material.dart';

enum SnackbarPosition { top, bottom }

/*
Created by Reyy
20 November 2025
*/

/*
Usage:
CustomSnackbar.success(context, 'Success', title: 'Success', position: SnackbarPosition.top);
CustomSnackbar.error(context, 'Error', title: 'Error', position: SnackbarPosition.top);
CustomSnackbar.info(context, 'Info', title: 'Info', position: SnackbarPosition.top);
CustomSnackbar.warning(context, 'Warning', title: 'Warning', position: SnackbarPosition.top);
*/

class CustomSnackbar {
  static bool _isShowing = false;
  static OverlayEntry? _currentOverlayEntry;
  static DateTime? _lastBackPressed;
  // Success Snackbar
  static void success(
    BuildContext context,
    String message, {
    String? title,
    SnackbarPosition position = SnackbarPosition.top,
  }) {
    _show(
      context,
      title: title ?? 'Success',
      message: message,
      icon: Icons.check,
      borderColor: const Color(0xFF10B981),
      iconColor: const Color(0xFF10B981),
      position: position,
    );
  }

  // Error Snackbar
  static void error(
    BuildContext context,
    String message, {
    String? title,
    SnackbarPosition position = SnackbarPosition.top,
  }) {
    _show(
      context,
      title: title ?? 'Error',
      message: message,
      icon: Icons.close,
      borderColor: const Color(0xFFEF4444),
      iconColor: const Color(0xFFEF4444),
      position: position,
    );
  }

  // Info Snackbar
  static void info(
    BuildContext context,
    String message, {
    String? title,
    SnackbarPosition position = SnackbarPosition.top,
  }) {
    _show(
      context,
      title: title ?? 'Info',
      message: message,
      icon: Icons.info_outline,
      borderColor: const Color(0xFF3B82F6),
      iconColor: const Color(0xFF3B82F6),
      position: position,
    );
  }

  // Warning Snackbar
  static void warning(
    BuildContext context,
    String message, {
    String? title,
    SnackbarPosition position = SnackbarPosition.bottom,
  }) {
    _show(
      context,
      title: title ?? 'Warning',
      message: message,
      icon: Icons.warning_amber_rounded,
      borderColor: const Color(0xFFF59E0B),
      iconColor: const Color(0xFFF59E0B),
      position: position,
    );
  }

  static Future<bool> doubleBackToExit(BuildContext context) async {
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;

      if (_isShowing && _currentOverlayEntry != null) {
        _currentOverlayEntry!.remove();
        _isShowing = false;
        _currentOverlayEntry = null;
      }

      warning(
        context,
        'Tekan sekali lagi untuk keluar aplikasi',
        title: 'Peringatan',
      );
      return false;
    }
    return true;
  }

  static void _show(
    BuildContext context, {
    required String title,
    required String message,
    required IconData icon,
    required Color borderColor,
    required Color iconColor,
    required SnackbarPosition position,
  }) {
    if (_isShowing && _currentOverlayEntry != null) {
      _currentOverlayEntry!.remove();
      _isShowing = false;
      _currentOverlayEntry = null;
    }

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    _isShowing = true;

    overlayEntry = OverlayEntry(
      builder: (context) => _AnimatedSnackbar(
        title: title,
        message: message,
        icon: icon,
        borderColor: borderColor,
        iconColor: iconColor,
        position: position,
        onDismiss: () {
          overlayEntry.remove();
          _isShowing = false;
          _currentOverlayEntry = null;
        },
      ),
    );

    _currentOverlayEntry = overlayEntry;
    overlay.insert(overlayEntry);
    // Auto dismiss sudah di-handle di _AnimatedSnackbarState.initState()
  }
}

class _AnimatedSnackbar extends StatefulWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color borderColor;
  final Color iconColor;
  final SnackbarPosition position;
  final VoidCallback onDismiss;

  const _AnimatedSnackbar({
    required this.title,
    required this.message,
    required this.icon,
    required this.borderColor,
    required this.iconColor,
    required this.position,
    required this.onDismiss,
  });

  @override
  State<_AnimatedSnackbar> createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<_AnimatedSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Animasi slide dari atas ke bawah atau bawah ke atas
    _slideAnimation = Tween<Offset>(
      begin: widget.position == SnackbarPosition.top
          ? const Offset(0, -1) // Mulai dari atas
          : const Offset(0, 1), // Mulai dari bawah
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Animasi fade
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Auto dismiss setelah 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _animateOut();
      }
    });
  }

  void _animateOut() {
    if (!mounted) return;
    _controller.reverse().then((_) {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.5;

    return Positioned(
      top: widget.position == SnackbarPosition.top ? 65 : null,
      bottom: widget.position == SnackbarPosition.bottom ? 70 : null,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.center,
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: width,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: widget.borderColor.withValues(alpha: 1),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon dalam kotak rounded
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: widget.iconColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(widget.icon, color: Colors.white, size: 12),
                      ),
                      const SizedBox(width: 12),
                      // Title dan Message
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0A0A0A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.message,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF757575),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Close button
                      GestureDetector(
                        onTap: _animateOut,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
