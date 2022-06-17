import 'package:android_telecare_pkm/models/login_user_model.dart';
import 'package:android_telecare_pkm/providers/login_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BerandaBody extends StatefulWidget {
  BerandaBody({Key? key}) : super(key: key);

  @override
  State<BerandaBody> createState() => _BerandaBodyState();
}

class _BerandaBodyState extends State<BerandaBody> {
  @override
  Widget build(BuildContext context) {
    var providerLoginUser = Provider.of<LoginUserProvider>(context);
    LoginUserModel? itemUserLogin;
    itemUserLogin = providerLoginUser.itemUserLogin;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(providerLoginUser.itemUserLogin.name),
          Text(itemUserLogin.name),
          Text(itemUserLogin.role),

          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Logout')),

          if (itemUserLogin.role == 'admin') ...[
            ElevatedButton(
                onPressed: () {
                  print('Halo admin');
                },
                child: Text('Tombol Khusus Admin'))
          ]
        ],
      ),
    );
  }
}
