import 'package:android_telecare_pkm/screens/beranda/beranda_screen.dart';
import 'package:android_telecare_pkm/screens/forget_password/forget_password_screen.dart';
import 'package:android_telecare_pkm/screens/forget_password_otp/forget_password_otp_screen.dart';
import 'package:android_telecare_pkm/screens/forget_password_reset/forget_password_reset_screen.dart';
import 'package:android_telecare_pkm/screens/login/login_screen.dart';
import 'package:android_telecare_pkm/screens/manage_user/manage_user_screen.dart';
import 'package:android_telecare_pkm/screens/manage_user_add/manage_user_add_screen.dart';
import 'package:android_telecare_pkm/screens/notifications/notifications_screen.dart';
import 'package:android_telecare_pkm/screens/pasien_profile/pasien_profile_screen.dart';
import 'package:android_telecare_pkm/screens/profile/profile_screen.dart';
import 'package:android_telecare_pkm/screens/register/register_screen.dart';
import 'package:android_telecare_pkm/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'screens/manage_user_detail/manage_user_detail_screen.dart';
import 'screens/riwayat_medis/riwayat_medis_screen.dart';

final Map<String, WidgetBuilder> routes = {
  // '/splash': (context) => SplashScreen(),
  '/login': (context) => LoginScreen(),
  '/forget-password': (context) => ForgetPasswordScreen(),
  '/forget-password-otp': (context) => ForgetPasswordOTPScreen(),
  '/forget-password-reset': (context) => ForgetPasswordResetScreen(),
  '/beranda': (context) => BerandaScreen(),
  '/profile': (context) => ProfileScreen(),
  '/manage-user': (context) => ManageUserScreen(),
  '/manage-user-add': (context) => ManageUserAddScreen(),
  '/manage-user-detail': (context) => ManageUserDetailScreen(),
  '/riwayat-medis': (context) => RiwayatMedisScreen(),
  '/notifications': (context) => NotificationsScreen(),
  '/register': (context) => RegisterScreen(),
  '/pasien': (context) => PasienProfileScreen(),
};
