import 'package:dox_orm/dox_orm.dart';
import 'package:your_qr/config/env.dart';

/// Postgres only (native driver).
DatabaseConfig databaseConfig = DatabaseConfig(
  connection: 'postgres',
  connections: <String, ConnectionConfig>{
    'postgres': ConnectionConfig(
      driver: Driver.postgres,
      host: env.dbHost,
      port: env.dbPort,
      user: env.dbUsername,
      password: env.dbPassword,
      database: env.dbName,
      extra: <String, dynamic>{
        /// Each isolate has its own pool.
        'maxConnectionCount': 10,
        'maxConnectionAge': Duration(hours: 1),
      },
      debug: env.dbDebug,
      printer: PrettyQueryPrinter(),
    ),
  },
);
