import 'package:dox_inertia/dox_inertia.dart';
import 'package:your_qr/config/inertia.dart';

/// Sets up Inertia (the dashboard pages) in every isolate.
class AppInertiaService extends InertiaService {
  AppInertiaService() : super(inertiaConfig);
}
