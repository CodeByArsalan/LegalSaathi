extension StringX on String {
  bool get isBlank => trim().isEmpty;
  bool get isNotBlank => trim().isNotEmpty;

  String get digitsOnly => replaceAll(RegExp(r'\D'), '');

  bool get looksLikeEmail =>
      RegExp(r'^[\w.+-]+@([\w-]+\.)+[A-Za-z]{2,}$').hasMatch(trim());

  String get sentenceCase =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  /// Shows the tail of an email/transaction id in receipts: `abcd••••wxyz`.
  String get masked {
    if (length <= 8) return this;
    return '${substring(0, 4)}••••${substring(length - 4)}';
  }
}
