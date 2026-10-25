import 'package:dox_orm/dox_orm.dart';

part 'visit.model.g.dart';

/// One row in the `visits` table: one click or scan of a link.
/// Rows are never changed, so there is no `updated_at`.
@DoxModel(table: 'visits', updatedAt: null)
class Visit extends VisitGenerator {
  @Column()
  int? linkId;

  /// `click` or `scan`, see VisitSource.
  @Column()
  String? source;

  @Column()
  String? ipHash;

  @Column()
  String? userAgent;

  @Column()
  String? referer;
}
