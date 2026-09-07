import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

/// Loads a response captured from the live API into `test/fixtures/`. See
/// `_status_codes.txt` there for the HTTP status each capture returned; tokens
/// in the payloads are redacted.
///
/// Returns `null` for captures that arrived with an empty body — the API sends
/// no content at all with a 401.
Map<String, dynamic>? fixtureJson(String name) {
  final String raw = File('test/fixtures/$name.json').readAsStringSync();
  if (raw.trim().isEmpty) return null;
  return jsonDecode(raw) as Map<String, dynamic>;
}

/// Wraps a fixture in the [Response] a data source would have seen.
Response<dynamic> fixtureResponse(
  String name, {
  required int statusCode,
  String path = '/fixture',
}) {
  return Response<dynamic>(
    requestOptions: RequestOptions(path: path),
    statusCode: statusCode,
    data: fixtureJson(name),
  );
}

/// The [DioException] Dio raises for a non-2xx response.
DioException fixtureError(
  String name, {
  required int statusCode,
  String path = '/fixture',
}) {
  return DioException(
    requestOptions: RequestOptions(path: path),
    response: fixtureResponse(name, statusCode: statusCode, path: path),
    type: DioExceptionType.badResponse,
  );
}
