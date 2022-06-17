import 'package:android_telecare_pkm/screens/splash/components/splash_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: null,
      body: SplashBody(),
    );
  }
}
