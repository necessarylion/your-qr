// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dto.dart';

// **************************************************************************
// DoxDtoGenerator
// **************************************************************************

// ignore_for_file: type=lint

/// The checks, the converter and the JSON Schema of [CreateLink].
const DtoSchema<CreateLink> $CreateLinkDto = _$CreateLinkDto();

class _$CreateLinkDto extends DtoSchema<CreateLink> {
  const _$CreateLinkDto();

  static const Map<String, String> _m = <String, String>{};

  static final RegExp _r0 = RegExp('^(?:[A-Za-z0-9_-]{3,32})\$');

  @override
  Type get type => CreateLink;

  @override
  String get name => 'CreateLink';

  @override
  bool get isAsync => true;

  @override
  CreateLink? convert(Object? input, DtoState s, List<Object> p) {
    if (input is! Map) {
      s.notObject(input, p, _m);
      return null;
    }
    int e = s.issues.length;
    // url: String
    Object? c0;
    c0 = s.string(s.read(input, 'url'), p, 'url', _m, trim: true);
    if (c0 == null || c0 is Undefined) s.required(p, 'url', _m);
    // code: String?
    Object? c1;
    c1 = s.string(s.read(input, 'code'), p, 'code', _m, trim: true);
    // title: String?
    Object? c2;
    c2 = s.string(s.read(input, 'title'), p, 'title', _m, trim: true);
    // expiresAt: DateTime?
    Object? c3;
    c3 = s.date(s.read(input, 'expires_at'), p, 'expires_at', _m);
    if (s.issues.length != e) return null;
    if (c0 is String) {
      if (!(DtoChecks.url(c0))) {
        s.fail(p, 'url', IssueCodes.url, DefaultMessages.url, c0, messages: _m);
      } else if (!(c0.runes.length <= 2048)) {
        s.fail(
          p,
          'url',
          IssueCodes.maxLength,
          DefaultMessages.maxLength,
          c0,
          params: const <String, Object?>{'max': 2048},
          messages: _m,
        );
      }
    }
    if (c1 is String) {
      if (!(_r0.hasMatch(c1))) {
        s.fail(
          p,
          'code',
          IssueCodes.regex,
          DefaultMessages.regex,
          c1,
          messages: _m,
        );
      }
    }
    if (c2 is String) {
      if (!(c2.runes.length <= 255)) {
        s.fail(
          p,
          'title',
          IssueCodes.maxLength,
          DefaultMessages.maxLength,
          c2,
          params: const <String, Object?>{'max': 255},
          messages: _m,
        );
      }
    }
    if (c3 is DateTime) {
      if (!(c3.isAfter(s.now))) {
        s.fail(
          p,
          'expires_at',
          IssueCodes.after,
          DefaultMessages.after,
          c3,
          params: const <String, Object?>{'date': 'now'},
          messages: _m,
        );
      }
    }
    if (s.issues.length != e) return null;
    return CreateLink(
      url: c0 as String,
      code: c1 is Undefined ? null : c1 as String?,
      title: c2 is Undefined ? null : c2 as String?,
      expiresAt: c3 is Undefined ? null : c3 as DateTime?,
    );
  }

  @override
  Future<void> checkAsync(CreateLink o, DtoState s, List<Object> p) async {
    {
      String? f = o.code;
      if (f != null) {
        await s.asyncRule(
          const Unique('links', column: 'code'),
          f,
          p,
          'code',
          _m,
        );
      }
    }
  }

  @override
  CreateLink fromMap(Map<String, dynamic> m) {
    return CreateLink(
      url: m['url'] as String,
      code: m['code'] == null ? null : (m['code'] as String),
      title: m['title'] == null ? null : (m['title'] as String),
      expiresAt: m['expires_at'] == null
          ? null
          : (DateTime.parse(m['expires_at'] as String).toUtc()),
    );
  }

  @override
  Map<String, dynamic> toMap(CreateLink o) {
    String f0 = o.url;
    String? f1 = o.code;
    String? f2 = o.title;
    DateTime? f3 = o.expiresAt;
    return <String, dynamic>{
      'url': f0,
      'code': f1,
      'title': f2,
      'expires_at': f3 == null ? null : f3.toIso8601String(),
    };
  }

