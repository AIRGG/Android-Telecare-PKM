import 'package:android_telecare_pkm/screens/beranda/beranda_screen.dart';
import 'package:android_telecare_pkm/screens/login/login_screen.dart';
import 'package:android_telecare_pkm/screens/manage_user/manage_user_screen.dart';
import 'package:android_telecare_pkm/screens/profile/profile_screen.dart';
import 'package:android_telecare_pkm/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/beranda': (context) => BerandaScreen(),
  '/profile': (context) => ProfileScreen(),
  '/manage-user': (context) => ManageUserScreen(),
};
