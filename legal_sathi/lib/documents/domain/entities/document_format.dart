/// The two formats `POST /Documents/{id}/generate` renders and serves.
enum DocumentFormat {
  pdf('pdf', 'application/pdf'),
  docx(
    'docx',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  );

  const DocumentFormat(this.extension, this.mimeType);

  /// Used for the saved file's name and for telling the receiving app what it is.
  final String extension;
  final String mimeType;
}
