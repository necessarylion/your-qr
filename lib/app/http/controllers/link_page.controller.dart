import 'dart:io';

import 'package:dox_core/dox_core.dart';
import 'package:dox_inertia/dox_inertia.dart';
import 'package:your_qr/app/http/dtos/link/link.dto.dart';
import 'package:your_qr/app/http/serializers/link.serializer.dart';
import 'package:your_qr/app/models/link/link.model.dart';
import 'package:your_qr/app/models/user/user.model.dart';
import 'package:your_qr/app/services/link.service.dart';
import 'package:your_qr/app/services/stats.service.dart';
import 'package:your_qr/app/services/visit.service.dart';
import 'package:your_qr/app/support/link_urls.dart';
import 'package:your_qr/app/support/qr_svg.dart';
import 'package:your_qr/constants/app_constants.dart';

/// The dashboard pages for links. Needs the session login.
/// Not part of the API docs.
@ApiIgnore()
@Inject()
class LinkPageController {
  final LinkService links;
  final VisitService visits;
  final StatsService stats;
  final LinkUrls urls;
  final QrSvg qr;

  LinkPageController(this.links, this.visits, this.stats, this.urls, this.qr);

  /// GET /links: all links of the user with their click and scan totals.
  // ponytail: no paging on the dashboard. Add it when users have
  // hundreds of links (the API already pages).
  Future<DoxResponse> index(DoxRequest req) async {
    List<Link> list = await links.listAll(_userId(req));
    Map<int, VisitCounts> counts = await visits.countsFor(list);
    List<Map<String, dynamic>> rows = <Map<String, dynamic>>[];
    for (Link link in list) {
      rows.add(<String, dynamic>{
        ...LinkSerializer(link, urls).toJson(),
        ...counts[link.id]!.toJson(),
      });
    }
    return inertia(req, 'Links', <String, dynamic>{'links': rows});
  }

  /// POST /links. A bad form goes back with `errors`.
  Future<DoxResponse> store(DoxRequest req, CreateLink body) async {
    Link link = await links.create(_userId(req), body);
    Inertia.flash(req, 'message', 'Short link ${link.code} created');
    return redirect('/links');
  }

  /// PUT /links/{id}
  Future<DoxResponse> update(DoxRequest req, int id, UpdateLink body) async {
    Link link = await links.update(_userId(req), id, body);
    Inertia.flash(req, 'message', 'Short link ${link.code} saved');
    return redirect('/links');
  }

  /// DELETE /links/{id}
  Future<DoxResponse> destroy(DoxRequest req, int id) async {
    await links.delete(_userId(req), id);
    Inertia.flash(req, 'message', 'Short link deleted');
    return redirect('/links');
  }

  /// GET /links/{id}/stats
  Future<DoxResponse> dailyStats(DoxRequest req, int id) async {
    Link link = await links.find(_userId(req), id);
    return inertia(req, 'LinkStats', <String, dynamic>{
      'link': LinkSerializer(link, urls).toJson(),
      'stats': await stats.daily(link, AppConstants.defaultStatsDays),
    });
  }

  /// GET /links/{id}/qr.svg. `?download=1` saves it as a file.
  Future<DoxResponse> qrSvg(DoxRequest req, int id) async {
    Link link = await links.find(_userId(req), id);
    String svg = qr.render(urls.scan(link.code!), AppConstants.defaultQrSize);
    DoxResponse res = response(svg)
        .contentType(ContentType('image', 'svg+xml'));
    if (req.input('download') != null) {
      res.header(
        'Content-Disposition',
        'attachment; filename="qr-${link.code}.svg"',
      );
    }
    return res;
  }

  int _userId(DoxRequest req) {
    return req.auth!.user<User>()!.id!;
  }
}
