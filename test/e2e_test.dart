import 'package:dox_core/testing.dart';
import 'package:qr/qr.dart';
import 'package:test/test.dart';
import 'package:your_qr/app/models/link/link.model.dart';
import 'package:your_qr/app/models/visit/visit.model.dart';
import 'package:your_qr/constants/app_constants.dart';

import 'support/test_app.dart';

/// End to end checks on a real server and the test database.
/// Tests run in order and share state (users, keys, links).
void main() {
  TestApp app = TestApp();
  late DoxTestClient client;
  late Browser ann;
  late Browser bob;
  late String annKey;
  late String bobKey;
  late Map<String, dynamic> apiLink;

  setUpAll(() async {
    await app.start();
    client = app.client;
    ann = app.browser();
    bob = app.browser();
  });

  tearDownAll(app.stop);

  DoxTestClient api(String key) {
    return client.withToken(key);
  }

  Map<String, dynamic> props(Map<String, dynamic> page) {
    return page['props'] as Map<String, dynamic>;
  }

  group('dashboard: sign up and login', () {
    test('a guest is sent to the login page', () async {
      TestResponse res = await ann.send('GET', '/links');
      res.expectStatus(302).expectHeader('location', '/login');
    });

    test('sign up: bad form goes back with errors', () async {
      await ann.page('/register');
      TestResponse res = await ann.send(
        'POST',
        '/register',
        body: <String, String>{
          'name': 'A',
          'email': 'not-an-email',
          'password': 'short',
          'password_confirmation': 'short',
        },
      );
      res.expectStatus(302);
      Map<String, dynamic> errors = props(
        await ann.page('/register'),
      )['errors'];
      expect(errors.keys, containsAll(<String>['name', 'email', 'password']));
    });

    test('sign up: passwords must match', () async {
      await ann.send(
        'POST',
        '/register',
        body: <String, String>{
          'name': 'Ann',
          'email': 'ann@example.com',
          'password': 'password123',
          'password_confirmation': 'password999',
        },
      );
      Map<String, dynamic> errors = props(
        await ann.page('/register'),
      )['errors'];
      expect(errors['password_confirmation'], 'The passwords do not match');
    });

    test('sign up logs in and opens the links page', () async {
      TestResponse res = await ann.send(
        'POST',
        '/register',
        body: <String, String>{
          'name': 'Ann',
          'email': 'ann@example.com',
          'password': 'password123',
          'password_confirmation': 'password123',
        },
      );
      res.expectStatus(302).expectHeader('location', '/links');

      Map<String, dynamic> page = await ann.page('/links');
      expect(page['component'], 'Links');
      expect(props(page)['auth']['user']['name'], 'Ann');
      expect(props(page)['links'], isEmpty);
      expect(page['flash'], <String, dynamic>{
        'message': 'Welcome to Your QR!',
      });
    });

    test('the same email can not sign up twice', () async {
      Browser other = app.browser();
      await other.page('/register');
      await other.send(
        'POST',
        '/register',
        body: <String, String>{
          'name': 'Ann 2',
          'email': 'ANN@example.com',
          'password': 'password123',
          'password_confirmation': 'password123',
        },
      );
      Map<String, dynamic> errors = props(
        await other.page('/register'),
      )['errors'];
      expect(errors['email'], 'The email has already been taken');
    });

    test('logout, wrong password, then login', () async {
      TestResponse res = await ann.send('POST', '/logout');
      res.expectStatus(302).expectHeader('location', '/login');
      (await ann.send('GET', '/links')).expectStatus(302);

      await ann.page('/login');
      res = await ann.send(
        'POST',
        '/login',
        body: <String, String>{
          'email': 'ann@example.com',
          'password': 'wrong-password',
        },
      );
      res.expectStatus(302);
      Map<String, dynamic> errors = props(await ann.page('/login'))['errors'];
      expect(errors['email'], 'Wrong email or password');

      res = await ann.send(
        'POST',
        '/login',
        body: <String, String>{
          'email': 'ann@example.com',
          'password': 'password123',
        },
      );
      res.expectStatus(302).expectHeader('location', '/links');
      expect((await ann.page('/links'))['component'], 'Links');
    });

    test('bob signs up too', () async {
      await bob.page('/register');
      TestResponse res = await bob.send(
        'POST',
        '/register',
        body: <String, String>{
          'name': 'Bob',
          'email': 'bob@example.com',
          'password': 'password123',
          'password_confirmation': 'password123',
        },
      );
      res.expectStatus(302).expectHeader('location', '/links');
    });
  });

  group('dashboard: links', () {
    test('a form post without the CSRF token gives 419', () async {
      TestResponse res = await ann.send(
        'POST',
        '/links',
        body: <String, String>{'url': 'https://dartondox.dev'},
        csrf: false,
      );
      res.expectStatus(419);
    });

    test('a bad link form goes back with errors', () async {
      TestResponse res = await ann.send(
        'POST',
        '/links',
        body: <String, String>{'url': 'not a url', 'code': 'a b'},
      );
      res.expectStatus(302);
      Map<String, dynamic> errors = props(await ann.page('/links'))['errors'];
      expect(errors['url'], 'The url must be a url');
      expect(errors['code'], 'The code format is invalid');
    });

    test('create a link with an Inertia POST', () async {
      TestResponse res = await ann.send(
        'POST',
        '/links',
        body: <String, dynamic>{
          'url': 'https://dartondox.dev',
          'code': 'dox-docs',
          'title': 'Dox docs',
        },
      );
      res.expectStatus(302).expectHeader('location', '/links');

      Map<String, dynamic> page = await ann.page('/links');
      expect(page['flash'], <String, dynamic>{
        'message': 'Short link dox-docs created',
      });
      List<dynamic> links = props(page)['links'];
      expect(links, hasLength(1));
      expect(links.first['code'], 'dox-docs');
      expect(links.first['short_url'], endsWith('/s/dox-docs'));
      expect(links.first['clicks'], 0);
      expect(links.first['scans'], 0);
    });

    test('edit a link with PUT (303 redirect)', () async {
      List<dynamic> links = props(await ann.page('/links'))['links'];
      TestResponse res = await ann.send(
        'PUT',
        '/links/${links.first['id']}',
        body: <String, dynamic>{
          'url': 'https://dartondox.dev/docs',
          'code': 'dox-docs',
          'title': null,
        },
      );
      res.expectStatus(303).expectHeader('location', '/links');
      links = props(await ann.page('/links'))['links'];
      expect(links.first['url'], 'https://dartondox.dev/docs');
      expect(links.first['title'], isNull);
    });

    test('bob can not see or change the link of ann', () async {
      List<dynamic> links = props(await ann.page('/links'))['links'];
      expect(props(await bob.page('/links'))['links'], isEmpty);
      TestResponse res = await bob.send(
        'GET',
        '/links/${links.first['id']}/stats',
      );
      res.expectStatus(404);
      res = await bob.send('DELETE', '/links/${links.first['id']}');
      res.expectStatus(404);
    });
  });

  group('dashboard: API keys', () {
    test('a new key is shown once', () async {
      await ann.page('/api-keys');
      TestResponse res = await ann.send(
        'POST',
        '/api-keys',
        body: <String, String>{'name': 'laptop'},
      );
      res.expectStatus(302).expectHeader('location', '/api-keys');

      Map<String, dynamic> page = await ann.page('/api-keys');
      annKey = page['flash']['api_key'] as String;
      expect(annKey, startsWith(AppConstants.apiKeyPrefix));
      List<dynamic> keys = props(page)['keys'];
      expect(keys.single['name'], 'laptop');
      expect(keys.single.containsKey('key_hash'), isFalse);
      expect(keys.single['last_used_at'], isNull);

      page = await ann.page('/api-keys');
      expect(page['flash'], isNull);
    });

    test('an empty name goes back with errors', () async {
      await ann.send('POST', '/api-keys', body: <String, String>{'name': ''});
      Map<String, dynamic> errors = props(
        await ann.page('/api-keys'),
      )['errors'];
      expect(errors['name'], 'The name is required');
    });

    test('bob makes a key too', () async {
      await bob.page('/api-keys');
      await bob.send('POST', '/api-keys', body: <String, String>{'name': 'b'});
      bobKey = (await bob.page('/api-keys'))['flash']['api_key'] as String;
    });
  });

  group('API: auth', () {
    test('no key gives 401', () async {
      (await client.get('/api/links')).expectStatus(401);
    });

    test('a wrong key gives 401', () async {
      (await api('yqr_wrong').get('/api/links')).expectStatus(401);
      TestResponse res = await client.get(
        '/api/links',
        headers: <String, String>{'Authorization': 'Basic abc'},
      );
      res.expectStatus(401);
    });

    test('a good key works and sets last_used_at', () async {
      (await api(annKey).get('/api/links')).expectStatus(200);
      List<dynamic> keys = props(await ann.page('/api-keys'))['keys'];
      expect(keys.single['last_used_at'], isNotNull);
    });

    test('the API needs no CSRF token and sets no session cookie', () async {
      TestResponse res = await api(annKey).post(
        '/api/links',
        body: <String, String>{'url': 'https://example.com/no-csrf'},
      );
      res.expectStatus(201);
      expect(res.cookies, isEmpty);
      await api(annKey).delete('/api/links/${res.json['id']}');
    });
  });

  group('API: links', () {
    test('create with a random code', () async {
      TestResponse res = await api(annKey).post(
        '/api/links',
        body: <String, String>{
          'url': 'https://example.com/a/long/page',
          'title': 'Example',
        },
      );
      res.expectStatus(201);
      apiLink = res.json as Map<String, dynamic>;
      expect(apiLink['code'], hasLength(AppConstants.codeLength));
      expect(apiLink['code'], matches(RegExp(r'^[A-Za-z0-9]+$')));
      expect(apiLink['short_url'], endsWith('/s/${apiLink['code']}'));
      expect(apiLink['qr_url'], endsWith('/q/${apiLink['code']}'));
    });

    test('a used custom code gives 422', () async {
      TestResponse res = await api(bobKey).post(
        '/api/links',
        body: <String, String>{'url': 'https://x.com', 'code': 'dox-docs'},
      );
      res.expectStatus(422).expectJson(<String, dynamic>{
        'code': 'The code has already been taken',
      });
    });

    test('bad input gives 422', () async {
      TestResponse res = await api(annKey).post(
        '/api/links',
        body: <String, String>{
          'url': 'ftp://x.com',
          'expires_at': '2000-01-01T00:00:00Z',
        },
      );
      res.expectStatus(422);
      expect((res.json as Map<String, dynamic>).keys, contains('url'));
    });

    test('list is paged and only has my links', () async {
      TestResponse res = await api(annKey).get('/api/links?per_page=1');
      res.expectStatus(200);
      expect(res.json['total'], 2);
      expect(res.json['per_page'], 1);
      expect(res.json['data'], hasLength(1));
      expect(res.json['data'].first['id'], apiLink['id']);

      res = await api(bobKey).get('/api/links');
      expect(res.json['total'], 0);
    });

    test('show, and someone else gets 404', () async {
      TestResponse res = await api(annKey).get('/api/links/${apiLink['id']}');
      res.expectStatus(200).expectJson(containsPair('title', 'Example'));
      (await api(bobKey).get('/api/links/${apiLink['id']}')).expectStatus(404);
    });

    test('PATCH changes only the keys sent', () async {
      TestResponse res = await api(annKey).patch(
        '/api/links/${apiLink['id']}',
        body: <String, String>{'title': 'New title'},
      );
      res.expectStatus(200);
      expect(res.json['title'], 'New title');
      expect(res.json['url'], 'https://example.com/a/long/page');
      expect(res.json['code'], apiLink['code']);

      res = await api(annKey).patch(
        '/api/links/${apiLink['id']}',
        body: <String, dynamic>{'title': null},
      );
      expect(res.json['title'], isNull);

      res = await api(bobKey).patch(
        '/api/links/${apiLink['id']}',
        body: <String, String>{'title': 'hacked'},
      );
      res.expectStatus(404);
    });

    test('PATCH can keep its own code', () async {
      TestResponse res = await api(annKey).patch(
        '/api/links/${apiLink['id']}',
        body: <String, String>{'code': apiLink['code'] as String},
      );
      res.expectStatus(200);
    });
  });

  group('short links', () {
    test('/s/{code} counts a click and redirects', () async {
      TestResponse res = await client.get(
        '/s/${apiLink['code']}',
        headers: <String, String>{
          'User-Agent': 'test-agent',
          'Referer': 'https://news.example',
        },
      );
      res.expectStatus(302);
      res.expectHeader('location', 'https://example.com/a/long/page');
      expect(res.cookies, isEmpty);
      await client.get('/s/${apiLink['code']}');
    });

    test('/q/{code} counts a scan and redirects', () async {
      TestResponse res = await client.get('/q/${apiLink['code']}');
      res.expectStatus(302);
      res.expectHeader('location', 'https://example.com/a/long/page');
    });

    test('the raw IP is never saved', () async {
      List<Visit> visits = await Visit().where('link_id', apiLink['id']).get();
      expect(visits, hasLength(3));
      Visit click = visits.firstWhere((Visit v) => v.userAgent == 'test-agent');
      expect(click.source, VisitSource.click);
      expect(click.referer, 'https://news.example');
      expect(click.ipHash, hasLength(64));
      expect(click.ipHash, isNot(contains('127.0.0.1')));
    });

    test('unknown code gives 404', () async {
      (await client.get('/s/nothing-here')).expectStatus(404);
      (await client.get('/q/nothing-here')).expectStatus(404);
    });

    test('expired link gives 404', () async {
      TestResponse res = await api(annKey).post(
        '/api/links',
        body: <String, String>{
          'url': 'https://example.com/old',
          'code': 'old-one',
          'expires_at': DateTime.now()
              .add(Duration(hours: 1))
              .toUtc()
              .toIso8601String(),
        },
      );
      res.expectStatus(201);
      (await client.get('/s/old-one')).expectStatus(302);

      await Link().where('code', 'old-one').update(<String, dynamic>{
        'expires_at': DateTime.now().subtract(Duration(minutes: 1)).toUtc(),
      });
      (await client.get('/s/old-one')).expectStatus(404);
      await api(annKey).delete('/api/links/${res.json['id']}');
    });

    test('the dashboard shows the counts', () async {
      List<dynamic> links = props(await ann.page('/links'))['links'];
      Map<String, dynamic> row = links.firstWhere(
        (dynamic l) => l['id'] == apiLink['id'],
      );
      expect(row['clicks'], 2);
      expect(row['scans'], 1);
    });
  });

  group('stats', () {
    test('API: clicks and scans per day plus totals', () async {
      TestResponse res = await api(annKey)
          .get('/api/links/${apiLink['id']}/stats?days=7');
      res.expectStatus(200);
      expect(res.json['days'], 7);
      expect(res.json['totals'], <String, dynamic>{'clicks': 2, 'scans': 1});
      List<dynamic> daily = res.json['daily'];
      expect(daily, hasLength(7));
      String today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
      expect(daily.last, <String, dynamic>{
        'date': today,
        'clicks': 2,
        'scans': 1,
      });
      expect(daily.first['clicks'], 0);
    });

    test('API: days out of range gives 422', () async {
      TestResponse res = await api(annKey)
          .get('/api/links/${apiLink['id']}/stats?days=0');
      res.expectStatus(422);
    });

    test('dashboard stats page', () async {
      Map<String, dynamic> page = await ann.page(
        '/links/${apiLink['id']}/stats',
      );
      expect(page['component'], 'LinkStats');
      expect(props(page)['stats']['totals'], <String, dynamic>{
        'clicks': 2,
        'scans': 1,
      });
      expect(props(page)['stats']['daily'], hasLength(30));
    });
  });

  group('QR code', () {
    test('API: SVG of a valid QR code for the /q/ URL', () async {
      TestResponse res = await api(annKey)
          .get('/api/links/${apiLink['id']}/qr.svg?size=300');
      res.expectStatus(200);
      res.expectHeader('content-type', startsWith('image/svg+xml'));
      expect(res.body, startsWith('<svg'));
      expect(res.body, contains('width="300" height="300"'));
      Set<String> modules = QrModules.fromSvg(res.body);
      expect(modules, QrModules.of(apiLink['qr_url']));
      // the top row of the top-left finder square is 7 dark modules
      for (int x = 4; x < 11; x++) {
        expect(modules, contains('$x,4'));
      }
    });

    test('API: a bad size gives 422', () async {
      TestResponse res = await api(annKey)
          .get('/api/links/${apiLink['id']}/qr.svg?size=5');
      res.expectStatus(422);
    });

    test('dashboard: download the SVG', () async {
      TestResponse res = await ann.send(
        'GET',
        '/links/${apiLink['id']}/qr.svg?download=1',
      );
      res.expectStatus(200);
      res.expectHeader('content-type', startsWith('image/svg+xml'));
      res.expectHeader(
        'content-disposition',
        'attachment; filename="qr-${apiLink['code']}.svg"',
      );
      expect(QrModules.fromSvg(res.body), QrModules.of(apiLink['qr_url']));
    });
  });

  group('delete', () {
    test('API: delete a link, then it is gone', () async {
      (await api(bobKey).delete('/api/links/${apiLink['id']}'))
          .expectStatus(404);
      TestResponse res = await api(annKey)
          .delete('/api/links/${apiLink['id']}');
      res.expectStatus(200);
      (await api(annKey).get('/api/links/${apiLink['id']}')).expectStatus(404);
      (await client.get('/s/${apiLink['code']}')).expectStatus(404);
    });

    test('dashboard: delete a link (303 redirect)', () async {
      List<dynamic> links = props(await ann.page('/links'))['links'];
      TestResponse res = await ann.send(
        'DELETE',
        '/links/${links.first['id']}',
      );
      res.expectStatus(303).expectHeader('location', '/links');
      expect(props(await ann.page('/links'))['links'], isEmpty);
    });

    test('dashboard: delete an API key, then it stops working', () async {
      List<dynamic> keys = props(await ann.page('/api-keys'))['keys'];
      TestResponse res = await ann.send(
        'DELETE',
        '/api-keys/${keys.single['id']}',
      );
      res.expectStatus(303);
      (await api(annKey).get('/api/links')).expectStatus(401);
    });
  });

  group('API docs', () {
    test('the docs page and the OpenAPI document work', () async {
      (await client.get('/docs')).expectStatus(200);
      TestResponse res = await client.get('/openapi.json');
      res.expectStatus(200);
      Map<String, dynamic> paths = res.json['paths'];
      expect(paths.keys, contains('/api/links/{id}/qr.svg'));
      expect(paths['/api/links']['post']['security'], isNotEmpty);
    });
  });
}

/// The dark modules of a QR code, as "x,y" texts (quiet zone included).
class QrModules {
  /// From the path that QrSvg draws: `M{x} {y}h1v1h-1z` per module.
  static Set<String> fromSvg(String svg) {
    Set<String> found = <String>{};
    for (RegExpMatch m in RegExp(r'M(\d+) (\d+)h1v1h-1z').allMatches(svg)) {
      found.add('${m.group(1)},${m.group(2)}');
    }
    return found;
  }

  /// What a QR code of [text] must look like.
  static Set<String> of(String text) {
    QrImage image = QrImage(QrCode(payload: QrPayload.fromString(text)));
    int quiet = AppConstants.qrQuietZone;
    Set<String> found = <String>{};
    for (int row = 0; row < image.moduleCount; row++) {
      for (int col = 0; col < image.moduleCount; col++) {
        if (image.isDark(row, col)) {
          found.add('${col + quiet},${row + quiet}');
        }
      }
    }
    return found;
  }
}
