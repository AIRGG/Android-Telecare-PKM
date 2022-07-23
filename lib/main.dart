import 'dart:io';

import 'package:android_telecare_pkm/providers/login_user_provider.dart';
import 'package:android_telecare_pkm/providers/notification_provider.dart';
import 'package:android_telecare_pkm/routes.dart';
import 'package:android_telecare_pkm/screens/beranda/beranda_screen.dart';
import 'package:android_telecare_pkm/screens/login/login_screen.dart';
import 'package:android_telecare_pkm/screens/splash/splash_screen.dart';
import 'package:android_telecare_pkm/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

Future<void> _showNotification(RemoteMessage message) async {
// Future<void> _showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, 'plain title',
      'plain body ${message.notification!.body}', platformChannelSpecifics,
      payload: 'item x');
}

// Future<void> _showNotification(RemoteMessage message) async {
Future<void> _showNotification2(String msg) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin
      .show(0, 'plain title', msg, platformChannelSpecifics, payload: 'item x');
}

// void main() {
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(
  //     _showNotification); // ketika tidak membuka aplikasi
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // messaging.getToken().then((value) {
  //   print('-- TOKEN --');
  //   print(value);
  // });
  // FirebaseMessaging.onBackgroundMessage(_messageHandler);
  // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
  //   print("message recieved");
  //   print(event.notification!.body);
  //   _showNotification2(event.notification!.body.toString());
  // });
  // FirebaseMessaging.onMessage.listen(_showNotification);
  // FirebaseMessaging.onMessageOpenedApp.listen(_showNotification);

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  // String initialRoute = HomePage.routeName;
  // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   selectedNotificationPayload = notificationAppLaunchDetails!.payload;
  //   initialRoute = SecondPage.routeName;
  // }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/ic_launcher');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {
            didReceiveLocalNotificationSubject.add(
              ReceivedNotification(
                id: id,
                title: title,
                body: body,
                payload: payload,
              ),
            );
          });
  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('assets/icons/app_icon.png'),
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS,
    linux: initializationSettingsLinux,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectedNotificationPayload = payload;
    selectNotificationSubject.add(payload);
  });

  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginUserProvider>(
            create: (_) => LoginUserProvider()),
        ChangeNotifierProvider<NotificationProvider>(
            create: (_) => NotificationProvider()),
      ],
      // child: MyApp(notificationAppLaunchDetails),
      child: MyApp(flutterLocalNotificationsPlugin),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp(this.notificationAppLaunchDetails, {Key? key}) : super(key: key);
//   final NotificationAppLaunchDetails? notificationAppLaunchDetails;
//   bool get didNotificationLaunchApp =>
//       notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Telecare Apps',
//       theme: theme(),
//       home: MySecondPage(notificationAppLaunchDetails),
//       routes: routes,
//     );
//   }
// }

class MySecondPage extends StatefulWidget {
  MySecondPage(this.notificationAppLaunchDetails, {Key? key}) : super(key: key);
  final NotificationAppLaunchDetails? notificationAppLaunchDetails;
  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  late FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();
    // messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((value) {
    //   print(value);
    // });
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    //   print("message recieved");
    //   print(event.notification!.body);
    //   _showNotification2(event.notification!.body.toString());
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print('Message clicked!');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                  child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child:
                        Text('Tap on a notification when it appears to trigger'
                            ' navigation'),
                  ),
                  ElevatedButton(
                    child: Text('klik'),
                    onPressed: () async {
                      await _showNotification2('haii');
                    },
                  ),
                  // ElevatedButton(
                  //   child: Text('klik2'),
                  //   onPressed: () async {
                  //     await _testtt();
                  //   },
                  // ),
                ],
              )))),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp(this.notificationAppLaunchDetails, {Key? key}) : super(key: key);
//   final NotificationAppLaunchDetails? notificationAppLaunchDetails;

//   bool get didNotificationLaunchApp =>
//       notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

//   Future<void> _testtt() async {
//     late FirebaseMessaging messaging = FirebaseMessaging.instance;
//     messaging.getToken().then((value) {
//       print(value);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Telecare Apps',
//       theme: theme(),
//       // home: SplashScreen(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: SingleChildScrollView(
//             child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Center(
//                     child: Column(
//                   children: <Widget>[
//                     const Padding(
//                       padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
//                       child: Text(
//                           'Tap on a notification when it appears to trigger'
//                           ' navigation'),
//                     ),
//                     ElevatedButton(
//                       child: Text('klik'),
//                       onPressed: () async {
//                         await _showNotification();
//                       },
//                     ),
//                     ElevatedButton(
//                       child: Text('klik2'),
//                       onPressed: () async {
//                         await _testtt();
//                       },
//                     ),
//                   ],
//                 )))),
//       ),
//       routes: routes,
//     );
//   }

//   Future<void> _showNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics,
//         payload: 'item x');
//   }
// }

// class MyApp extends StatefulWidget {
//   MyApp(this.notificationAppLaunchDetails, {Key? key}) : super(key: key);

//   final NotificationAppLaunchDetails? notificationAppLaunchDetails;

//   bool get didNotificationLaunchApp =>
//       notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(child: Center(
//         child: ElevatedButton(child: Text('klik'), onPressed: ),
//       )),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp(this.flutterLocalNotificationsPlugin, {Key? key})
      : super(key: key);
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telecare Apps',
      theme: theme(),
      home: SplashScreen(flutterLocalNotificationsPlugin),
      routes: routes,
    );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Telecare Apps',
//       theme: theme(),
//       home: SplashScreen(),
//       routes: routes,
//     );
//   }
// }
