import 'package:android_telecare_pkm/providers/login_user_provider.dart';
import 'package:android_telecare_pkm/routes.dart';
import 'package:android_telecare_pkm/screens/beranda/beranda_screen.dart';
import 'package:android_telecare_pkm/screens/login/login_screen.dart';
import 'package:android_telecare_pkm/screens/splash/splash_screen.dart';
import 'package:android_telecare_pkm/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

void main() {
  // runApp(const MyApp());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginUserProvider>(
        create: (_) => LoginUserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: SplashScreen(),
      routes: routes,
    );
  }
}
