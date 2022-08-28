import 'dart:async';
import 'dart:convert';

import 'package:android_telecare_pkm/models/login_user_model.dart';
import 'package:android_telecare_pkm/providers/login_user_provider.dart';
import 'package:android_telecare_pkm/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBody extends StatefulWidget {
  SplashBody(this.flutterLocalNotificationsPlugin, {Key? key})
      : super(key: key);
  final FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    var providerNotification =
        Provider.of<NotificationProvider>(context, listen: false);
    providerNotification.itemLocalNotification =
        widget.flutterLocalNotificationsPlugin!;
    startSplash();
  }

  Future<void> cekLogin() async {
    SharedPreferences prefs = await _prefs;
    String? _user = prefs.getString("user");
    if (_user != null) {
      LoginUserProvider providerLoginUser =
          Provider.of<LoginUserProvider>(context, listen: false);
      LoginUserModel itemUserLogin = LoginUserModel.fromRawJson(_user);
      providerLoginUser.itemUserLogin = itemUserLogin;
      Navigator.pushNamedAndRemoveUntil(context, '/beranda', (route) => false);
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  startSplash() async {
    var duration = const Duration(seconds: 7);
    return Timer(duration, () {
      // Navigator.pushReplacementNamed(context, "/login");
      cekLogin();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text('Develop by Telecare. v1.0'),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/imgs/logo1.png',
              height: 400,
              width: 400,
            ),
            // Image.network('https://picsum.photos/250?image=9')
          ],
        ),
      ],
    );
  }
}
