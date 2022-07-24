import 'dart:convert';

import 'package:android_telecare_pkm/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgetPasswordBody extends StatefulWidget {
  ForgetPasswordBody({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  String txt_email = "";

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
            if (valid) Navigator.pushNamed(context, '/forget-password-otp')
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  Future sendEmail() async {
    try {
      String url = '/forget-password';
      print(url);
      String res = await HttpUtil().req(url, body: {'email': txt_email});
      // String res = await HttpUtil().req(url, body: {'email': 'alvinrayhan4@gmail.com'});
      print('-- resnya forget password --');
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

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onChanged: (value) => {txt_email = value},
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final sendemailButton = Padding(
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
          // Navigator.pushNamed(context, '/forget-password-otp');
          sendEmail();
        },
        padding: EdgeInsets.all(18),
        color: Colors.blue,
        child: Text('Send email', style: TextStyle(color: Colors.white)),
      ),
    );

    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          logo,
          SizedBox(height: 48.0),
          email,
          SizedBox(height: 24.0),
          sendemailButton,
          // loginButtonAdmin,
          // forgotLabel,
        ],
      ),
    );
    // return Center(
    //   child: Text('Hai'),
    // );
  }
}
