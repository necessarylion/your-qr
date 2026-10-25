import 'package:dox_inertia/dox_inertia.dart';
import 'package:your_qr/config/env.dart';

/// The dashboard pages (React + Vite, see resources/js).
InertiaConfig inertiaConfig = InertiaConfig(
  entryPoints: <String>['resources/js/app.jsx'],

  /// `VITE_DEV_SERVER=http://localhost:5173` while `npm run dev` runs.
  devServerUrl: env.viteDevServer,
  reactRefresh: true,
);
