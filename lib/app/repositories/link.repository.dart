import 'package:dox_orm/dox_orm.dart';
import 'package:your_qr/app/models/link/link.model.dart';

/// All database access for links.
@Inject()
class LinkRepository {
  Future<Link> save(Link link) async {
    await link.save();
    return link;
  }

  Future<Link?> findByCode(String code) async {
    return await Link().where('code', code).getFirst();
  }

  Future<bool> codeExists(String code) async {
    return await Link().where('code', code).count() > 0;
  }

  /// Only finds a link of this user.
  Future<Link?> findForUser(int userId, int id) async {
    return await Link().where('id', id).where('user_id', userId).getFirst();
  }

  /// Newest first.
  Future<Pagination<Link>> paginateForUser(
    int userId,
    int page,
    int perPage,
  ) async {
    return await Link()
        .where('user_id', userId)
        .orderBy('id', 'desc')
        .paginate(currentPage: page, perPage: perPage);
  }

  /// Newest first.
  Future<List<Link>> listForUser(int userId) async {
    return await Link().where('user_id', userId).orderBy('id', 'desc').get();
  }

  Future<void> delete(int id) async {
    await Link().where('id', id).delete();
  }
}
