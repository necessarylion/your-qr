// GENERATED CODE - DO NOT MODIFY BY HAND
// Made by dox_builder. Run `dart run build_runner build`.
// ignore_for_file: type=lint

import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/http/controllers/api_key_page.controller.dart'
    as i1;
import 'package:your_qr/app/http/controllers/auth_page.controller.dart' as i2;
import 'package:your_qr/app/http/controllers/link_api.controller.dart' as i3;
import 'package:your_qr/app/http/controllers/link_page.controller.dart' as i4;
import 'package:your_qr/app/http/controllers/redirect.controller.dart' as i5;
import 'package:your_qr/app/http/middleware/api_key_auth.middleware.dart' as i6;
import 'package:your_qr/app/http/middleware/inertia.middleware.dart' as i7;
import 'package:your_qr/app/repositories/api_key.repository.dart' as i8;
import 'package:your_qr/app/repositories/link.repository.dart' as i9;
import 'package:your_qr/app/repositories/user.repository.dart' as i10;
import 'package:your_qr/app/repositories/visit.repository.dart' as i11;
import 'package:your_qr/app/services/api_key.service.dart' as i12;
import 'package:your_qr/app/services/auth.service.dart' as i13;
import 'package:your_qr/app/services/link.service.dart' as i14;
import 'package:your_qr/app/services/stats.service.dart' as i15;
import 'package:your_qr/app/services/visit.service.dart' as i16;
import 'package:your_qr/app/support/hasher.dart' as i17;
import 'package:your_qr/app/support/link_urls.dart' as i18;
import 'package:your_qr/app/support/qr_svg.dart' as i19;
import 'package:your_qr/app/support/random_code.dart' as i20;
import 'package:your_qr/routes/api.dart' as i21;
import 'package:your_qr/routes/public.dart' as i22;
import 'package:your_qr/routes/web.dart' as i23;
import 'package:your_qr/services/auth_service.dart' as i24;
import 'package:your_qr/services/inertia_service.dart' as i25;
import 'package:your_qr/services/orm_service.dart' as i26;
import 'package:your_qr/app/models/api_key/api_key.model.dart' as i27;
import 'package:your_qr/app/models/link/link.model.dart' as i28;
import 'package:your_qr/app/models/user/user.model.dart' as i29;
import 'package:your_qr/app/models/visit/visit.model.dart' as i30;

/// Puts every class of the app into the container: the
/// `@Inject()` classes, routers, services and model binders.
/// Use it in `AppConfig(container: registerContainer)`.
void registerContainer(IocContainer c) {
  c.singleton<i1.ApiKeyPageController>(
    (IocContainer c) => i1.ApiKeyPageController(c.get<i12.ApiKeyService>()),
  );
  c.singleton<i2.AuthPageController>(
    (IocContainer c) => i2.AuthPageController(c.get<i13.AuthService>()),
  );
  c.singleton<i3.LinkApiController>(
    (IocContainer c) => i3.LinkApiController(
      c.get<i14.LinkService>(),
      c.get<i15.StatsService>(),
      c.get<i18.LinkUrls>(),
      c.get<i19.QrSvg>(),
    ),
  );
  c.singleton<i4.LinkPageController>(
    (IocContainer c) => i4.LinkPageController(
      c.get<i14.LinkService>(),
      c.get<i16.VisitService>(),
      c.get<i15.StatsService>(),
      c.get<i18.LinkUrls>(),
      c.get<i19.QrSvg>(),
    ),
  );
  c.singleton<i5.RedirectController>(
    (IocContainer c) => i5.RedirectController(
      c.get<i14.LinkService>(),
      c.get<i16.VisitService>(),
    ),
  );
  c.singleton<i6.ApiKeyAuthMiddleware>(
    (IocContainer c) => i6.ApiKeyAuthMiddleware(c.get<i12.ApiKeyService>()),
  );
  c.singleton<i7.HandleInertiaRequests>(
    (IocContainer c) => i7.HandleInertiaRequests(c.get<i13.AuthService>()),
  );
  c.singleton<i8.ApiKeyRepository>((IocContainer c) => i8.ApiKeyRepository());
  c.singleton<i9.LinkRepository>((IocContainer c) => i9.LinkRepository());
  c.singleton<i10.UserRepository>((IocContainer c) => i10.UserRepository());
  c.singleton<i11.VisitRepository>((IocContainer c) => i11.VisitRepository());
  c.singleton<i12.ApiKeyService>(
    (IocContainer c) => i12.ApiKeyService(
      c.get<i8.ApiKeyRepository>(),
      c.get<i10.UserRepository>(),
      c.get<i17.Hasher>(),
      c.get<i20.RandomCode>(),
    ),
  );
  c.singleton<i13.AuthService>(
    (IocContainer c) => i13.AuthService(c.get<i10.UserRepository>()),
  );
  c.singleton<i14.LinkService>(
    (IocContainer c) =>
        i14.LinkService(c.get<i9.LinkRepository>(), c.get<i20.RandomCode>()),
  );
  c.singleton<i15.StatsService>(
    (IocContainer c) => i15.StatsService(c.get<i11.VisitRepository>()),
  );
  c.singleton<i16.VisitService>(
    (IocContainer c) =>
        i16.VisitService(c.get<i11.VisitRepository>(), c.get<i17.Hasher>()),
  );
  c.singleton<i17.Hasher>((IocContainer c) => i17.Hasher());
  c.singleton<i18.LinkUrls>((IocContainer c) => i18.LinkUrls());
  c.singleton<i19.QrSvg>((IocContainer c) => i19.QrSvg());
  c.singleton<i20.RandomCode>((IocContainer c) => i20.RandomCode());
  c.router<i21.ApiRouter>(
    (IocContainer c) => i21.ApiRouter(c.get<i6.ApiKeyAuthMiddleware>()),
  );
  c.router<i22.PublicRouter>((IocContainer c) => i22.PublicRouter());
  c.router<i23.WebRouter>(
    (IocContainer c) => i23.WebRouter(c.get<i7.HandleInertiaRequests>()),
  );
  c.service<i24.AppAuthService>((IocContainer c) => i24.AppAuthService());
  c.service<i25.AppInertiaService>((IocContainer c) => i25.AppInertiaService());
  c.service<i26.ORMService>((IocContainer c) => i26.ORMService());
  c.bindModel<i27.ApiKey>((String id) {
    int? key = int.tryParse(id);
    if (key == null) return null;
    return i27.ApiKey().find(key);
  });
  c.bindModel<i28.Link>((String id) {
    int? key = int.tryParse(id);
    if (key == null) return null;
    return i28.Link().find(key);
  });
  c.bindModel<i29.User>((String id) {
    int? key = int.tryParse(id);
    if (key == null) return null;
    return i29.User().find(key);
  });
  c.bindModel<i30.Visit>((String id) {
    int? key = int.tryParse(id);
    if (key == null) return null;
    return i30.Visit().find(key);
  });
}
