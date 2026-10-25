import 'package:dox_core/dox_core.dart';
import 'package:your_qr/generated/openapi.g.dart';

/// API docs at /docs (Scalar), /openapi.json and /openapi.yaml.
/// On when APP_ENV is development or local.
/// ApiKeyAuthMiddleware ends with `AuthMiddleware`,
/// so the API routes get the `bearerAuth` scheme by themselves.
OpenApiConfig openApi = OpenApiConfig(
  info: const Info(title: 'Your QR API', version: '1.0.0'),
  registry: openApiRegistry,
);
