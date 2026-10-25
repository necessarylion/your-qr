import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/models/api_key/api_key.model.dart';

/// All database access for API keys.
@Inject()
class ApiKeyRepository {
  Future<ApiKey> create(int userId, String name, String keyHash) async {
    ApiKey key = ApiKey()
      ..userId = userId
      ..name = name
      ..keyHash = keyHash;
    await key.save();
    return key;
  }

  Future<ApiKey?> findByHash(String keyHash) async {
    return await ApiKey().where('key_hash', keyHash).getFirst();
  }

  /// Newest first.
  Future<List<ApiKey>> listForUser(int userId) async {
    return await ApiKey().where('user_id', userId).orderBy('id', 'desc').get();
  }

  Future<void> touch(int id, DateTime time) async {
    await ApiKey().where('id', id).update(<String, dynamic>{
      'last_used_at': time.toUtc(),
    });
  }

  /// Gives false when the key does not exist or belongs to someone else.
  Future<bool> deleteForUser(int userId, int id) async {
    ApiKey? key = await ApiKey()
        .where('id', id)
        .where('user_id', userId)
        .getFirst();
    if (key == null) {
      return false;
    }
    await ApiKey().where('id', id).delete();
    return true;
  }
}
