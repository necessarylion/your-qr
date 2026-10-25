import 'dart:io';

import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/http/controllers/redirect.controller.dart';

/// Public routes: the short links and the built frontend files.
/// No session and no CSRF, so they stay fast.
class PublicRouter extends Router {
  @override
  void register() {
    Route.get('/s/{code}', (RedirectController c) => c.click);
    Route.get('/q/{code}', (RedirectController c) => c.scan);

    /// The Vite build of the dashboard (`npm run build`).
    Route.get('/build/{path*}', buildFile);
  }

  /// The file names have a hash, so the browser can keep them for a year.
  /// Not part of the API docs.
  @ApiIgnore()
  DoxResponse buildFile(String path) {
    if (path.contains('..')) {
      throw NotFoundHttpException();
    }
    return response(File('public/build/$path')).cache(Duration(days: 365));
  }
}
