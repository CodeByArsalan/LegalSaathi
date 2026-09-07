import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

import 'document_sharer.dart';

/// Opens the platform's share sheet with the rendered file attached, which is
/// where a phone offers saving to Files, printing, and every installed reader in
/// one place — rather than the app owning a private copy of the file.
final class SharePlusDocumentSharer implements DocumentSharer {
  const SharePlusDocumentSharer();

  @override
  Future<void> share(
    Uint8List bytes, {
    required String fileName,
    required String mimeType,
  }) async {
    await SharePlus.instance.share(
      ShareParams(
        files: <XFile>[XFile.fromData(bytes, mimeType: mimeType)],
        // A name given to `XFile.fromData` is dropped on every platform but
        // web, so the sheet is told the filename separately.
        fileNameOverrides: <String>[fileName],
      ),
    );
  }
}
