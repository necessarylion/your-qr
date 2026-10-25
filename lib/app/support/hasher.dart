import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dox_core/dox_core.dart';
import 'package:your_qr/config/env.dart';

/// One-way hashes for values we must not save as plain text.
@Inject()
class Hasher {
  /// sha256 as hex. For API keys: they are long and random,
  /// so a plain hash is safe and fast to look up.
  String sha256Hex(String value) {
    return sha256.convert(utf8.encode(value)).toString();
  }

  /// HMAC-sha256 with APP_KEY as hex. For visitor IPs: an IP is easy to
  /// guess, so the secret key stops anyone from finding it from the hash.
  String keyedHash(String value) {
    Hmac hmac = Hmac(sha256, utf8.encode(env.appKey));
    return hmac.convert(utf8.encode(value)).toString();
  }
}
