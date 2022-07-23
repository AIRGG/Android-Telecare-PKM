import 'package:android_telecare_pkm/models/notification_model.dart';
import 'package:android_telecare_pkm/providers/notification_provider.dart';
import 'package:android_telecare_pkm/screens/splash/components/splash_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(this.flutterLocalNotificationsPlugin, {Key? key})
      : super(key: key);
  final FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
//   Future<void> _showNotification(RemoteMessage message) async {
// // Future<void> _showNotification() async {
//     var providerNotification =
//         Provider.of<NotificationProvider>(context, listen: false);
//     NotificationModel notifModel = NotificationModel();
//     List<NotificationModel> listNotifModel =
//         providerNotification.listNotification;
//     notifModel.title = message.notification?.title;
//     notifModel.body = message.notification?.body;
//     listNotifModel.add(notifModel);
//     providerNotification.listNotification = listNotifModel;
//     print("HERE BOSS");
//     print(providerNotification.listNotification.length);
//     print(listNotifModel.length);

//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await widget.flutterLocalNotificationsPlugin?.show(0, 'plain title',
//         'plain body ${message.notification!.body}', platformChannelSpecifics,
//         payload: 'item x');
//   }

  @override
  void initState() {
    super.initState();
    // var providerNotification =
    //     Provider.of<NotificationProvider>(context, listen: false);
    // providerNotification.itemLocalNotification =
    //     widget.flutterLocalNotificationsPlugin!;
    // FirebaseMessaging.onBackgroundMessage(
    //     _showNotification); // ketika tidak membuka aplikasi
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((value) {
    //   print('-- TOKEN --');
    //   print(value);
    // });
    // // FirebaseMessaging.onBackgroundMessage(_messageHandler);
    // // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    // //   print("message recieved");
    // //   print(event.notification!.body);
    // //   _showNotification2(event.notification!.body.toString());
    // // });
    // FirebaseMessaging.onMessage.listen(_showNotification);
    // FirebaseMessaging.onMessageOpenedApp.listen(_showNotification);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: null,
      body: SplashBody(widget.flutterLocalNotificationsPlugin),
    );
  }
}
