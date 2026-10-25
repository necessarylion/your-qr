import 'package:dox_auth/dox_auth.dart';
import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/models/user/user.model.dart';
import 'package:your_qr/app/services/api_key.service.dart';

/// Checks the header `Authorization: Bearer <api key>` on /api routes.
/// A missing or unknown key gives 401.
/// Controllers then read the key owner with `req.auth?.user<User>()`.
///
/// The API docs show these routes with a bearer "API key" scheme.
@Security.bearer(format: 'API key')
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
    Auth().setUser(req, user);
    return req;
  }
}
