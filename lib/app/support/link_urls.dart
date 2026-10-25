import 'package:dox_core/dox_core.dart';
import 'package:your_qr/config/env.dart';

/// The public URLs of a short code, from APP_URL.
@Inject()
class LinkUrls {
  String get _base {
    String url = env.appUrl;
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }

  /// The short link people click: {APP_URL}/s/{code}
  String click(String code) {
    return '$_base/s/$code';
  }

  /// The URL inside the QR code: {APP_URL}/q/{code}
  String scan(String code) {
    return '$_base/q/$code';
  }
}
