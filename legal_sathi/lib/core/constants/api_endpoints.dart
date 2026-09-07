/// REST contract of the ASP.NET Core backend. Paths are relative to
/// `AppConfig.baseUrl`, which already ends in `/api`, so each constant starts
/// at the controller segment. Routing is case-insensitive on the server.
final class ApiEndpoints {
  const ApiEndpoints._();

  // Auth — registration, OTP email verification, JWT pair, profile.
  static const String register = '/Auth/register';
  static const String verifyEmail = '/Auth/verify-email';
  static const String resendVerification = '/Auth/resend-verification';
  static const String login = '/Auth/login';
  static const String refreshToken = '/Auth/refresh-token';
  static const String revokeToken = '/Auth/revoke-token';
  static const String me = '/Auth/me';
  static const String profile = '/Auth/profile';
  static const String sendOtp = '/Auth/send-otp';
  static const String verifyOtp = '/Auth/verify-otp';

  // Templates — the list is a summary without fields; only the slug route
  // returns the full detail including `formFields`.
  static const String templates = '/Templates';
  static const String templateCategories = '/Templates/categories';
  static String templateBySlug(String slug) => '/Templates/$slug';
  static String templateFields(int templateId) =>
      '/Templates/$templateId/fields';
  static String templatePreview(String slug) => '/Templates/$slug/preview';

  // Documents — there is deliberately no DELETE: the API does not expose one.
  static const String documents = '/Documents';
  static String documentById(int documentId) => '/Documents/$documentId';
  static String documentAnswers(int documentId) =>
      '/Documents/$documentId/answers';
  static String documentGenerate(int documentId) =>
      '/Documents/$documentId/generate';
  static String documentPdf(int documentId) =>
      '/Documents/$documentId/download/pdf';
  static String documentDocx(int documentId) =>
      '/Documents/$documentId/download/docx';

  // E-signature
  static String documentSignatures(int documentId) =>
      '/Documents/$documentId/signatures';
  static String documentSignatureOtp(int documentId) =>
      '/Documents/$documentId/signatures/request-otp';

  // AI assistant
  static const String aiAsk = '/Ai/ask';
  static const String aiQuickPrompts = '/Ai/quick-prompts';

  static const String health = '/Health';
}
