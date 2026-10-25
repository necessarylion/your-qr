import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/http/controllers/link_api.controller.dart';
import 'package:your_qr/app/http/middleware/api_key_auth.middleware.dart';

/// The REST API. All routes start with /api and need
/// `Authorization: Bearer <api key>`. No session, no CSRF.
class ApiRouter extends Router {
  final ApiKeyAuthMiddleware apiKeyAuth;

  ApiRouter(this.apiKeyAuth);

  @override
  String get prefix => 'api';

  @override
  List<dynamic> get middleware => <dynamic>[apiKeyAuth];

  @override
  void register() {
    Route.get('/links', (LinkApiController c) => c.index);
    Route.post('/links', (LinkApiController c) => c.store);
    Route.get('/links/{id}', (LinkApiController c) => c.show);
    Route.patch('/links/{id}', (LinkApiController c) => c.update);
    Route.delete('/links/{id}', (LinkApiController c) => c.destroy);
    Route.get('/links/{id}/qr.svg', (LinkApiController c) => c.qrSvg);
    Route.get('/links/{id}/stats', (LinkApiController c) => c.dailyStats);
  }
}
