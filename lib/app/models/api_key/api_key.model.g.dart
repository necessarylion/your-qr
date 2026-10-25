// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_key.model.dart';

// **************************************************************************
// Generator: DoxModelBuilder
// **************************************************************************

// ignore_for_file: always_specify_types

class ApiKeyGenerator extends Model<ApiKey> {
  @override
  String get primaryKey => 'id';

  @override
  Map<String, dynamic> get timestampsColumn => const <String, dynamic>{
    'created_at': 'created_at',
    'updated_at': 'updated_at',
  };

  @override
  String get tableName => 'api_keys';

  int? get id => tempIdValue as int?;

  set id(int? val) => tempIdValue = val;

  ApiKey query() => ApiKey();

  @override
  bool get readsRowDates => true;

  @override
  List<String> get tableColumns => const <String>[
    'id',
    'user_id',
    'name',
    'key_hash',
    'last_used_at',
    'created_at',
    'updated_at',
  ];

  @override
  List<String> get preloadList => const <String>[];

  @override
  Map<String, Function> get relationsResultMatcher =>
      const <String, Function>{};

  @override
  Map<String, Function> get relationsQueryMatcher => const <String, Function>{};

  @override
  ApiKey fromMap(Map<String, dynamic> m) => ApiKey()
    ..id = m['id'] as int?
    ..userId = m['user_id'] as int?
    ..name = m['name'] as String?
    ..keyHash = m['key_hash'] as String?
    ..lastUsedAt = m['last_used_at'] is DateTime?
        ? m['last_used_at'] as DateTime?
        : DateTime.parse(m['last_used_at'] as String)
    ..createdAt = m['created_at'] is DateTime?
        ? m['created_at'] as DateTime?
        : DateTime.parse(m['created_at'] as String)
    ..updatedAt = m['updated_at'] is DateTime?
        ? m['updated_at'] as DateTime?
        : DateTime.parse(m['updated_at'] as String);
  @override
  Map<String, dynamic> columnsToMap() {
    ApiKey instance = this as ApiKey;
    Map<String, dynamic> map = <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'key_hash': instance.keyHash,
      'last_used_at': instance.lastUsedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

    return map;
  }

  @override
  Map<String, dynamic> convertToMap(dynamic i) {
    ApiKey instance = i as ApiKey;
    Map<String, dynamic> map = instance.columnsToMap();

    return map;
  }
}
