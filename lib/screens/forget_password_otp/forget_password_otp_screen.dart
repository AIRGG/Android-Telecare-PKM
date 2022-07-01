import 'package:android_telecare_pkm/screens/forget_password_otp/components/forget_password_otp_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class ForgetPasswordOTPScreen extends StatefulWidget {
  ForgetPasswordOTPScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordOTPScreen> createState() =>
      _ForgetPasswordOTPScreenState();
}

class _ForgetPasswordOTPScreenState extends State<ForgetPasswordOTPScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text('Forget Password OTP')),
      body: ForgetPasswordOTPBody(),
    );
  }
}
