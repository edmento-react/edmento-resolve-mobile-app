import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// Minimal performance utilities - no monitoring overhead
class PerformanceUtils {
  /// Initialize minimal performance optimizations
  static void initialize() {
    // Only essential optimizations
    _optimizeImageCache();
    _optimizeSystemUI();
  }

  /// Optimize image cache
  static void _optimizeImageCache() {
    final cache = PaintingBinding.instance.imageCache;
    cache.maximumSize = 50;
    cache.maximumSizeBytes = 25 * 1024 * 1024; // 25MB
  }

  /// Optimize system UI
  static void _optimizeSystemUI() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );
  }

  /// Clear image cache
  static void clearImageCache() {
    PaintingBinding.instance.imageCache.clear();
  }
}
