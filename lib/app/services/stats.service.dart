import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/models/link/link.model.dart';
import 'package:your_qr/app/repositories/visit.repository.dart';
import 'package:your_qr/app/services/visit.service.dart';

/// Clicks and scans per day for one link.
@Inject()
class StatsService {
  final VisitRepository visits;

  StatsService(this.visits);

  /// The last [days] days (UTC), today included. Days with no visits are 0.
  ///
  /// `{"days": 30, "totals": {"clicks": 3, "scans": 1},
  ///   "daily": [{"date": "2026-10-25", "clicks": 3, "scans": 1}, ...]}`
  Future<Map<String, dynamic>> daily(Link link, int days) async {
    DateTime now = DateTime.now().toUtc();
    DateTime today = DateTime.utc(now.year, now.month, now.day);
    DateTime first = today.subtract(Duration(days: days - 1));

    /// one entry per day, oldest first
    Map<String, VisitCounts> perDay = <String, VisitCounts>{};
    for (int i = 0; i < days; i++) {
      perDay[_day(first.add(Duration(days: i)))] = VisitCounts();
    }

    VisitCounts totals = VisitCounts();
    for (Map<String, dynamic> row in await visits.countPerDay(
      link.id!,
      first,
    )) {
      String source = row['source'].toString();
      int total = int.parse(row['total'].toString());
      perDay[row['day'].toString()]?.add(source, total);
      totals.add(source, total);
    }

    List<Map<String, dynamic>> daily = <Map<String, dynamic>>[];
    for (MapEntry<String, VisitCounts> entry in perDay.entries) {
      daily.add(<String, dynamic>{'date': entry.key, ...entry.value.toJson()});
    }
    return <String, dynamic>{
      'days': days,
      'totals': totals.toJson(),
      'daily': daily,
    };
  }

  /// YYYY-MM-DD
  String _day(DateTime date) {
    return date.toIso8601String().substring(0, 10);
  }
}
