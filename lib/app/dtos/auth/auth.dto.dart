import 'package:dox_core/dox_core.dart';
import 'package:dox_orm/dox_orm.dart' hide Schema;

part 'auth.dto.g.dart';

/// The dashboard sign up form.
@Dto()
class RegisterUser {
  @Trim()
  @Length(min: 2, max: 100)
  final String name;

  @Trim()
  @Lowercase()
  @Email()
  @MaxLength(255)
  @Unique('users', column: 'email')
  final String email;

  @Length(min: 8, max: 100)
  final String password;

  /// Must be the same as `password`.
  final String passwordConfirmation;

  const RegisterUser({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  /// Runs after every field rule passed.
  void validate(DtoErrors errors) {
    if (password != passwordConfirmation) {
      errors.add('password_confirmation', 'The passwords do not match');
    }
  }

  static const DtoSchema<RegisterUser> schema = $RegisterUserDto;
}

/// The dashboard login form.
@Dto()
class LoginUser {
  @Trim()
  @Lowercase()
  @Email()
  final String email;

  final String password;

  const LoginUser({required this.email, required this.password});

  static const DtoSchema<LoginUser> schema = $LoginUserDto;
}

/// The dashboard "new API key" form.
@Dto()
class CreateApiKey {
  /// A name to remember where the key is used, like "my laptop".
  @Trim()
  @Length(min: 1, max: 100)
  final String name;

  const CreateApiKey({required this.name});

  static const DtoSchema<CreateApiKey> schema = $CreateApiKeyDto;
}
