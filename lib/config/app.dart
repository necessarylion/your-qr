import 'dart:io';

import 'package:dox_core/dox_core.dart';
import 'package:your_qr/config/cache.dart';
import 'package:your_qr/config/cors.dart';
import 'package:your_qr/config/env.dart';
import 'package:your_qr/config/logger.dart';
import 'package:your_qr/config/openapi.dart';
import 'package:your_qr/generated/container.g.dart';
import 'package:your_qr/generated/dtos.g.dart';

AppConfig appConfig = AppConfig(
  /// Encrypts cookies. Keep `APP_KEY` secret.
  /// Changing it logs everyone out.
  appKey: env.appKey,

  serverPort: env.appPort,

  /// Isolates that serve http requests, all on the same port.
  /// Default is one per CPU core. Set `APP_TOTAL_ISOLATE` to change it.
  totalIsolate: env.appTotalIsolate ?? Platform.numberOfProcessors,

  /// Every @Dto class, from lib/generated/dtos.g.dart.
  dtos: dtos,

  /// Runs on every route. Session and CSRF are only on the dashboard
  /// routes (see lib/routes/web.dart), not on /api or the short links.
  globalMiddleware: <dynamic>[LogMiddleware(enabled: env.logRequests)],

  /// Every @Inject class, router and service of the app.
  container: registerContainer,

  cache: cache,
  cors: cors,
  logger: logger,
  openApi: openApi,

  /// Sessions live in Redis, so a logout really ends the old session.
  session: SessionConfig(driver: 'cache', store: 'redis'),
);
