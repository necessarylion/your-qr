import 'package:dox_auth/dox_auth.dart';
import 'package:your_qr/app/models/user/user.model.dart';

/// Makes a new User model for the auth package.
User makeAuthUser() {
  return User();
}

/// The dashboard logs in with a session (`web` guard).
/// The REST API uses API keys instead (see ApiKeyAuthMiddleware).
AuthConfig authConfig = AuthConfig(
  defaultGuard: 'web',
  guards: <String, AuthGuard>{
    'web': AuthGuard(
      driver: SessionAuthDriver(),
      provider: AuthProvider(model: makeAuthUser),
    ),
  },
);
