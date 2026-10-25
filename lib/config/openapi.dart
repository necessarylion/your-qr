import 'package:dox_core/dox_core.dart';
import 'package:your_qr/generated/openapi.g.dart';

/// API docs at /docs (Scalar), /openapi.json and /openapi.yaml.
/// On only when APP_ENV is development. Off in production.
/// ApiKeyAuthMiddleware has `@Security.bearer(format: 'API key')`,
/// so the API routes show that scheme.
OpenApiConfig openApi = OpenApiConfig(
  info: const Info(title: 'Your QR API', version: '1.0.0'),
  registry: openApiRegistry,
);
