import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../config/app_config.dart';
import '../constants/app_constants.dart';

/// Shared plumbing for mock data sources: cached asset reads, simulated
/// latency and list paging, so mock-driven screens exercise the same loading,
/// empty and error states the real API will produce.
abstract class MockDataSource {
  static final Map<String, List<Map<String, dynamic>>> _rowCache =
      <String, List<Map<String, dynamic>>>{};

  Future<T> withLatency<T>(T value) async {
    await Future<T>.delayed(AppConfig.mockLatency, () => value);
    return value;
  }

  /// Reads `assets/mock/*.json`, accepting either a bare array or an object
  /// with a `data` array.
  Future<List<Map<String, dynamic>>> loadRows(String assetPath) async {
    final List<Map<String, dynamic>>? cached = _rowCache[assetPath];
    if (cached != null) return cached;

    final Object? decoded = jsonDecode(await rootBundle.loadString(assetPath));
    final List<dynamic> raw = switch (decoded) {
      final List<dynamic> list => list,
      final Map<String, dynamic> object => object['data'] as List<dynamic>,
      _ => throw StateError('Unexpected mock shape at $assetPath'),
    };

    final List<Map<String, dynamic>> rows =
        List<Map<String, dynamic>>.unmodifiable(
          raw.map((dynamic row) => Map<String, dynamic>.from(row as Map)),
        );
    _rowCache[assetPath] = rows;
    return rows;
  }

  List<Map<String, dynamic>> paginate(
    List<Map<String, dynamic>> rows, {
    required int page,
    int pageSize = AppConstants.pageSize,
  }) {
    final int start = page * pageSize;
    if (start >= rows.length) return const <Map<String, dynamic>>[];
    final int end = start + pageSize > rows.length
        ? rows.length
        : start + pageSize;
    return rows.sublist(start, end);
  }

  String idOf(Map<String, dynamic> row) => row['id']?.toString() ?? '';
}
