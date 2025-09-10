import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Controller to show/hide the reusable overlay bottom sheet
class OverlayBottomSheetController {
  OverlayEntry? _entry;
  late AnimationController _animationController;
  late Animation<double> _animation;

  void init(TickerProvider vsync) {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void show({required BuildContext context, required Widget child}) {
    if (_entry != null) return;

    _entry = OverlayEntry(
      builder: (ctx) => GestureDetector(
        onTap: hide,
        child: Material(
          color: Colors.black.withOpacity(0.5),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizeTransition(
              sizeFactor: _animation,
              axisAlignment: -1,
              child: child,
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_entry!);
    _animationController.forward();
  }

  void hide() {
    _animationController.reverse().then((_) {
      _entry?.remove();
      _entry = null;
    });
  }

  void dispose() {
    _animationController.dispose();
    _entry?.remove();
  }
}

/// A reusable bottom sheet widget
class OverlayBottomSheet extends StatelessWidget {
  final double height;
  final Widget child;

  const OverlayBottomSheet({
    super.key,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: child,
    );
  }
}
