import 'package:dox_auth/dox_auth.dart';
import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/dtos/auth/auth.dto.dart';
import 'package:your_qr/app/models/user/user.model.dart';
import 'package:your_qr/app/repositories/user.repository.dart';

/// Sign up, login and logout for the dashboard (session login).
@Inject()
class AuthService {
  final UserRepository users;

  AuthService(this.users);

  /// Makes the user and logs them in. The DTO already checked that the
  /// email is free (@Unique).
  Future<User> register(DoxRequest req, RegisterUser input) async {
    String hash = await Hash.makeAsync(input.password);
    User user = await users.create(input.name, input.email, hash);
    Auth(guard: 'web').loginSession(req, user);
    return user;
  }

  /// Gives false for a wrong email or password.
  Future<bool> login(DoxRequest req, LoginUser input) async {
    return await Auth(guard: 'web').attemptSession(req, <String, dynamic>{
      'email': input.email,
      'password': input.password,
    });
  }

  void logout(DoxRequest req) {
    Auth(guard: 'web').logout(req);
  }

  /// The logged in user, or null. Works without AuthMiddleware.
  Future<User?> currentUser(DoxRequest req) async {
    Auth auth = Auth(guard: 'web');
    await auth.verifyToken(req);
    return auth.user<User>();
  }
}
