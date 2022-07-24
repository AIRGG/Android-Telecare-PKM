import 'package:android_telecare_pkm/models/notification_model.dart';
import 'package:android_telecare_pkm/models/notification_user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  // List<NotificationUserModel> _listNotification = [];
  NotificationUserModel _itemNotification = NotificationUserModel();
  late FlutterLocalNotificationsPlugin _itemLocalNotification =
      FlutterLocalNotificationsPlugin();

  // List<NotificationUserModel> get listNotification => _listNotification;
  NotificationUserModel get itemNotification => _itemNotification;
  FlutterLocalNotificationsPlugin get itemLocalNotification =>
      _itemLocalNotification;

  // set listNotification(List<NotificationUserModel> isi) {
  //   _listNotification = isi;
  //   notifyListeners();
  // }

  set itemLocalNotification(FlutterLocalNotificationsPlugin isi) {
    _itemLocalNotification = isi;
    notifyListeners();
  }

  // set removeNotification(int idx) {
  //   _listNotification = _listNotification.removeAt(idx) as List<NotificationUserModel>;
  // }
  set itemNotification(NotificationUserModel isi) {
    _itemNotification = isi;
    notifyListeners();
  }
}
