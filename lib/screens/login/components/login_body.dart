import 'package:android_telecare_pkm/models/login_user_model.dart';
import 'package:android_telecare_pkm/providers/login_user_provider.dart';
import 'package:android_telecare_pkm/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
String? selectedNotificationPayload;
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

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

class LoginBody extends StatefulWidget {
  LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  Future<void> handleLogin() async {
    try {
      Map res = await HttpUtil().req("/login", body: {
        'email': 'alvinrayhan4@gmail.com',
        'password': 'heartware111'
      });
      print(res);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> _showNotification() async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectedNotificationPayload = payload;
      selectNotificationSubject.add(payload);
    });
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  Widget build(BuildContext context) {
    var providerLoginUser = Provider.of<LoginUserProvider>(context);
    LoginUserModel itemUserLogin;

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50.0,
        child: Image.asset(
          'assets/imgs/logo2.png',
        ),
        // child: Image.network('https://picsum.photos/500?image=8'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          itemUserLogin = LoginUserModel(
              username: 'budi',
              password: '123',
              role: 'user',
              name: 'Budiantoro');
          providerLoginUser.itemUserLogin = itemUserLogin;
          // Navigator.pushReplacementNamed(context, '/beranda');
          Navigator.pushNamedAndRemoveUntil(
              context, '/beranda', (route) => false);
        },
        padding: EdgeInsets.all(18),
        color: Colors.blue,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );
    final loginButtonAdmin = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          itemUserLogin = LoginUserModel(
              username: 'admin',
              password: '123',
              role: 'admin',
              name: 'Administrator');
          providerLoginUser.itemUserLogin = itemUserLogin;
          // Navigator.pushReplacementNamed(context, '/beranda');
          Navigator.pushNamedAndRemoveUntil(
              context, '/beranda', (route) => false);
        },
        padding: EdgeInsets.all(18),
        color: Colors.blue,
        child: Text('Log In Admin', style: TextStyle(color: Colors.white)),
      ),
    );
    final testingButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          // handleLogin();
          _showNotification();
        },
        padding: EdgeInsets.all(18),
        color: Colors.blue,
        child: Text('Log In Admin', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/forget-password');
        // Navigator.pushReplacementNamed(context, '/forget-password');
      },
    );

    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          logo,
          SizedBox(height: 48.0),
          email,
          SizedBox(height: 8.0),
          password,
          SizedBox(height: 24.0),
          loginButton,
          loginButtonAdmin,
          testingButton,
          forgotLabel,
        ],
      ),
    );
  }
}
