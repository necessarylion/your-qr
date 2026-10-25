import 'package:dox_orm/dox_orm.dart';

part 'link.model.g.dart';

/// One row in the `links` table.
@DoxModel(table: 'links')
class Link extends LinkGenerator {
  @Column()
  int? userId;

  /// The short code: /s/{code} and /q/{code}.
  @Column()
  String? code;

  /// Where the short link goes.
  @Column()
  String? url;

  @Column()
  String? title;

  /// After this time the short link gives 404. Null: never.
  @Column()
  DateTime? expiresAt;
}
