import 'package:flutter/material.dart';

class ForgetPasswordResetBody extends StatefulWidget {
  ForgetPasswordResetBody({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordResetBody> createState() =>
      _ForgetPasswordResetBodyState();
}

class _ForgetPasswordResetBodyState extends State<ForgetPasswordResetBody> {
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

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final repassword = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Retype-Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final resetButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
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
          password,
          SizedBox(height: 8.0),
          repassword,
          SizedBox(height: 24.0),
          resetButton,
        ],
      ),
    );
  }
}
