import 'dart:convert';

import 'package:android_telecare_pkm/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterBody extends StatefulWidget {
  RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  bool checkForm = false;
  String name = '';
  String username = '';
  String handphone = '';
  String jenis_kelamin = '';
  String tanggal_lahir = '';
  String email = '';
  String password = '';
  String repassword = '';
  // bool is_admin = false;

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
              {
                Navigator.pop(context),
                Navigator.pop(context),
                Navigator.pushNamed(context, '/manage-user')
              }
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  Future<void> handleAddUser() async {
    try {
      String res = await HttpUtil().req("/register", body: {
        'name': name,
        'username': username,
        'handphone': handphone,
        'email': email,
        'password': password,
        'password_confirmation': repassword,
        'jenis_kelamin' : jenis_kelamin,
        'tanggal_lahir' : tanggal_lahir,
        // 'is_admin': '1',
      });
      print(res);
      Map<String, dynamic> jsn = json.decode(res);
      if (jsn['rcode'] == '000') {
        _alertWarning(jsn['msg'], true);
      } else {
        _alertWarning(jsn['msg'], false);
      }
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
        child: Image.asset('assets/imgs/logo2.png'),
      ),
    );

    final txt_username = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value) => {username = value},
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final txt_nama = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value) => {name = value},
      decoration: InputDecoration(
        hintText: 'Nama Lengkap',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final txt_email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onChanged: (value) => {email = value},
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final txt_nohp = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value) => {handphone = value},
      decoration: InputDecoration(
        hintText: 'NoHp',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final radio_jenis_kelamin = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value) => {jenis_kelamin = value},
      decoration: InputDecoration(
        hintText: 'Jenis Kelamin',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final date_tanggal_lahir = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value) => {tanggal_lahir = value},
      decoration: InputDecoration(
        hintText: 'Tanggal Lahir',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final txt_password = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) => {password = value},
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final txt_retypepassword = TextFormField(
      autofocus: false,
      obscureText: true,
      onChanged: (value) => {repassword = value},
      decoration: InputDecoration(
        hintText: 'Retype-Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final saveButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          handleAddUser();
        },
        padding: EdgeInsets.all(18),
        color: Colors.blue,
        child: Text('Save', style: TextStyle(color: Colors.white)),
      ),
    );

    return Container(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
          SizedBox(height: 24.0),
          logo,
          SizedBox(height: 48.0),
          txt_nama,
          SizedBox(height: 8.0),
          txt_nohp,
          SizedBox(height: 8.0),
          radio_jenis_kelamin,
          SizedBox(height: 8.0),
          date_tanggal_lahir,
          SizedBox(height: 8.0),
          txt_email,
          SizedBox(height: 8.0),
          txt_username,
          SizedBox(height: 8.0),
          txt_password,
          SizedBox(height: 8.0),
          txt_retypepassword,
          // SizedBox(height: 8.0),
          // CheckboxListTile(
          //   title: Text('Sebagai Admin'),
          //   onChanged: (value) {
          //     setState(() {
          //       is_admin = !is_admin;
          //     });
          //   },
          //   controlAffinity: ListTileControlAffinity.leading,
          //   value: is_admin,
          // ),
          SizedBox(height: 24.0),
          saveButton,
        ]));
  }
}
