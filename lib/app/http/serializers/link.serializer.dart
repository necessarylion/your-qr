import 'package:dox_core/dox_core.dart';
import 'package:your_qr/app/models/link/link.model.dart';
import 'package:your_qr/app/support/link_urls.dart';

/// Public shape of a link, with its short URLs.
class LinkSerializer extends Serializer<Link> {
  final LinkUrls urls;

  LinkSerializer(super.data, this.urls);

  @override
  Map<String, dynamic> convert(Link m) {
    return <String, dynamic>{
      'id': m.id,
      'code': m.code,
      'url': m.url,
      'title': m.title,
      'short_url': urls.click(m.code!),
      'qr_url': urls.scan(m.code!),
      'expires_at': m.expiresAt?.toUtc().toIso8601String(),
      'created_at': m.createdAt?.toUtc().toIso8601String(),
      'updated_at': m.updatedAt?.toUtc().toIso8601String(),
    };
  }
}
