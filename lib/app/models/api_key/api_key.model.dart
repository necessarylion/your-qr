import 'package:dox_orm/dox_orm.dart';

part 'api_key.model.g.dart';

/// One row in the `api_keys` table.
@DoxModel(table: 'api_keys')
class ApiKey extends ApiKeyGenerator {
  /// Never send the key hash in a response.
  @override
  List<String> get hidden => <String>['key_hash'];

  @Column()
  int? userId;

  @Column()
  String? name;

  @Column()
  String? keyHash;

  @Column()
  DateTime? lastUsedAt;
}
