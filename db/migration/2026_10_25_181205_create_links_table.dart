// ignore_for_file: file_names
import 'package:dox_migration/dox_migration.dart';

/// Short links. `code` is the part after /s/ and /q/.
class CreateLinksTable extends Migration {
  @override
  Future<void> up(Schema schema) async {
    await schema.create('links', (Table table) {
      table.id();
      table.foreignId('user_id').constrained().cascadeOnDelete();
      table.string('code', 64).unique();
      table.text('url');
      table.string('title').nullable();
      table.timestampTz('expires_at').nullable();
      table.timestamps();
    });
  }

  @override
  Future<void> down(Schema schema) async {
    await schema.dropIfExists('links');
  }
}
