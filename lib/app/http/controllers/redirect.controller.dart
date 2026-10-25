import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/models/link/link.model.dart';
import 'package:your_qr/app/services/link.service.dart';
import 'package:your_qr/app/services/visit.service.dart';
import 'package:your_qr/constants/app_constants.dart';

/// The public short links. No login, no session.
@Inject()
class RedirectController {
  final LinkService links;
  final VisitService visits;

  RedirectController(this.links, this.visits);

  /// Open a short link
  ///
  /// Counts a click and redirects (302) to the long URL.
  /// Unknown or expired code: 404.
  Future<DoxResponse> click(DoxRequest req, String code) async {
    return await _visit(req, code, VisitSource.click);
  }

  /// Open a QR code link
  ///
  /// Counts a scan and redirects (302) to the long URL.
  /// Unknown or expired code: 404.
  Future<DoxResponse> scan(DoxRequest req, String code) async {
    return await _visit(req, code, VisitSource.scan);
  }

  Future<DoxResponse> _visit(DoxRequest req, String code, String source) async {
    Link link = await links.resolve(code);
    await visits.record(
      link,
      source,
      VisitInfo(
        ip: req.ip(),
        userAgent: req.userAgent(),
        referer: req.referer(),
      ),
    );
    return redirect(link.url!);
  }
}
