import 'package:android_telecare_pkm/screens/register/components/register_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Pasien'),
      ),
      body: RegisterBody(),
    );
  }
}
