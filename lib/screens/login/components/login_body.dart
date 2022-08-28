import 'dart:convert';

import 'package:android_telecare_pkm/models/login_user_model.dart';
import 'package:android_telecare_pkm/providers/login_user_provider.dart';
import 'package:android_telecare_pkm/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBody extends StatefulWidget {
  LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String txt_email = '';
  String txt_password = '';

  void _alertWarning() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Login Gagal",
      desc: "Email atau Password Salah!",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  Future<void> handleLogin() async {
    var providerLoginUser =
        Provider.of<LoginUserProvider>(context, listen: false);
    LoginUserModel itemUserLogin;
    try {
      String res = await HttpUtil()
          .req("/login", body: {'email': txt_email, 'password': txt_password});
 
      itemUserLogin = LoginUserModel.fromRawJson(res);
      print('-- rcode --');
      print(itemUserLogin.rcode);
      if (itemUserLogin.rcode == '100') {
        _alertWarning();
        return;
      }

      providerLoginUser.itemUserLogin = itemUserLogin;
      final SharedPreferences prefs = await _prefs;
      // String itemJson = json.encode(itemUserLogin.toJson());
      await prefs.setString("user", itemUserLogin.toRawJson());
      String isi = prefs.getString("user").toString();
      Navigator.pushReplacementNamed(context, '/beranda');
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> handleLoginEx(LoginUserModel itemUserLogin) async {
    final SharedPreferences prefs = await _prefs;
    // String itemJson = json.encode(itemUserLogin.toJson());
    await prefs.setString("user", itemUserLogin.toRawJson());
    String isi = prefs.getString("user").toString();
    print(isi);
    Navigator.pushNamedAndRemoveUntil(context, '/beranda', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var providerLoginUser = Provider.of<LoginUserProvider>(context);
    LoginUserModel itemUserLogin;

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50.0,
        child: Image.asset(
          'assets/imgs/logo2.png',
        ),
        // child: Image.network('https://picsum.photos/500?image=8'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (value) => {
        setState(() {
          txt_email = value;
        })
      },
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      onChanged: (value) => {
        setState(() {
          txt_password = value;
        })
      },
    );

    final testingButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          handleLogin();
        },
        padding: EdgeInsets.all(18),
        color: Colors.blue,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/forget-password');
      },
    );

    final registerLabel = FlatButton(
      child: Text(
        'Register',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
    );

    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          logo,
          SizedBox(height: 48.0),
          email,
          SizedBox(height: 8.0),
          password,
          SizedBox(height: 24.0),
          testingButton,
          forgotLabel,
          registerLabel,
        ],
      ),
    );
  }
}
