import 'dart:io';

import 'package:dox_core/dox_core.dart';
import 'package:dox_orm/dox_orm.dart';
import 'package:your_qr/app/dtos/link/link.dto.dart';
import 'package:your_qr/app/http/serializers/link.serializer.dart';
import 'package:your_qr/app/models/link/link.model.dart';
import 'package:your_qr/app/models/user/user.model.dart';
import 'package:your_qr/app/services/link.service.dart';
import 'package:your_qr/app/services/stats.service.dart';
import 'package:your_qr/app/support/link_urls.dart';
import 'package:your_qr/app/support/qr_svg.dart';

/// The REST API for links. Every route needs an API key, and only
/// shows the links of the key owner.
@Inject()
class LinkApiController {
  final LinkService links;
  final StatsService stats;
  final LinkUrls urls;
  final QrSvg qr;

  LinkApiController(this.links, this.stats, this.urls, this.qr);

  /// List your links
  ///
  /// Newest first.
  Future<Map<String, dynamic>> index(DoxRequest req, ListLinks query) async {
    Pagination<Link> page = await links.paginate(
      _userId(req),
      query.page,
      query.perPage,
    );
    return <String, dynamic>{
      ...page.toJson(),
      'data': LinkSerializer(page.data, urls).toJson(),
    };
  }

  /// Create a short link
  ///
  /// Leave `code` out for a random code.
  @Response(201, LinkSerializer, description: 'The new link')
  Future<DoxResponse> store(DoxRequest req, CreateLink body) async {
    Link link = await links.create(_userId(req), body);
    return response(LinkSerializer(link, urls)).statusCode(201);
  }

  /// Get one link
  Future<LinkSerializer> show(DoxRequest req, int id) async {
    return LinkSerializer(await links.find(_userId(req), id), urls);
  }

  /// Change a link
  ///
  /// Only the keys you send are changed.
  Future<LinkSerializer> update(DoxRequest req, int id, UpdateLink body) async {
    return LinkSerializer(await links.update(_userId(req), id, body), urls);
  }

  /// Delete a link
  ///
  /// Its visits are deleted too.
  Future<Map<String, String>> destroy(DoxRequest req, int id) async {
    await links.delete(_userId(req), id);
    return <String, String>{'message': 'Link deleted'};
  }

  /// QR code (SVG)
  ///
  /// The QR code opens /q/{code}, so each scan is counted.
  Future<DoxResponse> qrSvg(DoxRequest req, int id, QrOptions query) async {
    Link link = await links.find(_userId(req), id);
    String svg = qr.render(urls.scan(link.code!), query.size);
    return response(svg).contentType(ContentType('image', 'svg+xml'));
  }

  /// Clicks and scans per day
  Future<Map<String, dynamic>> dailyStats(
    DoxRequest req,
    int id,
    StatsOptions query,
  ) async {
    Link link = await links.find(_userId(req), id);
    return await stats.daily(link, query.days);
  }

  int _userId(DoxRequest req) {
    return req.auth!.user<User>()!.id!;
  }
}
