// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// Generator: DoxEnvBuilder
// **************************************************************************

class _$AppEnv extends AppEnv {
  _$AppEnv._({
    required this.appName,
    required this.appEnv,
    required this.isDevelopment,
    required this.appPort,
    required this.appKey,
    required this.appTotalIsolate,
    required this.appUrl,
    required this.logLevel,
    required this.logRequests,
    required this.dbHost,
    required this.dbPort,
    required this.dbUsername,
    required this.dbPassword,
    required this.dbName,
    required this.dbDebug,
    required this.redisHost,
    required this.redisPort,
    required this.viteDevServer,
  });

  @override
  final String appName;
  @override
  final String appEnv;
  @override
  final bool isDevelopment;
  @override
  final int appPort;
  @override
  final String appKey;
  @override
  final int? appTotalIsolate;
  @override
  final String appUrl;
  @override
  final String logLevel;
  @override
  final bool logRequests;
  @override
  final String dbHost;
  @override
  final int dbPort;
  @override
  final String dbUsername;
  @override
  final String dbPassword;
  @override
  final String dbName;
  @override
  final bool dbDebug;
  @override
  final String redisHost;
  @override
  final int redisPort;
  @override
  final String? viteDevServer;

  /// reads and checks every key once. Throws `EnvException` with all
  /// missing or bad keys.
  static AppEnv load([EnvReader? reader]) {
    EnvReader r = reader ?? EnvReader();
    _$AppEnvDefaults d = _$AppEnvDefaults();
    String appName = r.string('APP_NAME') ?? d.appName;
    String appEnv = r.string('APP_ENV') ?? d.appEnv;
    bool isDevelopment = r.boolean('IS_DEVELOPMENT') ?? d.isDevelopment;
    int appPort = r.integer('APP_PORT') ?? d.appPort;
    String? appKey = r.string('APP_KEY');
    r.need('APP_KEY');
    int? appTotalIsolate = r.integer('APP_TOTAL_ISOLATE');
    String appUrl = r.string('APP_URL') ?? d.appUrl;
    String logLevel = r.string('LOG_LEVEL') ?? d.logLevel;
    bool logRequests = r.boolean('LOG_REQUESTS') ?? d.logRequests;
    String dbHost = r.string('DB_HOST') ?? d.dbHost;
    int dbPort = r.integer('DB_PORT') ?? d.dbPort;
    String dbUsername = r.string('DB_USERNAME') ?? d.dbUsername;
    String dbPassword = r.string('DB_PASSWORD') ?? d.dbPassword;
    String dbName = r.string('DB_NAME') ?? d.dbName;
    bool dbDebug = r.boolean('DB_DEBUG') ?? d.dbDebug;
    String redisHost = r.string('REDIS_HOST') ?? d.redisHost;
    int redisPort = r.integer('REDIS_PORT') ?? d.redisPort;
    String? viteDevServer = r.string('VITE_DEV_SERVER');

    r.check();
    return _$AppEnv._(
      appName: appName,
      appEnv: appEnv,
      isDevelopment: isDevelopment,
      appPort: appPort,
      appKey: appKey!,
      appTotalIsolate: appTotalIsolate,
      appUrl: appUrl,
      logLevel: logLevel,
      logRequests: logRequests,
      dbHost: dbHost,
      dbPort: dbPort,
      dbUsername: dbUsername,
      dbPassword: dbPassword,
      dbName: dbName,
      dbDebug: dbDebug,
      redisHost: redisHost,
      redisPort: redisPort,
      viteDevServer: viteDevServer,
    );
  }
}

/// gives the getter bodies of [AppEnv] (the defaults)
class _$AppEnvDefaults extends AppEnv {
  @override
  String get appKey => throw StateError('APP_KEY has no default');
  @override
  int? get appTotalIsolate =>
      throw StateError('APP_TOTAL_ISOLATE has no default');
  @override
  String? get viteDevServer =>
      throw StateError('VITE_DEV_SERVER has no default');
}
