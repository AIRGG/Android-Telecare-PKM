import 'dart:async';

import 'package:flutter/material.dart';

class SplashBody extends StatefulWidget {
  SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  @override
  void initState() {
    super.initState();
    startSplash();
  }

  startSplash() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text('Develop by Telecare. v1.0'),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network('https://picsum.photos/250?image=9')
          ],
        ),
      ],
    );
  }
}
