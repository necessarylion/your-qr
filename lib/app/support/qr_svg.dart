import 'package:dox_core/dox_core.dart';
import 'package:qr/qr.dart';
import 'package:your_qr/constants/app_constants.dart';

/// Draws a QR code as SVG text from the module matrix of `package:qr`.
/// No image library: each dark module is one square in a single path.
@Inject()
class QrSvg {
  /// [size] is the width and height in pixels.
  String render(String text, int size) {
    QrImage image = QrImage(QrCode(payload: QrPayload.fromString(text)));
    int count = image.moduleCount;
    int quiet = AppConstants.qrQuietZone;
    int box = count + quiet * 2;

    StringBuffer path = StringBuffer();
    for (int row = 0; row < count; row++) {
      for (int col = 0; col < count; col++) {
        if (image.isDark(row, col)) {
          path.write('M${col + quiet} ${row + quiet}h1v1h-1z');
        }
      }
    }

    return '<svg xmlns="http://www.w3.org/2000/svg" '
        'width="$size" height="$size" viewBox="0 0 $box $box" '
        'shape-rendering="crispEdges">'
        '<rect width="$box" height="$box" fill="#fff"/>'
        '<path fill="#000" d="$path"/>'
        '</svg>';
  }
}
