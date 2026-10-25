import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/models/link/link.model.dart';
import 'package:your_qr/app/models/visit/visit.model.dart';
import 'package:your_qr/app/repositories/visit.repository.dart';
import 'package:your_qr/app/support/hasher.dart';
import 'package:your_qr/constants/app_constants.dart';

/// Click and scan totals of one link.
class VisitCounts {
  int clicks = 0;
  int scans = 0;

  Map<String, int> toJson() {
    return <String, int>{'clicks': clicks, 'scans': scans};
  }

  void add(String source, int total) {
    if (source == VisitSource.click) {
      clicks += total;
    } else if (source == VisitSource.scan) {
      scans += total;
    }
  }
}

/// What the browser told us about one visit.
class VisitInfo {
  final String? ip;
  final String? userAgent;
  final String? referer;

  VisitInfo({this.ip, this.userAgent, this.referer});
}

/// Saves visits and counts them.
@Inject()
class VisitService {
  final VisitRepository visits;
  final Hasher hasher;

  VisitService(this.visits, this.hasher);

  /// Saves one visit. The IP is hashed, never saved as it is.
  // ponytail: one insert before the redirect. Move it to a queue job
  // (dox_queue) if redirects ever need to be faster under heavy traffic.
  Future<void> record(Link link, String source, VisitInfo info) async {
    String? ip = info.ip;
    Visit visit = Visit()
      ..linkId = link.id
      ..source = source
      ..ipHash = ip == null ? null : hasher.keyedHash(ip)
      ..userAgent = _cut(info.userAgent)
      ..referer = _cut(info.referer);
    await visits.create(visit);
  }

  /// Totals per link id. Links with no visits get zeros.
  Future<Map<int, VisitCounts>> countsFor(List<Link> links) async {
    Map<int, VisitCounts> counts = <int, VisitCounts>{};
    List<int> ids = <int>[];
    for (Link link in links) {
      counts[link.id!] = VisitCounts();
      ids.add(link.id!);
    }
    for (Map<String, dynamic> row in await visits.countBySource(ids)) {
      int linkId = int.parse(row['link_id'].toString());
      counts[linkId]?.add(row['source'].toString(), _int(row['total']));
    }
    return counts;
  }

  int _int(Object? value) {
    return int.parse(value.toString());
  }

  /// Headers can be very long. Keep the first 1000 characters.
  String? _cut(String? text) {
    if (text == null || text.length <= 1000) {
      return text;
    }
    return text.substring(0, 1000);
  }
}
