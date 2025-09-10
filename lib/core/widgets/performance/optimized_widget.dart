import 'package:flutter/material.dart';

/// Simple optimized widget - minimal overhead
class OptimizedWidget extends StatelessWidget {
  final Widget child;
  final bool addRepaintBoundary;

  const OptimizedWidget({
    super.key,
    required this.child,
    this.addRepaintBoundary = true,
  });

  @override
  Widget build(BuildContext context) {
    if (addRepaintBoundary) {
      return RepaintBoundary(child: child);
    }
    return child;
  }
}