  @override
  Map<String, dynamic> toJsonSchema() {
    Map<String, dynamic> j = <String, dynamic>{
      'type': 'object',
      'title': 'CreateLink',
      'properties': <String, dynamic>{
        'url': <String, dynamic>{
          'type': 'string',
          'format': 'uri',
          'maxLength': 2048,
          'description':
              'Where the short link goes. Must start with http:// or https://.',
        },
        'code': <String, dynamic>{
          'type': <dynamic>['string', 'null'],
          'pattern': '^(?:[A-Za-z0-9_-]{3,32})\$',
          'description': 'Your own short code. Letters, numbers, `-` and `_`.\nEmpty: a random code is made.',
        },
        'title': <String, dynamic>{
          'type': <dynamic>['string', 'null'],
          'maxLength': 255,
        },
        'expires_at': <String, dynamic>{
          'type': <dynamic>['string', 'null'],
          'format': 'date-time',
          'description': 'After this time the link gives 404. Empty: never.',
        },
      },
      'required': <dynamic>['url'],
    };
    JsonSchemaTools.merge(j, <String>[
      'properties',
      'code',
    ], const Unique('links', column: 'code').toJsonSchema());
    return j;
  }
}

/// The checks, the converter and the JSON Schema of [UpdateLink].
const DtoSchema<UpdateLink> $UpdateLinkDto = _$UpdateLinkDto();

class _$UpdateLinkDto extends DtoSchema<UpdateLink> {
  const _$UpdateLinkDto();

  static const Map<String, String> _m = <String, String>{};

  static final RegExp _r0 = RegExp('^(?:[A-Za-z0-9_-]{3,32})\$');

  @override
  Type get type => UpdateLink;

  @override
  String get name => 'UpdateLink';

  @override
  bool get isAsync => true;

  @override
  UpdateLink? convert(Object? input, DtoState s, List<Object> p) {
    if (input is! Map) {
      s.notObject(input, p, _m);
      return null;
    }
    int e = s.issues.length;
    // url: Maybe<String>
    Object? c0;
    c0 = s.string(s.read(input, 'url'), p, 'url', _m, trim: true);
    if (c0 == null) s.required(p, 'url', _m);
    // code: Maybe<String>
    Object? c1;
    c1 = s.string(s.read(input, 'code'), p, 'code', _m, trim: true);
    if (c1 == null) s.required(p, 'code', _m);
    // title: Maybe<String?>
    Object? c2;
    c2 = s.string(s.read(input, 'title'), p, 'title', _m, trim: true);
    // expiresAt: Maybe<DateTime?>
    Object? c3;
    c3 = s.date(s.read(input, 'expires_at'), p, 'expires_at', _m);
    if (s.issues.length != e) return null;
    if (c0 is String) {
      if (!(DtoChecks.url(c0))) {
        s.fail(p, 'url', IssueCodes.url, DefaultMessages.url, c0, messages: _m);
      } else if (!(c0.runes.length <= 2048)) {
        s.fail(
          p,
          'url',
          IssueCodes.maxLength,
          DefaultMessages.maxLength,
          c0,
          params: const <String, Object?>{'max': 2048},
          messages: _m,
        );
      }
    }
    if (c1 is String) {
      if (!(_r0.hasMatch(c1))) {
        s.fail(
          p,
          'code',
          IssueCodes.regex,
          DefaultMessages.regex,
          c1,
          messages: _m,
        );
      }
    }
    if (c2 is String) {
      if (!(c2.runes.length <= 255)) {
        s.fail(
          p,
          'title',
          IssueCodes.maxLength,
          DefaultMessages.maxLength,
          c2,
          params: const <String, Object?>{'max': 255},
          messages: _m,
        );
      }
    }
    if (c3 is DateTime) {
      if (!(c3.isAfter(s.now))) {
        s.fail(
          p,
          'expires_at',
          IssueCodes.after,
          DefaultMessages.after,
          c3,
          params: const <String, Object?>{'date': 'now'},
          messages: _m,
        );
      }
    }
    if (s.issues.length != e) return null;
    return UpdateLink(
      url: c0 is Undefined
          ? const Maybe<String>.missing()
          : Maybe<String>(c0 as String),
      code: c1 is Undefined
          ? const Maybe<String>.missing()
          : Maybe<String>(c1 as String),
      title: c2 is Undefined
          ? const Maybe<String?>.missing()
          : Maybe<String?>(c2 as String?),
      expiresAt: c3 is Undefined
          ? const Maybe<DateTime?>.missing()
          : Maybe<DateTime?>(c3 as DateTime?),
    );
  }

  @override
  Future<void> checkAsync(UpdateLink o, DtoState s, List<Object> p) async {
    {
      Maybe<String> f = o.code;
      if (f.isPresent) {
        String g = f.value;
        await s.asyncRule(
          const Unique('links', column: 'code', ignoreParam: 'id'),
          g,
          p,
          'code',
          _m,
        );
      }
    }
  }

