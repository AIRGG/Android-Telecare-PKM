import 'package:android_telecare_pkm/models/login_user_model.dart';
import 'package:android_telecare_pkm/models/manage_user_model.dart';
import 'package:flutter/foundation.dart';

class ManageUserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late Datum _itemManageUser;

  Datum get itemManageUser => _itemManageUser;
  // set removeArticle(int idx) {
  //   _listArticle = _listArticle.removeAt(idx) as List<ArticleModel>;
  // }

  set itemManageUser(Datum isi) {
    _itemManageUser = isi;
    notifyListeners();
  }
}
