// ignore_for_file: file_names
import 'package:dox_migration/dox_migration.dart';

/// API keys of a user. Only a hash of each key is saved.
class CreateApiKeysTable extends Migration {
  @override
  Future<void> up(Schema schema) async {
    await schema.create('api_keys', (Table table) {
      table.id();
      table.foreignId('user_id').constrained().cascadeOnDelete();
      table.string('name');

      /// sha256 of the key. The plain key is shown once and never saved.
      table.string('key_hash', 64).unique();
      table.timestampTz('last_used_at').nullable();
      table.timestamps();
    });
  }

  @override
  Future<void> down(Schema schema) async {
    await schema.dropIfExists('api_keys');
  }
}
