import 'package:dox_core/dox_core.dart';
import 'package:dox_inertia/dox_inertia.dart';
import 'package:your_qr/app/dtos/auth/auth.dto.dart';
import 'package:your_qr/app/services/auth.service.dart';

/// Dashboard sign up, login and logout (session login, `web` guard).
/// Not part of the API docs.
@ApiIgnore()
@Inject()
class AuthPageController {
  final AuthService auth;

  AuthPageController(this.auth);

  /// GET /. Logged in: the links page. Else the login page.
  Future<DoxResponse> home(DoxRequest req) async {
    bool loggedIn = await auth.currentUser(req) != null;
    return redirect(loggedIn ? '/links' : '/login');
  }

  /// GET /register
  Future<DoxResponse> registerPage(DoxRequest req) {
    return inertia(req, 'Register', <String, dynamic>{});
  }

  /// POST /register. A bad form goes back with `errors`.
  Future<DoxResponse> register(DoxRequest req, RegisterUser body) async {
    await auth.register(req, body);
    Inertia.flash(req, 'message', 'Welcome to Your QR!');
    return redirect('/links');
  }

  /// GET /login
  Future<DoxResponse> loginPage(DoxRequest req) {
    return inertia(req, 'Login', <String, dynamic>{});
  }

  /// POST /login. A wrong password goes back with `errors.email`.
  Future<DoxResponse> login(DoxRequest req, LoginUser body) async {
    if (!await auth.login(req, body)) {
      req.session.flashErrors(
        <String, String>{'email': 'Wrong email or password'},
        input: <String, dynamic>{'email': body.email},
      );
      return back(req, fallback: '/login');
    }
    return redirect('/links');
  }

  /// POST /logout
  DoxResponse logout(DoxRequest req) {
    auth.logout(req);
    return redirect('/login');
  }
}
