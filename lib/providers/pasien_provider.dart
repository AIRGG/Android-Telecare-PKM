import 'package:android_telecare_pkm/models/pasien_model.dart';
import 'package:android_telecare_pkm/utils/http_util.dart';
import 'package:flutter/foundation.dart';

class PasienProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late PasienModel _itemPasien;

  PasienModel get itemPasien => _itemPasien;
  // set removeArticle(int idx) {
  //   _listArticle = _listArticle.removeAt(idx) as List<ArticleModel>;
  // }

  set itemPasien(PasienModel isi) {
    _itemPasien = isi;
    notifyListeners();
  }

  getPasienData() async {
    try {
      String url = '/pasien';
      print(url);
      String res = await HttpUtil().reqget(url);
      print('-- resnya token --');
      print(res);
      // setState(() {
      // });
      itemPasien = PasienModel.fromRawJson(res);
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
