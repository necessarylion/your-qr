// ignore_for_file: file_names
import 'package:dox_migration/dox_migration.dart';

/// One row per click or scan of a link.
class CreateVisitsTable extends Migration {
  @override
  Future<void> up(Schema schema) async {
    await schema.create('visits', (Table table) {
      table.id();
      table.foreignId('link_id').constrained().cascadeOnDelete();

      /// click (/s/{code}) or scan (/q/{code})
      table.string('source', 10);

      /// sha256 of the IP, so the raw IP is never saved
      table.string('ip_hash', 64).nullable();
      table.text('user_agent').nullable();
      table.text('referer').nullable();
      table.timestampTz('created_at').nullable();
      table.index(<String>['link_id', 'created_at']);
    });
  }

  @override
  Future<void> down(Schema schema) async {
    await schema.dropIfExists('visits');
  }
}