  @override
  UpdateLink fromMap(Map<String, dynamic> m) {
    return UpdateLink(
      url: m.containsKey('url')
          ? Maybe<String>(m['url'] as String)
          : const Maybe<String>.missing(),
      code: m.containsKey('code')
          ? Maybe<String>(m['code'] as String)
          : const Maybe<String>.missing(),
      title: m.containsKey('title')
          ? Maybe<String?>(m['title'] == null ? null : (m['title'] as String))
          : const Maybe<String?>.missing(),
      expiresAt: m.containsKey('expires_at')
          ? Maybe<DateTime?>(
              m['expires_at'] == null
                  ? null
                  : (DateTime.parse(m['expires_at'] as String).toUtc()),
            )
          : const Maybe<DateTime?>.missing(),
    );
  }

  @override
  Map<String, dynamic> toMap(UpdateLink o) {
    Maybe<String> f0 = o.url;
    Maybe<String> f1 = o.code;
    Maybe<String?> f2 = o.title;
    Maybe<DateTime?> f3 = o.expiresAt;
    return <String, dynamic>{
      if (f0 case Maybe<String>(isPresent: true, value: String g0)) 'url': g0,
      if (f1 case Maybe<String>(isPresent: true, value: String g1)) 'code': g1,
      if (f2 case Maybe<String?>(isPresent: true, value: String? g2))
        'title': g2,
      if (f3 case Maybe<DateTime?>(isPresent: true, value: DateTime? g3))
        'expires_at': g3 == null ? null : g3.toIso8601String(),
    };
  }

  @override
  Map<String, dynamic> toJsonSchema() {
    Map<String, dynamic> j = <String, dynamic>{
      'type': 'object',
      'title': 'UpdateLink',
      'properties': <String, dynamic>{
        'url': <String, dynamic>{
          'type': 'string',
          'format': 'uri',
          'maxLength': 2048,
        },
        'code': <String, dynamic>{
          'type': 'string',
          'pattern': '^(?:[A-Za-z0-9_-]{3,32})\$',
        },
        'title': <String, dynamic>{
          'type': <dynamic>['string', 'null'],
          'maxLength': 255,
        },
        'expires_at': <String, dynamic>{
          'type': <dynamic>['string', 'null'],
          'format': 'date-time',
        },
      },
    };
    JsonSchemaTools.merge(j, <String>[
      'properties',
      'code',
    ], const Unique('links', column: 'code', ignoreParam: 'id').toJsonSchema());
    return j;
  }
}

/// The checks, the converter and the JSON Schema of [ListLinks].
const DtoSchema<ListLinks> $ListLinksDto = _$ListLinksDto();

class _$ListLinksDto extends DtoSchema<ListLinks> {
  const _$ListLinksDto();

  static const Map<String, String> _m = <String, String>{};

  @override
  Type get type => ListLinks;

  @override
  String get name => 'ListLinks';

  @override
  Source get source => Source.query;

  @override
  ListLinks? convert(Object? input, DtoState s, List<Object> p) {
    if (input is! Map) {
      s.notObject(input, p, _m);
      return null;
    }
    int e = s.issues.length;
    // page: int
    Object? c0;
    c0 = s.integer(s.read(input, 'page'), p, 'page', _m);
    if (c0 == null) s.required(p, 'page', _m);
    // perPage: int
    Object? c1;
    c1 = s.integer(s.read(input, 'per_page'), p, 'per_page', _m);
    if (c1 == null) s.required(p, 'per_page', _m);
    if (s.issues.length != e) return null;
    if (c0 is int) {
      if (!(c0 >= 1)) {
        s.fail(
          p,
          'page',
          IssueCodes.min,
          DefaultMessages.min,
          c0,
          params: const <String, Object?>{'min': 1},
          messages: _m,
        );
      }
    }
    if (c1 is int) {
      if (!(c1 >= 1 && c1 <= 100)) {
        s.fail(
          p,
          'per_page',
          IssueCodes.between,
          DefaultMessages.between,
          c1,
          params: const <String, Object?>{'min': 1, 'max': 100},
          messages: _m,
        );
      }
    }
    if (s.issues.length != e) return null;
    return ListLinks(
      page: c0 is Undefined ? 1 : c0 as int,
      perPage: c1 is Undefined ? AppConstants.defaultPerPage : c1 as int,
    );
  }

  @override
  ListLinks fromMap(Map<String, dynamic> m) {
    return ListLinks(
      page: m.containsKey('page') ? (m['page'] as num).toInt() : 1,
      perPage: m.containsKey('per_page')
          ? (m['per_page'] as num).toInt()
          : AppConstants.defaultPerPage,
    );
  }

  @override
  Map<String, dynamic> toMap(ListLinks o) {
    int f0 = o.page;
    int f1 = o.perPage;
    return <String, dynamic>{'page': f0, 'per_page': f1};
  }

