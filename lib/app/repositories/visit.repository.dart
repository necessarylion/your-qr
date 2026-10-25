import 'package:dox_orm/dox_orm.dart';
import 'package:your_qr/app/models/visit/visit.model.dart';

/// All database access for visits.
@Inject()
class VisitRepository {
  /// One insert. Fast enough to run before the redirect.
  Future<void> create(Visit visit) async {
    await visit.save();
  }

  /// Rows of `link_id`, `source` and `total` for these links.
  Future<List<Map<String, dynamic>>> countBySource(List<int> linkIds) async {
    if (linkIds.isEmpty) {
      return <Map<String, dynamic>>[];
    }
    List<dynamic> rows = await QueryBuilder.table('visits')
        .selectRaw('link_id, source, count(*) as total')
        .whereIn('link_id', linkIds)
        .groupBy(<String>['link_id', 'source'])
        .get();
    return List<Map<String, dynamic>>.from(rows);
  }

  /// Rows of `day` (YYYY-MM-DD, UTC), `source` and `total` since [since].
  /// Uses the (link_id, created_at) index.
  Future<List<Map<String, dynamic>>> countPerDay(
    int linkId,
    DateTime since,
  ) async {
    List<dynamic> rows = await QueryBuilder.table('visits')
        .selectRaw(
          "to_char(created_at AT TIME ZONE 'UTC', 'YYYY-MM-DD') as day, "
          'source, count(*) as total',
        )
        .where('link_id', linkId)
        .where('created_at', '>=', since.toUtc())
        .groupByRaw('day, source')
        .get();
    return List<Map<String, dynamic>>.from(rows);
  }
}
