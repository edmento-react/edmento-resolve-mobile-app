import 'package:flutter/material.dart';

/// Simple widget performance optimizer - minimal overhead
class WidgetPerformanceOptimizer extends StatelessWidget {
  final Widget child;

  const WidgetPerformanceOptimizer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: child);
  }
}
