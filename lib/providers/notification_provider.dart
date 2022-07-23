import 'package:android_telecare_pkm/models/notification_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<NotificationModel> _listNotification = [];
  late NotificationModel _itemNotification;
  late FlutterLocalNotificationsPlugin _itemLocalNotification =
      FlutterLocalNotificationsPlugin();

  List<NotificationModel> get listNotification => _listNotification;
  NotificationModel get itemNotification => _itemNotification;
  FlutterLocalNotificationsPlugin get itemLocalNotification =>
      _itemLocalNotification;

  set listNotification(List<NotificationModel> isi) {
    _listNotification = isi;
    notifyListeners();
  }

  set itemLocalNotification(FlutterLocalNotificationsPlugin isi) {
    _itemLocalNotification = isi;
    notifyListeners();
  }

  // set removeNotification(int idx) {
  //   _listNotification = _listNotification.removeAt(idx) as List<NotificationModel>;
  // }

  set itemNotification(NotificationModel isi) {
    _itemNotification = isi;
    notifyListeners();
  }
}
