import 'package:dox_core/dox_core.dart';
import 'package:dox_orm/dox_orm.dart';
import 'package:your_qr/app/http/dtos/link.dto.dart';
import 'package:your_qr/app/models/link/link.model.dart';
import 'package:your_qr/app/repositories/link.repository.dart';
import 'package:your_qr/app/support/random_code.dart';
import 'package:your_qr/constants/app_constants.dart';

/// Link logic: create, change, delete, and find a link by its code.
/// A user only ever sees their own links. Someone else's link is "not found".
@Inject()
class LinkService {
  final LinkRepository links;
  final RandomCode random;

  LinkService(this.links, this.random);

  Future<Pagination<Link>> paginate(int userId, int page, int perPage) async {
    return await links.paginateForUser(userId, page, perPage);
  }

  Future<List<Link>> listAll(int userId) async {
    return await links.listForUser(userId);
  }

  Future<Link> find(int userId, int id) async {
    Link? link = await links.findForUser(userId, id);
    if (link == null) {
      throw NotFoundHttpException(message: 'Link not found');
    }
    return link;
  }

  /// A custom code was already checked by the DTO (@Unique).
  Future<Link> create(int userId, CreateLink input) async {
    Link link = Link()
      ..userId = userId
      ..code = input.code ?? await _freeCode()
      ..url = input.url
      ..title = input.title
      ..expiresAt = input.expiresAt;
    return await links.save(link);
  }

  /// Only the keys that the client sent are changed.
  Future<Link> update(int userId, int id, UpdateLink input) async {
    Link link = await find(userId, id);
    if (input.url.isPresent) {
      link.url = input.url.value;
    }
    if (input.code.isPresent) {
      link.code = input.code.value;
    }
    if (input.title.isPresent) {
      link.title = input.title.value;
    }
    if (input.expiresAt.isPresent) {
      link.expiresAt = input.expiresAt.value;
    }
    return await links.save(link);
  }

  Future<void> delete(int userId, int id) async {
    Link link = await find(userId, id);
    await links.delete(link.id!);
  }

  /// The link for a public /s/ or /q/ visit.
  /// An unknown or expired code is "not found".
  Future<Link> resolve(String code) async {
    Link? link = await links.findByCode(code);
    DateTime? end = link?.expiresAt;
    if (link == null || (end != null && end.isBefore(DateTime.now()))) {
      throw NotFoundHttpException(message: 'Link not found');
    }
    return link;
  }

  /// A random code that no link uses yet.
  // ponytail: check then insert. Two requests can pick the same code at the
  // same moment; the unique index then fails one of them (very rare with
  // 57^7 codes). Retry on that error if it ever shows up.
  Future<String> _freeCode() async {
    for (int i = 0; i < AppConstants.codeTries; i++) {
      String code = random.shortCode();
      if (!await links.codeExists(code)) {
        return code;
      }
    }
    throw InternalErrorException(message: 'Could not find a free short code');
  }
}
