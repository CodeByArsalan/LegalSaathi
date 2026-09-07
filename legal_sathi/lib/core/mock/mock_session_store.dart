/// Mutable state for the mock backend, alive for the length of the run.
///
/// Created documents and payments are kept here instead of being written back
/// into the bundled JSON assets, so builder → preview → my documents behaves
/// like a real session while `USE_MOCK_API` is on.
final class MockSessionStore {
  final Map<int, Map<String, dynamic>> _documents =
      <int, Map<String, dynamic>>{};
  final Map<String, Map<String, dynamic>> _payments =
      <String, Map<String, dynamic>>{};

  List<Map<String, dynamic>> get documents =>
      _documents.values.toList(growable: false);

  List<Map<String, dynamic>> get payments =>
      _payments.values.toList(growable: false);

  /// Documents are keyed by the API's `userDocumentId`, the only id its routes
  /// accept.
  Map<String, dynamic>? document(int documentId) => _documents[documentId];

  void putDocument(Map<String, dynamic> document) {
    _documents[document['userDocumentId'] as int] = Map<String, dynamic>.from(
      document,
    );
  }

  /// Stands in for the identity column the API assigns on insert: one above the
  /// highest id already held, so seeded rows and created ones never collide.
  int nextDocumentId() =>
      _documents.keys.fold<int>(0, (int a, int b) => a > b ? a : b) + 1;

  void putPayment(Map<String, dynamic> payment) {
    _payments[payment['id'] as String] = Map<String, dynamic>.from(payment);
  }

  void clear() {
    _documents.clear();
    _payments.clear();
  }
}
