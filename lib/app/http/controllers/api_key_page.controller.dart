import 'package:dox_core/dox_core.dart';
import 'package:dox_inertia/dox_inertia.dart';
import 'package:your_qr/app/http/dtos/auth.dto.dart';
import 'package:your_qr/app/models/user/user.model.dart';
import 'package:your_qr/app/services/api_key.service.dart';

/// The dashboard page for API keys. Needs the session login.
/// Not part of the API docs.
@ApiIgnore()
@Inject()
class ApiKeyPageController {
  final ApiKeyService keys;

  ApiKeyPageController(this.keys);

  /// GET /api-keys
  Future<DoxResponse> index(DoxRequest req) async {
    return inertia(req, 'ApiKeys', <String, dynamic>{
      'keys': await keys.listForUser(_userId(req)),
    });
  }

  /// POST /api-keys. The plain key is sent once, in the flash data.
  Future<DoxResponse> store(DoxRequest req, CreateApiKey body) async {
    NewApiKey created = await keys.create(_userId(req), body.name);
    Inertia.flash(req, 'api_key', created.plainKey);
    Inertia.flash(req, 'message', 'API key "${body.name}" created');
    return redirect('/api-keys');
  }

  /// DELETE /api-keys/{id}
  Future<DoxResponse> destroy(DoxRequest req, int id) async {
    await keys.delete(_userId(req), id);
    Inertia.flash(req, 'message', 'API key deleted');
    return redirect('/api-keys');
  }

  int _userId(DoxRequest req) {
    return req.auth!.user<User>()!.id!;
  }
}