  @override
  Map<String, dynamic> toJsonSchema() {
    return <String, dynamic>{
      'type': 'object',
      'title': 'ListLinks',
      'properties': <String, dynamic>{
        'page': <String, dynamic>{
          'type': 'integer',
          'minimum': 1,
          'default': 1,
        },
        'per_page': <String, dynamic>{
          'type': 'integer',
          'minimum': 1,
          'maximum': 100,
          'default': 20,
        },
      },
    };
  }
}

/// The checks, the converter and the JSON Schema of [QrOptions].
const DtoSchema<QrOptions> $QrOptionsDto = _$QrOptionsDto();

class _$QrOptionsDto extends DtoSchema<QrOptions> {
  const _$QrOptionsDto();

  static const Map<String, String> _m = <String, String>{};

  @override
  Type get type => QrOptions;

  @override
  String get name => 'QrOptions';

  @override
  Source get source => Source.query;

  @override
  QrOptions? convert(Object? input, DtoState s, List<Object> p) {
    if (input is! Map) {
      s.notObject(input, p, _m);
      return null;
    }
    int e = s.issues.length;
    // size: int
    Object? c0;
    c0 = s.integer(s.read(input, 'size'), p, 'size', _m);
    if (c0 == null) s.required(p, 'size', _m);
    if (s.issues.length != e) return null;
    if (c0 is int) {
      if (!(c0 >= 64 && c0 <= 2048)) {
        s.fail(
          p,
          'size',
          IssueCodes.between,
          DefaultMessages.between,
          c0,
          params: const <String, Object?>{'min': 64, 'max': 2048},
          messages: _m,
        );
      }
    }
    if (s.issues.length != e) return null;
    return QrOptions(
      size: c0 is Undefined ? AppConstants.defaultQrSize : c0 as int,
    );
  }

  @override
  QrOptions fromMap(Map<String, dynamic> m) {
    return QrOptions(
      size: m.containsKey('size')
          ? (m['size'] as num).toInt()
          : AppConstants.defaultQrSize,
    );
  }

  @override
  Map<String, dynamic> toMap(QrOptions o) {
    int f0 = o.size;
    return <String, dynamic>{'size': f0};
  }

  @override
  Map<String, dynamic> toJsonSchema() {
    return <String, dynamic>{
      'type': 'object',
      'title': 'QrOptions',
      'properties': <String, dynamic>{
        'size': <String, dynamic>{
          'type': 'integer',
          'minimum': 64,
          'maximum': 2048,
          'description': 'Width and height in pixels.',
          'default': 256,
        },
      },
    };
  }
}

/// The checks, the converter and the JSON Schema of [StatsOptions].
const DtoSchema<StatsOptions> $StatsOptionsDto = _$StatsOptionsDto();

class _$StatsOptionsDto extends DtoSchema<StatsOptions> {
  const _$StatsOptionsDto();

  static const Map<String, String> _m = <String, String>{};

  @override
  Type get type => StatsOptions;

  @override
  String get name => 'StatsOptions';

  @override
  Source get source => Source.query;

  @override
  StatsOptions? convert(Object? input, DtoState s, List<Object> p) {
    if (input is! Map) {
      s.notObject(input, p, _m);
      return null;
    }
    int e = s.issues.length;
    // days: int
    Object? c0;
    c0 = s.integer(s.read(input, 'days'), p, 'days', _m);
    if (c0 == null) s.required(p, 'days', _m);
    if (s.issues.length != e) return null;
    if (c0 is int) {
      if (!(c0 >= 1 && c0 <= 365)) {
        s.fail(
          p,
          'days',
          IssueCodes.between,
          DefaultMessages.between,
          c0,
          params: const <String, Object?>{'min': 1, 'max': 365},
          messages: _m,
        );
      }
    }
    if (s.issues.length != e) return null;
    return StatsOptions(
      days: c0 is Undefined ? AppConstants.defaultStatsDays : c0 as int,
    );
  }

  @override
  StatsOptions fromMap(Map<String, dynamic> m) {
    return StatsOptions(
      days: m.containsKey('days')
          ? (m['days'] as num).toInt()
          : AppConstants.defaultStatsDays,
    );
  }

  @override
  Map<String, dynamic> toMap(StatsOptions o) {
    int f0 = o.days;
    return <String, dynamic>{'days': f0};
  }

  @override
  Map<String, dynamic> toJsonSchema() {
    return <String, dynamic>{
      'type': 'object',
      'title': 'StatsOptions',
      'properties': <String, dynamic>{
        'days': <String, dynamic>{
          'type': 'integer',
          'minimum': 1,
          'maximum': 365,
          'description': 'How many days back, today included.',
          'default': 30,
        },
      },
    };
  }
}
