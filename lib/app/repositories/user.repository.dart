import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/models/user/user.model.dart';

/// All database access for users.
@Inject()
class UserRepository {
  /// [passwordHash] must already be hashed.
  Future<User> create(String name, String email, String passwordHash) async {
    User user = User()
      ..name = name
      ..email = email
      ..password = passwordHash;
    await user.save();
    return user;
  }

  Future<User?> find(int id) async {
    return await User().find(id);
  }
}
