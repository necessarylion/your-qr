import 'package:dox_core/dox_core.dart';
import 'package:dox_inertia/dox_inertia.dart';
import 'package:your_qr/app/models/user/user.model.dart';
import 'package:your_qr/app/services/auth.service.dart';
import 'package:your_qr/config/env.dart';

/// Props for every dashboard page.
@Inject()
class HandleInertiaRequests extends InertiaMiddleware {
  final AuthService auth;

  HandleInertiaRequests(this.auth);

  /// `auth.user` is the logged in user, or null.
  @override
  Future<Map<String, dynamic>> share(DoxRequest req) async {
    User? user = await auth.currentUser(req);
    return <String, dynamic>{
      'appName': env.appName,
      'auth': <String, dynamic>{
        'user': user == null
            ? null
            : <String, dynamic>{'name': user.name, 'email': user.email},
      },
    };
  }
}
