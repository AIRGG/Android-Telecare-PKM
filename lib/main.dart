import 'package:android_telecare_pkm/screens/login/login_screen.dart';
import 'package:android_telecare_pkm/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  // runApp(MultiProvider(providers: const [], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telecare Apps',
      theme: theme(),
      home: const LoginScreen(),
    );
  }
}
