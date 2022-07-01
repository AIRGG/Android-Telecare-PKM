import 'package:android_telecare_pkm/screens/forget_password_reset/components/forget_password_reset_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class ForgetPasswordResetScreen extends StatefulWidget {
  ForgetPasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordResetScreen> createState() =>
      _ForgetPasswordResetScreenState();
}

class _ForgetPasswordResetScreenState extends State<ForgetPasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Reset Password'),
        ),
        body: ForgetPasswordResetBody());
  }
}
