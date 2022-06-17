import 'package:android_telecare_pkm/screens/__basic__/components/basic_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class BasicScreen extends StatefulWidget {
  const BasicScreen({Key? key}) : super(key: key);

  @override
  _BasicScreenState createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: null,
      body: BasicBody(),
    );
  }
}
