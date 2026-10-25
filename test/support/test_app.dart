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
    // The test database. A shell DB_NAME wins, like in CI.
    Env().load();
    Env().env['DB_NAME'] = 'your_qr_test';
    Env().env['LOG_REQUESTS'] = 'false';

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
    TestResponse html = await client.get('/login');
    version = RegExp(r'"version":"([^"]*)"').firstMatch(html.body)!.group(1)!;
  }

  /// The Inertia asset version. Empty with the dev server.
  String version = '';

  Browser browser() {
    return Browser(client, version);
  }

  Future<void> stop() async {
    await client.close();
    if (_madeHot) {
      await _hot.delete();
    }
  }
}

/// Keeps cookies between requests like a browser, and sends the
/// XSRF-TOKEN cookie back in the X-XSRF-TOKEN header (like the Inertia client).
class Browser {
  final DoxTestClient client;
  final Map<String, String> cookies = <String, String>{};

  /// The Inertia asset version, sent on every request.
  final String version;

  Browser(this.client, this.version);

  /// Headers of a request from the Inertia client.
  Map<String, String> inertiaHeaders() {
    return <String, String>{'X-Inertia': 'true', 'X-Inertia-Version': version};
  }

  Future<TestResponse> send(
    String method,
    String path, {
    Object? body,
    bool csrf = true,
  }) async {
    Map<String, String> headers = inertiaHeaders();
    if (cookies.isNotEmpty) {
      List<String> pairs = <String>[];
      for (MapEntry<String, String> c in cookies.entries) {
        pairs.add('${c.key}=${c.value}');
      }
      headers['Cookie'] = pairs.join('; ');
    }
    String? token = cookies['XSRF-TOKEN'];
    if (csrf && token != null) {
      headers['X-XSRF-TOKEN'] = Uri.decodeComponent(token);
    }
    TestResponse res = await client.send(
      method,
      path,
      body: body,
      headers: headers,
    );
    for (MapEntry<String, String> c in res.cookies.entries) {
      if (c.value.isEmpty) {
        cookies.remove(c.key);
      } else {
        cookies[c.key] = c.value;
      }
    }
    return res;
  }

  /// GET an Inertia page as JSON.
  Future<Map<String, dynamic>> page(String path) async {
    TestResponse res = await send('GET', path);
    if (res.status != 200) {
      throw StateError('GET $path gave ${res.status}: ${res.body}');
    }
    return res.json as Map<String, dynamic>;
  }
}
