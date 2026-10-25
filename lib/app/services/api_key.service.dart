import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/models/api_key/api_key.model.dart';
import 'package:your_qr/app/models/user/user.model.dart';
import 'package:your_qr/app/repositories/api_key.repository.dart';
import 'package:your_qr/app/repositories/user.repository.dart';
import 'package:your_qr/app/support/hasher.dart';
import 'package:your_qr/app/support/random_code.dart';

/// A new API key. [plainKey] is shown to the user once, then it is gone.
class NewApiKey {
  final ApiKey apiKey;
  final String plainKey;

  NewApiKey(this.apiKey, this.plainKey);
}

/// API key logic. Only a hash of each key is saved.
@Inject()
class ApiKeyService {
  final ApiKeyRepository keys;
  final UserRepository users;
  final Hasher hasher;
  final RandomCode random;

  ApiKeyService(this.keys, this.users, this.hasher, this.random);

  Future<NewApiKey> create(int userId, String name) async {
    String plain = random.apiKey();
    ApiKey key = await keys.create(userId, name, hasher.sha256Hex(plain));
    return NewApiKey(key, plain);
  }

  Future<List<ApiKey>> listForUser(int userId) async {
    return await keys.listForUser(userId);
  }

  Future<void> delete(int userId, int id) async {
    if (!await keys.deleteForUser(userId, id)) {
      throw NotFoundHttpException(message: 'API key not found');
    }
  }

  /// The owner of [plainKey], or null when the key is unknown.
  /// Also saves the time of this use in `last_used_at`.
  Future<User?> userForKey(String plainKey) async {
    ApiKey? key = await keys.findByHash(hasher.sha256Hex(plainKey));
    if (key == null) {
      return null;
    }
    // ponytail: one UPDATE per API call. Write it at most once a minute
    // if API traffic gets heavy.
    await keys.touch(key.id!, DateTime.now());
    return await users.find(key.userId!);
  }
}
