import 'package:android_telecare_pkm/screens/forget_password/components/forget_password_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text('Forget Password')),
      body: ForgetPasswordBody(),
    );

    // return Scaffold(
    //     appBar: AppBar(title: Text('Halaman Urtama')),
    //     // body: Center(
    //     //   child: Text('Hai'),
    //     // ),
    //     // body: Row(
    //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     //   children: [
    //     //     Text('Hi1'),
    //     //     Text('Hi2'),
    //     //   ],
    //     // )
    //     body: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text('Hi1'),
    //           ],
    //         ),
    //         Text('Hi2'),
    //       ],
    //     ));
  }
}
