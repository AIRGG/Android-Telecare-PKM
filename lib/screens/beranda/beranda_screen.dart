import 'package:android_telecare_pkm/screens/beranda/components/beranda_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class BerandaScreen extends StatefulWidget {
  BerandaScreen({Key? key}) : super(key: key);

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: null,
      body: BerandaBody(),
    );
  }
}
