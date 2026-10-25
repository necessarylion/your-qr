import 'package:dox_auth/dox_auth.dart' show UnAuthorizedException;
import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/models/user/user.model.dart';
import 'package:your_qr/app/services/api_key.service.dart';

/// The user of an API key, in the same shape that dox_auth uses,
/// so controllers can read `req.auth?.user<User>()`.
class ApiKeyAuth implements IAuth {
  final User _user;

  ApiKeyAuth(this._user);

  @override
  Future<void> verifyToken(IDoxRequest req) async {}

  @override
  bool isLoggedIn() {
    return true;
  }

  @override
  T? user<T>() {
    return _user as T;
  }

  @override
  Map<String, dynamic>? toJson() {
    return _user.toJson();
  }
}

/// Checks the header `Authorization: Bearer <api key>` on /api routes.
/// A missing or unknown key gives 401.
///
/// The name ends with `AuthMiddleware`, so the API docs show these routes
/// with a bearer token.
@Inject()
class ApiKeyAuthMiddleware implements IDoxMiddleware {
  final ApiKeyService keys;

  ApiKeyAuthMiddleware(this.keys);

  @override
  Future<IDoxRequest> handle(IDoxRequest req) async {
    String header = req.header('Authorization') ?? '';
    if (!header.startsWith('Bearer ')) {
      throw UnAuthorizedException(message: 'Missing API key');
    }
    User? user = await keys.userForKey(header.substring(7).trim());
    if (user == null) {
      throw UnAuthorizedException(message: 'Invalid API key');
    }
    req.merge(<String, dynamic>{AUTH_REQUEST_KEY: ApiKeyAuth(user)});
    return req;
  }
}
