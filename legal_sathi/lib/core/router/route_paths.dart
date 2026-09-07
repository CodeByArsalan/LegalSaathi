/// URL patterns for the router plus helpers that build concrete locations.
///
/// Splash is `/splash` rather than `/` so the bottom-nav shell can own `/`.
abstract final class RoutePaths {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmail = '/verify-email';
  static const String home = '/home';
  static const String templates = '/templates';
  static const String documents = '/documents';
  static const String profile = '/profile';
  static const String settings = '/profile/settings';
  static const String editProfile = '/profile/edit';
  static const String payment = '/payment';
  static const String paymentSuccess = '/payment/success';
  static const String aiAssistant = '/ai-assistant';

  // Parameterised patterns consumed by GoRoute.

  /// Both are keyed by slug: `/Templates/{slug}` is the only detail lookup the
  /// API offers, and the builder needs that same detail call to learn the
  /// template's fields and its numeric id.
  static const String templateDetailPattern = '/templates/:slug';
  static const String documentBuilderPattern = '/document-builder/:slug';

  /// Both are keyed by the API's numeric `userDocumentId`.
  static const String previewPattern = '/preview/:documentId';
  static const String signaturePattern = '/signature/:documentId';

  static String templateDetail(String slug) => '/templates/$slug';
  static String documentBuilder(String slug) => '/document-builder/$slug';
  static String preview(int documentId) => '/preview/$documentId';
  static String signature(int documentId) => '/signature/$documentId';

  static String templatesByCategory(int categoryId) =>
      '$templates?category=$categoryId';

  /// Verification is reachable with no session (registration, or a login the
  /// server refused), so the address to verify travels in the URL rather than
  /// being read from a signed-in user.
  static String verifyEmailLocation(String email) =>
      '$verifyEmail?email=${Uri.encodeComponent(email)}';

  static String paymentLocation({
    required String documentId,
    required double amount,
  }) => '$payment?documentId=$documentId&amount=$amount';

  static String paymentSuccessLocation({
    required String transactionId,
    required double amount,
  }) => '$paymentSuccess?reference=$transactionId&amount=$amount';
}
