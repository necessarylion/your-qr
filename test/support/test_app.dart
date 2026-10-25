import 'dart:io';

import 'package:dox_core/dox_core.dart';
import 'package:dox_core/testing.dart';
import 'package:dox_migration/dox_migration.dart';
import 'package:your_qr/config/app.dart';
import 'package:your_qr/config/database.dart';

import '../../db/migration/migrations.dart';

/// Starts the app on the test database, with empty tables.
class TestApp {
  late DoxTestClient client;

  /// The Vite dev server url in public/hot, so pages need no `npm run build`.
  final File _hot = File('public/hot');
  bool _madeHot = false;

  Future<void> start() async {
    // Under `dart test`, Dox reads .env.testing on top of .env
    // (the test database). A shell DB_NAME wins, like in CI.
    Env().load();

    Migrator migrator = Migrator(
      migrations: migrations,
      config: databaseConfig.getConnectionConfig(),
    );
    await migrator.reset();
    await migrator.migrate();

    if (!await _hot.exists()) {
      await _hot.parent.create(recursive: true);
      await _hot.writeAsString('http://localhost:5173');
      _madeHot = true;
    }
    client = await DoxTestClient.start(appConfig);

    // The asset version is in the page data of a first (HTML) visit.
    // It is null with the dev server (no build).
    TestResponse html = await client.get('/login');
    version =
        RegExp(r'"version":"([^"]*)"').firstMatch(html.body)?.group(1) ?? '';
  }

  /// The Inertia asset version. Empty with the dev server.
  String version = '';

  /// A new browser: keeps cookies, sends the CSRF token and the
  /// Inertia headers on every request.
  DoxTestClient browser() {
    return client.withSession().withHeaders(inertiaHeaders());
  }

  /// Headers of a request from the Inertia client.
  Map<String, String> inertiaHeaders() {
    return <String, String>{'X-Inertia': 'true', 'X-Inertia-Version': version};
  }

  Future<void> stop() async {
    await client.close();
    if (_madeHot) {
      await _hot.delete();
    }
  }
}

/// GET an Inertia page as JSON.
Future<Map<String, dynamic>> inertiaPage(
  DoxTestClient browser,
  String path,
) async {
  TestResponse res = await browser.get(path);
  if (res.status != 200) {
    throw StateError('GET $path gave ${res.status}: ${res.body}');
  }
  return res.json as Map<String, dynamic>;
}
