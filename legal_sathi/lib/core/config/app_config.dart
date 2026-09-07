/// Compile-time configuration. Everything here arrives through `--dart-define`.
final class AppConfig {
  const AppConfig._();

  static const String appName = 'Legal Sathi';

  static const String env = String.fromEnvironment('ENV', defaultValue: 'dev');

  /// Hosted ASP.NET Core API. It is HTTP-only — `https://legalsaathi.runasp.net`
  /// does not terminate TLS — which is why the Android network security config
  /// and the iOS/macOS ATS exception domains allow cleartext for this host.
  /// Override with `-dart-define=BASE_URL=http://localhost:5000/api` to run
  /// against a locally hosted copy.
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://legalsaathi.runasp.net/api',
  );

  /// Runs the app on the bundled mock data instead of the live API. Every
  /// feature except payments has a real REST source, so this is off by default
  /// and exists for demos and for working without a reachable server.
  static const bool useMockApi = bool.fromEnvironment(
    'USE_MOCK_API',
    defaultValue: false,
  );

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration mockLatency = Duration(milliseconds: 350);

  /// Seeded in `assets/mock/users.json`; shown as a hint on the login screen
  /// while the app runs on mock data.
  static const String demoEmail = 'demo@legalsathi.pk';
  static const String demoPassword = 'demo1234';
  static const String demoOtp = '123456';
}
