import 'package:dox_orm/dox_orm.dart';

part 'user.model.g.dart';

/// One row in the `users` table.
@DoxModel(table: 'users')
class User extends UserGenerator {
  /// Never send the password hash in a response.
  @override
  List<String> get hidden => <String>['password'];

  @Column()
  String? name;

  @Column()
  String? email;

  @Column()
  String? password;
}
