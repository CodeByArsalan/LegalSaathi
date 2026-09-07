/// Machine-readable codes the API returns in the failure envelope's `message`
/// slot — the human-readable text always lives in `errors[0]` instead. Only the
/// codes the app actually branches on are listed here.
abstract final class ApiErrorCodes {
  const ApiErrorCodes._();

  /// Login refused because the account exists but its email is still
  /// unverified. The server has already re-sent the OTP as part of rejecting
  /// the login, so the app routes to the verification screen rather than
  /// showing a dead-end error.
  static const String emailNotVerified = 'EmailNotVerified';
}
