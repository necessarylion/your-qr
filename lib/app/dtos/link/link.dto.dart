import 'package:dox_core/dox_core.dart';
import 'package:dox_orm/dox_orm.dart' hide Schema;
import 'package:your_qr/constants/app_constants.dart';

part 'link.dto.g.dart';

/// Body of POST /api/links and of the dashboard "new link" form.
@Dto()
class CreateLink {
  /// Where the short link goes. Must start with http:// or https://.
  @Trim()
  @Url()
  @MaxLength(2048)
  final String url;

  /// Your own short code. Letters, numbers, `-` and `_`.
  /// Empty: a random code is made.
  @Trim()
  @Regex(AppConstants.customCodePattern)
  @Unique('links', column: 'code')
  final String? code;

  @Trim()
  @MaxLength(255)
  final String? title;

  /// After this time the link gives 404. Empty: never.
  @After('now')
  final DateTime? expiresAt;

  const CreateLink({required this.url, this.code, this.title, this.expiresAt});

  static const DtoSchema<CreateLink> schema = $CreateLinkDto;
}

/// Body of PATCH /api/links/{id} and of the dashboard "edit link" form.
/// Only the keys you send are changed. Send `null` to clear title or
/// expires_at.
@Dto()
class UpdateLink {
  @Trim()
  @Url()
  @MaxLength(2048)
  final Maybe<String> url;

  @Trim()
  @Regex(AppConstants.customCodePattern)
  @Unique('links', column: 'code', ignoreParam: 'id')
  final Maybe<String> code;

  @Trim()
  @MaxLength(255)
  final Maybe<String?> title;

  @After('now')
  final Maybe<DateTime?> expiresAt;

  const UpdateLink({
    this.url = const Maybe<String>.missing(),
    this.code = const Maybe<String>.missing(),
    this.title = const Maybe<String?>.missing(),
    this.expiresAt = const Maybe<DateTime?>.missing(),
  });

  static const DtoSchema<UpdateLink> schema = $UpdateLinkDto;
}

/// Query of GET /api/links.
@Dto(source: Source.query)
class ListLinks {
  @Min(1)
  final int page;

  @Range(1, AppConstants.maxPerPage)
  final int perPage;

  const ListLinks({this.page = 1, this.perPage = AppConstants.defaultPerPage});

  static const DtoSchema<ListLinks> schema = $ListLinksDto;
}

/// Query of GET /api/links/{id}/qr.svg.
@Dto(source: Source.query)
class QrOptions {
  /// Width and height in pixels.
  @Range(AppConstants.minQrSize, AppConstants.maxQrSize)
  final int size;

  const QrOptions({this.size = AppConstants.defaultQrSize});

  static const DtoSchema<QrOptions> schema = $QrOptionsDto;
}

/// Query of GET /api/links/{id}/stats.
@Dto(source: Source.query)
class StatsOptions {
  /// How many days back, today included.
  @Range(1, AppConstants.maxStatsDays)
  final int days;

  const StatsOptions({this.days = AppConstants.defaultStatsDays});

  static const DtoSchema<StatsOptions> schema = $StatsOptionsDto;
}
