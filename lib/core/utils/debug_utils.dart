import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class DebugUtils {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  // Only log in debug mode
  static void log(String message, {String? tag}) {
    if (kDebugMode) {
      _logger.d('${tag != null ? '[$tag] ' : ''}$message');
    }
  }

  static void logInfo(String message, {String? tag}) {
    if (kDebugMode) {
      _logger.i('${tag != null ? '[$tag] ' : ''}$message');
    }
  }

  static void logWarning(String message, {String? tag}) {
    if (kDebugMode) {
      _logger.w('${tag != null ? '[$tag] ' : ''}$message');
    }
  }

  static void logError(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      _logger.e('${tag != null ? '[$tag] ' : ''}$message', error: error, stackTrace: stackTrace);
    }
  }

  // Performance monitoring
  static void logPerformance(String operation, Duration duration) {
    if (kDebugMode && duration.inMilliseconds > 16) {
      _logger.w('[$operation] took ${duration.inMilliseconds}ms (>16ms)');
    }
  }

  // Network logging
  static void logNetwork(String method, String url, int statusCode, Duration duration) {
    if (kDebugMode) {
      _logger.d('[$method] $url -> $statusCode (${duration.inMilliseconds}ms)');
    }
  }

  // State logging for BLoC
  static void logState(String bloc, dynamic previousState, dynamic newState) {
    if (kDebugMode) {
      _logger.d('[$bloc] $previousState -> $newState');
    }
  }

  // Navigation logging
  static void logNavigation(String from, String to) {
    if (kDebugMode) {
      _logger.d('[Navigation] $from -> $to');
    }
  }
}