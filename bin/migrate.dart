import 'dart:io';

import 'package:dox_migration/dox_migration.dart';
import 'package:your_qr/config/database.dart';

import '../db/migration/migrations.dart';

/// run the migrations of db/migration:
/// `dart run bin/migrate.dart <run|rollback [--step=n]|reset|refresh|status>`.
/// `dox migration:*` commands run this file.
/// The database is from config/database.dart (DB_HOST, DB_PORT, DB_NAME, ...).
Future<void> main(List<String> args) async {
  exitCode = await Migrator(
    migrations: migrations,
    config: databaseConfig.getConnectionConfig(),
  ).run(args);
}
