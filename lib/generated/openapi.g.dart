// GENERATED CODE - DO NOT MODIFY BY HAND
// Made by dox_builder. Run `dart run build_runner build`.
// ignore_for_file: type=lint

import 'package:dox_core/dox_core.dart';

/// OpenAPI docs found in the code.
/// Use it in `OpenApiConfig(registry: openApiRegistry)`.
const OpenApiRegistry openApiRegistry = OpenApiRegistry(
  operations: <OpenApiOperation>[
    OpenApiOperation(
      controller: 'LinkApiController',
      method: 'index',
      argumentTypes: <String>['DoxRequest', 'ListLinks'],
      summary: 'List your links',
      description: 'Newest first.',
      tags: <String>['LinkApi'],
      schema: <String, dynamic>{'\$ref': '#/components/schemas/ListLinks'},
      requestIn: 'query',
      responses: <int, ResponseDoc>{
        200: ResponseDoc(
          description: 'Successful response',
          schema: <String, dynamic>{'type': 'object'},
        ),
      },
    ),
    OpenApiOperation(
      controller: 'LinkApiController',
      method: 'store',
      argumentTypes: <String>['DoxRequest', 'CreateLink'],
      summary: 'Create a short link',
      description: 'Leave `code` out for a random code.',
      tags: <String>['LinkApi'],
      schema: <String, dynamic>{'\$ref': '#/components/schemas/CreateLink'},
      responses: <int, ResponseDoc>{
        201: ResponseDoc(
          description: 'The new link',
          schema: <String, dynamic>{
            'type': 'object',
            'properties': <String, dynamic>{
              'id': <String, dynamic>{
                'type': <dynamic>['integer', 'null'],
              },
              'code': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'url': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'title': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'short_url': <String, dynamic>{'type': 'string'},
              'qr_url': <String, dynamic>{'type': 'string'},
              'expires_at': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'created_at': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'updated_at': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
            },
          },
        ),
      },
    ),
    OpenApiOperation(
      controller: 'LinkApiController',
      method: 'show',
      argumentTypes: <String>['DoxRequest', 'int'],
      summary: 'Get one link',
      tags: <String>['LinkApi'],
      params: <Map<String, dynamic>>[
        <String, dynamic>{'type': 'integer'},
      ],
      responses: <int, ResponseDoc>{
        200: ResponseDoc(
          description: 'Successful response',
          schema: <String, dynamic>{
            'type': 'object',
            'properties': <String, dynamic>{
              'id': <String, dynamic>{
                'type': <dynamic>['integer', 'null'],
              },
              'code': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'url': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'title': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'short_url': <String, dynamic>{'type': 'string'},
              'qr_url': <String, dynamic>{'type': 'string'},
              'expires_at': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'created_at': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'updated_at': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
            },
          },
        ),
      },
    ),
    OpenApiOperation(
      controller: 'LinkApiController',
      method: 'update',
      argumentTypes: <String>['DoxRequest', 'int', 'UpdateLink'],
      summary: 'Change a link',
      description: 'Only the keys you send are changed.',
      tags: <String>['LinkApi'],
      params: <Map<String, dynamic>>[
        <String, dynamic>{'type': 'integer'},
      ],
      schema: <String, dynamic>{'\$ref': '#/components/schemas/UpdateLink'},
      responses: <int, ResponseDoc>{
        200: ResponseDoc(
          description: 'Successful response',
          schema: <String, dynamic>{
            'type': 'object',
            'properties': <String, dynamic>{
              'id': <String, dynamic>{
                'type': <dynamic>['integer', 'null'],
              },
              'code': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'url': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'title': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'short_url': <String, dynamic>{'type': 'string'},
              'qr_url': <String, dynamic>{'type': 'string'},
              'expires_at': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'created_at': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
              'updated_at': <String, dynamic>{
                'type': <dynamic>['string', 'null'],
              },
            },
          },
        ),
      },
    ),
    OpenApiOperation(
      controller: 'LinkApiController',
      method: 'destroy',
      argumentTypes: <String>['DoxRequest', 'int'],
      summary: 'Delete a link',
      description: 'Its visits are deleted too.',
      tags: <String>['LinkApi'],
      params: <Map<String, dynamic>>[
        <String, dynamic>{'type': 'integer'},
      ],
      responses: <int, ResponseDoc>{
        200: ResponseDoc(
          description: 'Successful response',
          schema: <String, dynamic>{
            'type': 'object',
            'additionalProperties': <String, dynamic>{'type': 'string'},
          },
        ),
      },
    ),
    OpenApiOperation(
      controller: 'LinkApiController',
      method: 'qrSvg',
      argumentTypes: <String>['DoxRequest', 'int', 'QrOptions'],
      summary: 'QR code (SVG)',
      description: 'The QR code opens /q/{code}, so each scan is counted.',
      tags: <String>['LinkApi'],
      params: <Map<String, dynamic>>[
        <String, dynamic>{'type': 'integer'},
      ],
      schema: <String, dynamic>{'\$ref': '#/components/schemas/QrOptions'},
      requestIn: 'query',
      responses: <int, ResponseDoc>{
        200: ResponseDoc(description: 'Successful response'),
      },
    ),
    OpenApiOperation(
      controller: 'LinkApiController',
      method: 'dailyStats',
      argumentTypes: <String>['DoxRequest', 'int', 'StatsOptions'],
      summary: 'Clicks and scans per day',
      tags: <String>['LinkApi'],
      params: <Map<String, dynamic>>[
        <String, dynamic>{'type': 'integer'},
      ],
      schema: <String, dynamic>{'\$ref': '#/components/schemas/StatsOptions'},
      requestIn: 'query',
      responses: <int, ResponseDoc>{
        200: ResponseDoc(
          description: 'Successful response',
          schema: <String, dynamic>{'type': 'object'},
        ),
      },
    ),
    OpenApiOperation(
      controller: 'RedirectController',
      method: 'click',
      argumentTypes: <String>['DoxRequest', 'String'],
      summary: 'Open a short link',
      description: 'Counts a click and redirects (302) to the long URL.\nUnknown or expired code: 404.',
      tags: <String>['Redirect'],
      params: <Map<String, dynamic>>[
        <String, dynamic>{'type': 'string'},
      ],
      responses: <int, ResponseDoc>{
        200: ResponseDoc(description: 'Successful response'),
      },
    ),
    OpenApiOperation(
      controller: 'RedirectController',
      method: 'scan',
      argumentTypes: <String>['DoxRequest', 'String'],
      summary: 'Open a QR code link',
      description: 'Counts a scan and redirects (302) to the long URL.\nUnknown or expired code: 404.',
      tags: <String>['Redirect'],
      params: <Map<String, dynamic>>[
        <String, dynamic>{'type': 'string'},
      ],
      responses: <int, ResponseDoc>{
        200: ResponseDoc(description: 'Successful response'),
      },
    ),
    OpenApiOperation(
      controller: 'PublicRouter',
      method: 'register',
      argumentTypes: <String>[],
      tags: <String>['PublicRouter'],
      responses: <int, ResponseDoc>{
        200: ResponseDoc(description: 'Successful response'),
      },
    ),
    OpenApiOperation(
      controller: 'PublicRouter',
      method: 'buildFile',
      argumentTypes: <String>['String'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'AuthPageController',
      method: 'home',
      argumentTypes: <String>['DoxRequest'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'AuthPageController',
      method: 'registerPage',
      argumentTypes: <String>['DoxRequest'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'AuthPageController',
      method: 'register',
      argumentTypes: <String>['DoxRequest', 'RegisterUser'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'AuthPageController',
      method: 'loginPage',
      argumentTypes: <String>['DoxRequest'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'AuthPageController',
      method: 'login',
      argumentTypes: <String>['DoxRequest', 'LoginUser'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'AuthPageController',
      method: 'logout',
      argumentTypes: <String>['DoxRequest'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'LinkPageController',
      method: 'index',
      argumentTypes: <String>['DoxRequest'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'LinkPageController',
      method: 'store',
      argumentTypes: <String>['DoxRequest', 'CreateLink'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'LinkPageController',
      method: 'update',
      argumentTypes: <String>['DoxRequest', 'int', 'UpdateLink'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'LinkPageController',
      method: 'destroy',
      argumentTypes: <String>['DoxRequest', 'int'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'LinkPageController',
      method: 'dailyStats',
      argumentTypes: <String>['DoxRequest', 'int'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'LinkPageController',
      method: 'qrSvg',
      argumentTypes: <String>['DoxRequest', 'int'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'ApiKeyPageController',
      method: 'index',
      argumentTypes: <String>['DoxRequest'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'ApiKeyPageController',
      method: 'store',
      argumentTypes: <String>['DoxRequest', 'CreateApiKey'],
      ignore: true,
    ),
    OpenApiOperation(
      controller: 'ApiKeyPageController',
      method: 'destroy',
      argumentTypes: <String>['DoxRequest', 'int'],
      ignore: true,
    ),
  ],
  routes: <OpenApiRouteBinding>[
    OpenApiRouteBinding('GET', 'api/links', 'LinkApiController.index'),
    OpenApiRouteBinding('POST', 'api/links', 'LinkApiController.store'),
    OpenApiRouteBinding('GET', 'api/links/{id}', 'LinkApiController.show'),
    OpenApiRouteBinding('PATCH', 'api/links/{id}', 'LinkApiController.update'),
    OpenApiRouteBinding(
      'DELETE',
      'api/links/{id}',
      'LinkApiController.destroy',
    ),
    OpenApiRouteBinding(
      'GET',
      'api/links/{id}/qr.svg',
      'LinkApiController.qrSvg',
    ),
    OpenApiRouteBinding(
      'GET',
      'api/links/{id}/stats',
      'LinkApiController.dailyStats',
    ),
    OpenApiRouteBinding('GET', '/s/{code}', 'RedirectController.click'),
    OpenApiRouteBinding('GET', '/q/{code}', 'RedirectController.scan'),
    OpenApiRouteBinding('GET', '/build/{path*}', 'PublicRouter.buildFile'),
    OpenApiRouteBinding('GET', '/', 'AuthPageController.home'),
    OpenApiRouteBinding('GET', '/register', 'AuthPageController.registerPage'),
    OpenApiRouteBinding('POST', '/register', 'AuthPageController.register'),
    OpenApiRouteBinding('GET', '/login', 'AuthPageController.loginPage'),
    OpenApiRouteBinding('POST', '/login', 'AuthPageController.login'),
    OpenApiRouteBinding('POST', '/logout', 'AuthPageController.logout'),
    OpenApiRouteBinding('GET', '/links', 'LinkPageController.index'),
    OpenApiRouteBinding('POST', '/links', 'LinkPageController.store'),
    OpenApiRouteBinding('PUT', '/links/{id}', 'LinkPageController.update'),
    OpenApiRouteBinding('DELETE', '/links/{id}', 'LinkPageController.destroy'),
    OpenApiRouteBinding(
      'GET',
      '/links/{id}/stats',
      'LinkPageController.dailyStats',
    ),
    OpenApiRouteBinding(
      'GET',
      '/links/{id}/qr.svg',
      'LinkPageController.qrSvg',
    ),
    OpenApiRouteBinding('GET', '/api-keys', 'ApiKeyPageController.index'),
    OpenApiRouteBinding('POST', '/api-keys', 'ApiKeyPageController.store'),
    OpenApiRouteBinding(
      'DELETE',
      '/api-keys/{id}',
      'ApiKeyPageController.destroy',
    ),
  ],
  schemas: <String, Map<String, dynamic>>{
    'ListLinks': <String, dynamic>{
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
    },
    'CreateLink': <String, dynamic>{
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
    },
    'UpdateLink': <String, dynamic>{
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
    },
    'QrOptions': <String, dynamic>{
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
    },
    'StatsOptions': <String, dynamic>{
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
    },
  },
  security: <String, OpenApiSecurity>{
    'ApiKeyAuthMiddleware': OpenApiSecurity('apiKeyAuth', <String, dynamic>{
      'type': 'http',
      'scheme': 'bearer',
      'bearerFormat': 'API key',
    }),
  },
);
