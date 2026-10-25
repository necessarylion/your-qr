// Made by `dox make:migration` and the `dox migration:*` commands.
// Do not edit, it is made again from the files in this folder.
import 'package:dox_migration/dox_migration.dart';

import '2023_07_16_131937700_create_users_table.dart' as m1;
import '2026_10_25_181205_create_api_keys_table.dart' as m2;
import '2026_10_25_181205_create_links_table.dart' as m3;
import '2026_10_25_181205_create_visits_table.dart' as m4;

/// all Dart migrations of db/migration, sorted by name
final List<MigrationEntry> migrations = <MigrationEntry>[
  MigrationEntry(
    '2023_07_16_131937700_create_users_table',
    m1.CreateUsersTable(),
  ),
  MigrationEntry(
    '2026_10_25_181205_create_api_keys_table',
    m2.CreateApiKeysTable(),
  ),
  MigrationEntry('2026_10_25_181205_create_links_table', m3.CreateLinksTable()),
  MigrationEntry(
    '2026_10_25_181205_create_visits_table',
    m4.CreateVisitsTable(),
  ),
];
