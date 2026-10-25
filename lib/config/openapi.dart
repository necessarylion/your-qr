import 'package:dox_core/dox_core.dart';
import 'package:your_qr/config/env.dart';
import 'package:your_qr/generated/openapi.g.dart';

/// API docs at /docs (Scalar), /openapi.json and /openapi.yaml.
/// On only in development (APP_ENV, default development).
/// ApiKeyAuthMiddleware ends with `AuthMiddleware`,
/// so the API routes get the `bearerAuth` scheme by themselves.
OpenApiConfig openApi = OpenApiConfig(
  enabled: env.isDevelopment,
  info: const Info(title: 'Your QR API', version: '1.0.0'),
  registry: openApiRegistry,
);
