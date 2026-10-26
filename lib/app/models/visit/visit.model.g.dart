// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.model.dart';

// **************************************************************************
// Generator: DoxModelBuilder
// **************************************************************************

// ignore_for_file: always_specify_types

class VisitGenerator extends Model<Visit> {
  @override
  String get primaryKey => 'id';

  @override
  Map<String, dynamic> get timestampsColumn => const <String, dynamic>{
    'created_at': 'created_at',
    'updated_at': null,
  };

  @override
  String get tableName => 'visits';

  int? get id => tempIdValue as int?;

  set id(int? val) => tempIdValue = val;

  Visit query() => Visit();

  @override
  bool get readsRowDates => true;

  @override
  List<String> get tableColumns => const <String>[
    'id',
    'link_id',
    'source',
    'ip_hash',
    'user_agent',
    'referer',
    'created_at',
  ];

  @override
  List<String> get preloadList => const <String>[];

  @override
  Map<String, Function> get relationsResultMatcher =>
      const <String, Function>{};

  @override
  Map<String, Function> get relationsQueryMatcher => const <String, Function>{};

  @override
  Visit fromMap(Map<String, dynamic> m) => Visit()
    ..id = m['id'] as int?
    ..linkId = m['link_id'] as int?
    ..source = m['source'] as String?
    ..ipHash = m['ip_hash'] as String?
    ..userAgent = m['user_agent'] as String?
    ..referer = m['referer'] as String?
    ..createdAt = m['created_at'] is DateTime?
        ? m['created_at'] as DateTime?
        : DateTime.parse(m['created_at'] as String);
  @override
  Map<String, dynamic> columnsToMap() {
    Visit instance = this as Visit;
    Map<String, dynamic> map = <String, dynamic>{
      'id': instance.id,
      'link_id': instance.linkId,
      'source': instance.source,
      'ip_hash': instance.ipHash,
      'user_agent': instance.userAgent,
      'referer': instance.referer,
      'created_at': instance.createdAt?.toIso8601String(),
    };

    return map;
  }

  @override
  Map<String, dynamic> convertToMap(dynamic i) {
    Visit instance = i as Visit;
    Map<String, dynamic> map = instance.columnsToMap();

    return map;
  }

  @override
  bool setColumnValue(String column, dynamic value) {
    Visit instance = this as Visit;
    switch (column) {
      case 'id':
        if (value is! int?) return false;
        instance.id = value;
        return true;
      case 'link_id':
        if (value is! int?) return false;
        instance.linkId = value;
        return true;
      case 'source':
        if (value is! String?) return false;
        instance.source = value;
        return true;
      case 'ip_hash':
        if (value is! String?) return false;
        instance.ipHash = value;
        return true;
      case 'user_agent':
        if (value is! String?) return false;
        instance.userAgent = value;
        return true;
      case 'referer':
        if (value is! String?) return false;
        instance.referer = value;
        return true;
      case 'created_at':
        if (value is! DateTime?) return false;
        instance.createdAt = value;
        return true;
    }
    return false;
  }
}
