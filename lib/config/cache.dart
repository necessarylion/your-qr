import 'package:dox_core/dox_core.dart';
import 'package:your_qr/config/env.dart';

/// Cache stores. The login sessions live in the `redis` store
/// (see `session` in config/app.dart).
CacheConfig cache = CacheConfig(
  defaultStore: 'redis',
  stores: <String, Map<String, dynamic>>{
    'redis': <String, dynamic>{
      'driver': 'redis',
      'host': env.redisHost,
      'port': env.redisPort,
      'prefix': 'your_qr:',
    },
  },
);
