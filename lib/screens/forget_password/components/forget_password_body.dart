import 'package:flutter/material.dart';

class ForgetPasswordBody extends StatefulWidget {
  ForgetPasswordBody({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.network('https://picsum.photos/500?image=8'),
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
          Navigator.pushNamed(context, '/forget-password-otp');
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
