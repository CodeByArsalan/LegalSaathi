/// Lifecycle of a document, mirroring the API's `DocumentStatus` enum.
///
/// The server sends both the name (`"Completed"`) and the numeric id
/// (`statusId: 2`), and they agree, so either can be trusted; the name is read
/// first because it survives a renumbering.
enum DocumentStatus {
  draft,
  completed,
  pendingSignature,
  signed,
  underLawyerReview,
  lawyerApproved,
  archived;

  /// The server's `statusId`: Draft = 1 through Archived = 7, in declaration
  /// order.
  int get id => index + 1;

  static DocumentStatus parse(String? value) =>
      tryParse(value) ?? DocumentStatus.draft;

  /// `null` when the name is not one of ours, so a caller that also holds the
  /// numeric `statusId` can fall back to it.
  static DocumentStatus? tryParse(String? value) {
    final String normalized = value?.trim().toLowerCase() ?? '';
    for (final DocumentStatus status in values) {
      if (status.name.toLowerCase() == normalized) return status;
    }
    return null;
  }

  static DocumentStatus fromId(int? statusId) => values.firstWhere(
    (DocumentStatus status) => status.id == statusId,
    orElse: () => DocumentStatus.draft,
  );

  /// The server sends the name and the id together. The name wins because it
  /// keeps its meaning if the numbering is ever changed; the id is the fallback
  /// for a name this build does not know.
  static DocumentStatus resolve(String? name, int? statusId) =>
      tryParse(name) ?? fromId(statusId);

  /// Answers may still be changed. `PUT /Documents/{id}/answers` is accepted at
  /// any status, but generation has already rendered the stored answers into a
  /// PDF, so editing afterwards silently desynchronises the file. Editing is
  /// therefore offered only while nothing has been produced.
  bool get isEditable => this == DocumentStatus.draft;

  /// A rendered file exists.
  bool get isGenerated => this != DocumentStatus.draft;

  bool get needsSignature =>
      this == DocumentStatus.completed ||
      this == DocumentStatus.pendingSignature;

  bool get isSigned =>
      this == DocumentStatus.signed || this == DocumentStatus.lawyerApproved;

  bool get isClosed => this == DocumentStatus.archived;
}

extension DocumentStatusLabel on DocumentStatus {
  /// easy_localization key inside the `documents.status.*` group.
  String get l10nKey => switch (this) {
    DocumentStatus.draft => 'documents.status.draft',
    DocumentStatus.completed => 'documents.status.completed',
    DocumentStatus.pendingSignature => 'documents.status.pending_signature',
    DocumentStatus.signed => 'documents.status.signed',
    DocumentStatus.underLawyerReview => 'documents.status.under_lawyer_review',
    DocumentStatus.lawyerApproved => 'documents.status.lawyer_approved',
    DocumentStatus.archived => 'documents.status.archived',
  };
}
