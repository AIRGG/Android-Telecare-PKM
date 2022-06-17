import 'package:android_telecare_pkm/models/login_user_model.dart';
import 'package:flutter/foundation.dart';

class LoginUserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late LoginUserModel _itemUserLogin;

  LoginUserModel get itemUserLogin => _itemUserLogin;
  // set removeArticle(int idx) {
  //   _listArticle = _listArticle.removeAt(idx) as List<ArticleModel>;
  // }

  set itemUserLogin(LoginUserModel isi) {
    _itemUserLogin = isi;
    notifyListeners();
  }
}
