import 'package:dox_auth/dox_auth.dart';
import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/http/controllers/api_key_page.controller.dart';
import 'package:your_qr/app/http/controllers/auth_page.controller.dart';
import 'package:your_qr/app/http/controllers/link_page.controller.dart';
import 'package:your_qr/app/http/middleware/inertia.middleware.dart';

/// The dashboard (Inertia + React pages). Session and CSRF only here.
class WebRouter extends Router {
  final HandleInertiaRequests inertia;

  WebRouter(this.inertia);

  @override
  List<dynamic> get middleware => <dynamic>[
    const SessionMiddleware(),
    const CsrfMiddleware(),
    inertia,
  ];

  @override
  void register() {
    Route.get('/', (AuthPageController c) => c.home);
    Route.get('/register', (AuthPageController c) => c.registerPage);
    Route.post('/register', (AuthPageController c) => c.register);
    Route.get('/login', (AuthPageController c) => c.loginPage);
    Route.post('/login', (AuthPageController c) => c.login);
    Route.post('/logout', (AuthPageController c) => c.logout);

    Route.middleware(<dynamic>[
      AuthMiddleware(guard: 'web', redirectTo: '/login'),
    ], registerDashboard);
  }

  /// Pages that need a login. A guest goes to /login.
  void registerDashboard() {
    Route.get('/links', (LinkPageController c) => c.index);
    Route.post('/links', (LinkPageController c) => c.store);
    Route.put('/links/{id}', (LinkPageController c) => c.update);
    Route.delete('/links/{id}', (LinkPageController c) => c.destroy);
    Route.get('/links/{id}/stats', (LinkPageController c) => c.dailyStats);
    Route.get('/links/{id}/qr.svg', (LinkPageController c) => c.qrSvg);

    Route.get('/api-keys', (ApiKeyPageController c) => c.index);
    Route.post('/api-keys', (ApiKeyPageController c) => c.store);
    Route.delete('/api-keys/{id}', (ApiKeyPageController c) => c.destroy);
  }
}
