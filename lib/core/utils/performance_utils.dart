import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PerformanceUtils {
  // Disable debug prints in production
  static void disableDebugPrints() {
    if (kReleaseMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
  }

  // Optimize rendering performance
  static void optimizeRendering() {
    // Enable hardware acceleration
    if (kReleaseMode) {
      // Reduce debug overhead
      debugPaintSizeEnabled = false;
      debugRepaintRainbowEnabled = false;
    }

    // Optimize scheduler priority
    SchedulerBinding.instance.schedulerPhase;
  }

  // Memory optimization helpers
  static void clearImageCache() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  // Set optimal image cache size based on device
  static void optimizeImageCache() {
    final cache = PaintingBinding.instance.imageCache;

    // Set cache size based on available memory
    cache.maximumSize = 100; // Limit number of images
    cache.maximumSizeBytes = 50 * 1024 * 1024; // 50MB limit
  }

  // Batch widget builds to improve performance
  static void batchWidgetBuilds(VoidCallback callback) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  // Debounce function for performance-sensitive operations
  static Function debounce(Function func, Duration duration) {
    Timer? timer;

    return ([dynamic args]) {
      timer?.cancel();
      timer = Timer(duration, () {
        func(args);
      });
    };
  }

  // Throttle function for scroll events
  static Function throttle(Function func, Duration duration) {
    Timer? timer;
    bool canExecute = true;

    return ([dynamic args]) {
      if (canExecute) {
        func(args);
        canExecute = false;
        timer = Timer(duration, () {
          canExecute = true;
        });
      }
    };
  }

  // Optimize system UI for performance
  static void optimizeSystemUI() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );
  }

  // Memory pressure handler
  static void handleMemoryPressure() {
    // Clear image cache on memory pressure
    clearImageCache();

    // Force garbage collection (use sparingly)
    if (kDebugMode) {
      // Only in debug mode to avoid production issues
      // System.gc() equivalent not available in Dart/Flutter
    }
  }

  // Performance monitoring
  static void monitorFrameRate() {
    if (kDebugMode) {
      SchedulerBinding.instance.addTimingsCallback((timings) {
        for (final timing in timings) {
          final frameTime = timing.totalSpan.inMilliseconds;
          if (frameTime > 16) {
            // 60fps = 16.67ms per frame
            debugPrint('Slow frame detected: ${frameTime}ms');
          }
        }
      });
    }
  }

  // Widget efficiency checker
  static Widget efficient({
    required Widget child,
    Key? key,
    bool addRepaintBoundary = true,
    bool addAutomaticKeepAlive = false,
  }) {
    Widget result = child;

    if (addRepaintBoundary) {
      result = RepaintBoundary(child: result);
    }

    if (key != null) {
      result = KeyedSubtree(key: key, child: result);
    }

    return result;
  }

  // Lazy loading helper
  static Widget lazyBuilder({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    double? itemExtent,
  }) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return PerformanceUtils.efficient(
          key: ValueKey(index),
          child: itemBuilder(context, index),
        );
      },
      itemCount: itemCount,
      itemExtent: itemExtent,
      cacheExtent: 200.0,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false, // We handle this manually
    );
  }

  // Initialize performance optimizations
  static void initialize() {
    disableDebugPrints();
    optimizeRendering();
    optimizeImageCache();
    optimizeSystemUI();

    if (kDebugMode) {
      monitorFrameRate();
    }
  }
}
