import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

abstract final class AppLog {
  static const String _defaultTag = 'LegalSathi';

  static void debug(String message, {String tag = _defaultTag}) {
    if (kDebugMode) developer.log(message, name: tag);
  }

  static void api(String message) => debug(message, tag: 'API');

  static void info(String message) => debug(message, tag: 'INFO');

  static void warn(String message) => debug(message, tag: 'WARN');

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String tag = _defaultTag,
  }) => developer.log(message, name: tag, error: error, stackTrace: stackTrace);
}
