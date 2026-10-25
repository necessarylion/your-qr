import 'dart:convert';
import 'dart:math';

import 'package:dox_core/dox_core.dart';
import 'package:your_qr/constants/app_constants.dart';

/// Makes random, URL-safe text with a secure random source.
@Inject()
class RandomCode {
  final Random _random = Random.secure();

  /// A short code for a link, like `k3TzQ8a`.
  String shortCode() {
    StringBuffer code = StringBuffer();
    for (int i = 0; i < AppConstants.codeLength; i++) {
      int index = _random.nextInt(AppConstants.codeAlphabet.length);
      code.write(AppConstants.codeAlphabet[index]);
    }
    return code.toString();
  }

  /// A new API key, like `yqr_Zk3x...` (URL-safe base64, no padding).
  String apiKey() {
    List<int> bytes = <int>[];
    for (int i = 0; i < AppConstants.apiKeyBytes; i++) {
      bytes.add(_random.nextInt(256));
    }
    String text = base64Url.encode(bytes).replaceAll('=', '');
    return '${AppConstants.apiKeyPrefix}$text';
  }
}
