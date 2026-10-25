/// Global constants of the app.
class AppConstants {
  /// Length of a random short code.
  static const int codeLength = 7;

  /// Characters of a random short code (URL-safe, no look-alike 0/O, 1/l/I).
  static const String codeAlphabet =
      'abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  /// A custom code: letters, numbers, `-` and `_`, 3 to 32 characters.
  static const String customCodePattern = r'[A-Za-z0-9_-]{3,32}';

  /// Tries to find a free random code before we give up.
  static const int codeTries = 5;

  /// Prefix of every API key, so a leaked key is easy to spot.
  static const String apiKeyPrefix = 'yqr_';

  /// Random bytes in an API key.
  static const int apiKeyBytes = 24;

  static const int defaultPerPage = 20;
  static const int maxPerPage = 100;

  /// QR code size in pixels.
  static const int defaultQrSize = 256;
  static const int minQrSize = 64;
  static const int maxQrSize = 2048;

  /// Empty modules around a QR code (the "quiet zone").
  static const int qrQuietZone = 4;

  static const int defaultStatsDays = 30;
  static const int maxStatsDays = 365;
}

/// Where a visit came from.
class VisitSource {
  /// GET /s/{code}
  static const String click = 'click';

  /// GET /q/{code} (the URL inside the QR code)
  static const String scan = 'scan';
}
