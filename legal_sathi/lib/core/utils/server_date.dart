/// Parses the API's timestamps.
///
/// They arrive with no timezone designator, and they are not even consistent
/// with each other: on the same document record `createdAt` comes back two hours
/// ahead of `completedAt` and `signedAt`. Dart's `DateTime.parse` reads an
/// offset-less string as *device-local* time, which would silently skew every
/// "created 5 minutes ago" label by the difference between the server's clock
/// and the device's. Reading them all as UTC at least keeps them ordered the way
/// the server ordered them.
abstract final class ServerDate {
  const ServerDate._();

  static final RegExp _offsetSuffix = RegExp(r'(?:Z|[+-]\d{2}:?\d{2})$');

  static DateTime? parse(Object? value) {
    if (value is! String) return null;
    final String trimmed = value.trim();
    if (trimmed.isEmpty) return null;

    final String normalised = _offsetSuffix.hasMatch(trimmed)
        ? trimmed
        : '${trimmed}Z';
    try {
      return DateTime.parse(normalised);
    } on FormatException {
      return null;
    }
  }

  /// For the timestamps the contract guarantees, such as a document's
  /// `createdAt`. A value that will not parse degrades to the epoch rather than
  /// to "now": the row sorts oldest and displays 1970, which is visibly wrong
  /// rather than plausibly fresh.
  static DateTime required(Object? value) => parse(value) ?? DateTime.utc(1970);
}
