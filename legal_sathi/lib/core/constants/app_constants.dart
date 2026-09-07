/// Storage keys and tunable form/business constants.
final class AppConstants {
  const AppConstants._();

  // Secure storage
  static const String accessTokenKey = 'auth.access_token';
  static const String refreshTokenKey = 'auth.refresh_token';
  static const String userJsonKey = 'auth.user_json';

  // Shared preferences
  static const String localeCodeKey = 'settings.locale_code';
  static const String notificationsEnabledKey =
      'settings.notifications_enabled';

  // Document builder
  static const int otpLength = 6;
  static const int minPasswordLength = 8;
  static const int cnicDigits = 13;
  static const int maxSignatureBytes = 2 * 1024 * 1024;

  // Money — prices are stored as PKR decimals in the API contract.
  static const String currencyCode = 'PKR';
  static const String currencySymbol = 'Rs.';

  // Listings
  static const int pageSize = 20;

  /// Search is a server round trip per query, so keystrokes are coalesced.
  static const Duration searchDebounce = Duration(milliseconds: 350);
}
