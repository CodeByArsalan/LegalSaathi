import 'dart:typed_data';

/// Hands a rendered file to the platform, so the user can save it, print it or
/// open it in a reader.
///
/// An interface rather than a direct plugin call so the cubit that drives a
/// download stays unit-testable: no platform channels are involved in the path
/// that fetches bytes and names them.
abstract class DocumentSharer {
  Future<void> share(
    Uint8List bytes, {
    required String fileName,
    required String mimeType,
  });
}
