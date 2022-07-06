import 'package:flutter/material.dart';

class ForgetPasswordOTPBody extends StatefulWidget {
  ForgetPasswordOTPBody({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordOTPBody> createState() => _ForgetPasswordOTPBodyState();
}

class _ForgetPasswordOTPBodyState extends State<ForgetPasswordOTPBody> {
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
      keyboardType: TextInputType.number,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Code..',
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
          Navigator.pushNamed(context, '/forget-password-reset');
        },
        padding: EdgeInsets.all(18),
        color: Colors.blue,
        child: Text('Verify', style: TextStyle(color: Colors.white)),
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
          verifOTPButton,
          // loginButtonAdmin,
          // forgotLabel,
        ],
      ),
    );
  }
}
