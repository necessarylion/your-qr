// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.model.dart';

// **************************************************************************
// Generator: DoxModelBuilder
// **************************************************************************

// ignore_for_file: always_specify_types

class LinkGenerator extends Model<Link> {
  @override
  String get primaryKey => 'id';

  @override
  Map<String, dynamic> get timestampsColumn => const <String, dynamic>{
    'created_at': 'created_at',
    'updated_at': 'updated_at',
  };

  @override
  String get tableName => 'links';

  int? get id => tempIdValue as int?;

  set id(int? val) => tempIdValue = val;

  Link query() => Link();

  @override
  bool get readsRowDates => true;

  @override
  List<String> get tableColumns => const <String>[
    'id',
    'user_id',
    'code',
    'url',
    'title',
    'expires_at',
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
  Link fromMap(Map<String, dynamic> m) => Link()
    ..id = m['id'] as int?
    ..userId = m['user_id'] as int?
    ..code = m['code'] as String?
    ..url = m['url'] as String?
    ..title = m['title'] as String?
    ..expiresAt = m['expires_at'] is DateTime?
        ? m['expires_at'] as DateTime?
        : DateTime.parse(m['expires_at'] as String)
    ..createdAt = m['created_at'] is DateTime?
        ? m['created_at'] as DateTime?
        : DateTime.parse(m['created_at'] as String)
    ..updatedAt = m['updated_at'] is DateTime?
        ? m['updated_at'] as DateTime?
        : DateTime.parse(m['updated_at'] as String);
  @override
  Map<String, dynamic> columnsToMap() {
    Link instance = this as Link;
    Map<String, dynamic> map = <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'code': instance.code,
      'url': instance.url,
      'title': instance.title,
      'expires_at': instance.expiresAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

    return map;
  }

  @override
  Map<String, dynamic> convertToMap(dynamic i) {
    Link instance = i as Link;
    Map<String, dynamic> map = instance.columnsToMap();

    return map;
  }

  @override
  bool setColumnValue(String column, dynamic value) {
    Link instance = this as Link;
    switch (column) {
      case 'id':
        if (value is! int?) return false;
        instance.id = value;
        return true;
      case 'user_id':
        if (value is! int?) return false;
        instance.userId = value;
        return true;
      case 'code':
        if (value is! String?) return false;
        instance.code = value;
        return true;
      case 'url':
        if (value is! String?) return false;
        instance.url = value;
        return true;
      case 'title':
        if (value is! String?) return false;
        instance.title = value;
        return true;
      case 'expires_at':
        if (value is! DateTime?) return false;
        instance.expiresAt = value;
        return true;
      case 'created_at':
        if (value is! DateTime?) return false;
        instance.createdAt = value;
        return true;
      case 'updated_at':
        if (value is! DateTime?) return false;
        instance.updatedAt = value;
        return true;
    }
    return false;
  }
}
