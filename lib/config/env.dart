import 'package:dox_core/dox_core.dart';

part 'env.g.dart';

/// The env of the app, typed.
/// -------------------------------
/// Each getter reads one key: `appName` reads `APP_NAME`.
/// A getter body is the default. A nullable getter is optional.
/// Other getters are required: the app stops at startup when one is missing.
/// A shell variable wins over the `.env` file.
/// Run `dart run build_runner build` after you change this class.
@DoxEnv()
abstract class AppEnv {
  /// reads and checks every key once
  static AppEnv load([EnvReader? reader]) {
    return _$AppEnv.load(reader);
  }

  String get appName => 'Your QR';

  /// development, staging or production
  String get appEnv => 'development';

  bool get isDevelopment => appEnv == 'development';

  int get appPort => 3000;

  /// required: used to encrypt cookies and to hash visitor IPs
  String get appKey;

  /// isolates (threads) of the HTTP server. Null: one per CPU core.
  int? get appTotalIsolate;

  /// The public base URL of the short links, like https://yourqr.link.
  /// Short links are `{APP_URL}/s/{code}`, QR codes point to `{APP_URL}/q/{code}`.
  String get appUrl => 'http://localhost:3000';

  String get logLevel => 'info';

  /// one log line per request
  bool get logRequests => true;

  String get dbHost => 'localhost';

  int get dbPort => 5432;

  String get dbUsername => 'postgres';

  String get dbPassword => 'postgres';

  String get dbName => 'your_qr';

  /// Print every SQL query. Slow, so only for debugging.
  bool get dbDebug => false;

  /// Redis keeps the login sessions.
  String get redisHost => 'localhost';

  int get redisPort => 6379;

  /// The Vite dev server, like http://localhost:5173, while `npm run dev` runs.
  /// Empty means the built files in public/build.
  String? get viteDevServer;
}

/// The env of the app. Read and checked once, on first use.
final AppEnv env = AppEnv.load();
