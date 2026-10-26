import 'package:dox_auth/dox_auth.dart';
import 'package:dox_core/dox_core.dart';
import 'package:your_qr/config/auth.dart';

/// Sets up dox_auth with the session guard (`web`) in every isolate.
class AppAuthProvider extends DoxProvider {
  @override
  void setup() {
    Auth.initialize(authConfig);
  }
}
