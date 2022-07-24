import 'dart:convert';

import 'package:android_telecare_pkm/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgetPasswordOTPBody extends StatefulWidget {
  ForgetPasswordOTPBody({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordOTPBody> createState() => _ForgetPasswordOTPBodyState();
}

class _ForgetPasswordOTPBodyState extends State<ForgetPasswordOTPBody> {
  String txt_otp = "";
  String txt_password = "";
  String txt_repassword = "";

  void _alertWarning(String msg, bool valid) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Pesan",
      desc: msg,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => {
            Navigator.pop(context),
            if (valid)
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (val) => false)
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  Future resetPassword() async {
    try {
      String url = '/reset-password';
      print(url);
      String res = await HttpUtil().req(url, body: {
        'password': txt_password,
        'password_confirmation': txt_repassword,
        'otp_code': txt_otp
      });
      // String res = await HttpUtil().req(url, body: {'email': 'alvinrayhan4@gmail.com'});
      print('-- resnya reset password --');
      print(res);
      Map<String, dynamic> jsn = json.decode(res);
      if (jsn['rcode'] == '000') {
        _alertWarning(jsn['msg'], true);
        return;
      } else {
        _alertWarning(jsn['msg'], false);
      }
      // setState(() {
      // });
    } catch (err) {
      print(err);
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset(
          'assets/imgs/logo2.png',
        ),
        // child: Image.network('https://picsum.photos/500?image=8'),
      ),
    );

    final input_otp = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value) => {txt_otp = value},
      decoration: InputDecoration(
        hintText: 'Code OTP..',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) => {txt_password = value},
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final repassword = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) => {txt_repassword = value},
      decoration: InputDecoration(
        hintText: 'Retype-Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final verifOTPButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          // itemUserLogin = LoginUserModel(
          //     username: 'budi',
          //     password: '123',
          //     role: 'user',
          //     name: 'Budiantoro');
          // providerLoginUser.itemUserLogin = itemUserLogin;
          // Navigator.pushReplacementNamed(context, '/beranda');
          // Navigator.pushNamed(context, '/forget-password-reset');
          resetPassword();
        },
        padding: EdgeInsets.all(18),
        color: Colors.blue,
        child: Text('Reset Password', style: TextStyle(color: Colors.white)),
      ),
    );

    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          logo,
          SizedBox(height: 48.0),
          input_otp,
          SizedBox(height: 24.0),
          password,
          SizedBox(height: 24.0),
          repassword,
          SizedBox(height: 24.0),
          verifOTPButton,
          // loginButtonAdmin,
          // forgotLabel,
        ],
      ),
    );
  }
}
