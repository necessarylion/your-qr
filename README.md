# Your QR

Your QR is a short link and QR code service, built with [Dox](https://dartondox.dev).

- Make a short link for any long URL: `https://your.host/s/abc1234`.
- Every link has a QR code. The QR code opens `https://your.host/q/abc1234`,
  so you can see how many people clicked and how many scanned.
- See clicks and scans per day.
- Use the dashboard in the browser, or the REST API with an API key.

## What is inside

- **Dox** (Dart) on the native HTTP server, with Postgres and Redis.
- **Dashboard**: Inertia + React + Vite (`resources/js`). Login with a session.
- **REST API** under `/api`, with an API key. Docs at `/docs` in development.
- Layers: route -> controller -> service -> repository -> model.

```
lib/
  routes/          public.dart (/s, /q, /build), web.dart (dashboard), api.dart
  app/http/        controllers, dtos (input checks), middleware, serializers
  app/services/    business logic (links, visits, stats, API keys, auth)
  app/repositories all database access
  app/models/      one model per table
  app/support/     small helpers: QR SVG, random codes, hashes, short URLs
  config/          all config      constants/  all global constants
db/migration/      the tables (Dart migrations)
resources/         React pages, CSS and the root HTML page
test/              end to end tests
```

## Run in development

You need Dart 3.13+, Node 24+ and Docker.

```bash
cp .env.example .env              # then set APP_KEY (`dox key:generate`)
docker compose up -d postgres redis
dart pub get
npm install

npm run dev                       # Vite dev server, keep it running
VITE_DEV_SERVER=http://localhost:5173 dox s
```

Open http://localhost:3000, sign up, and make your first link.
The server runs new migrations when it starts.

Without `npm run dev`, run `npm run build` once. The server then uses `public/build`.

## API

Make an API key on the "API keys" page. The key is shown once.
Send it in the `Authorization` header. A missing or wrong key gives `401`.

```bash
KEY=yqr_your_key_here
BASE=http://localhost:3000

# create a link (leave out "code" for a random one)
curl -X POST $BASE/api/links -H "Authorization: Bearer $KEY" \
  -H 'Content-Type: application/json' \
  -d '{"url": "https://dartondox.dev", "code": "dox", "title": "Dox"}'

# list your links (paged)
curl "$BASE/api/links?page=1&per_page=20" -H "Authorization: Bearer $KEY"

# one link, change it, delete it
curl $BASE/api/links/1 -H "Authorization: Bearer $KEY"
curl -X PATCH $BASE/api/links/1 -H "Authorization: Bearer $KEY" \
  -H 'Content-Type: application/json' -d '{"title": "New title"}'
curl -X DELETE $BASE/api/links/1 -H "Authorization: Bearer $KEY"

# the QR code as SVG (size 64 to 2048, default 256)
curl "$BASE/api/links/1/qr.svg?size=512" -H "Authorization: Bearer $KEY" -o qr.svg

# clicks and scans per day (days 1 to 365, default 30)
curl "$BASE/api/links/1/stats?days=7" -H "Authorization: Bearer $KEY"
```

The short links themselves need no key: `GET /s/{code}` (click) and
`GET /q/{code}` (scan) redirect to the long URL. An unknown or expired code gives `404`.

The base URL of the short links comes from `APP_URL`.

## Tests

The tests use the `your_qr_test` database. `docker compose up` makes it.

```bash
dart test
```

Before a commit: `dart format .` and `dart analyze --fatal-infos`.

## Build

```bash
npm run build      # the dashboard into public/build
dox build          # the AOT server binary into build/bundle
```

Never run production with `dart run` or `dox s`. They use the JIT, which needs much more memory.

## Docker

The image is on GitHub Packages, for `linux/amd64` and `linux/arm64`:

```bash
docker pull ghcr.io/necessarylion/your-qr:latest

docker run -p 3000:3000 \
  -e APP_ENV=production \
  -e APP_KEY=your-32-character-secret-key... \
  -e APP_URL=https://your.host \
  -e DB_HOST=db.host -e DB_PORT=5432 -e DB_NAME=your_qr \
  -e DB_USERNAME=postgres -e DB_PASSWORD=secret \
  -e REDIS_HOST=redis.host -e REDIS_PORT=6379 \
  ghcr.io/necessarylion/your-qr:latest
```

| Env | Needed | What it is |
| --- | --- | --- |
| `APP_KEY` | yes | secret key for cookies and IP hashes. Changing it logs everyone out. |
| `APP_URL` | yes | public base URL of the short links |
| `APP_ENV` | no | `production` turns off the API docs. Default `development`. |
| `APP_PORT` | no | default `3000` |
| `APP_TOTAL_ISOLATE` | no | server threads. Default: one per CPU core. |
| `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USERNAME`, `DB_PASSWORD` | yes | Postgres |
| `REDIS_HOST`, `REDIS_PORT` | yes | Redis (login sessions) |

Tags: `latest` and `1.2.3` come from git tags `v1.2.3`. `main` and `sha-<short>` come from the main branch.

Build it yourself, or run the app with Postgres and Redis:

```bash
docker build -t your-qr .
docker compose up -d --build
```

## Not done yet

- Visits are saved with one insert before the redirect. Under heavy
  traffic, move this to a queue job.
- The dashboard links page has no paging (the API has).
- Behind a proxy, set `trustedProxies` in `config/app.dart`, so the visitor
  IP (hashed) is the real one.
