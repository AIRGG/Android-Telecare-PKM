import 'package:flutter/material.dart';

class ManageUserBody extends StatefulWidget {
  ManageUserBody({Key? key}) : super(key: key);

  @override
  State<ManageUserBody> createState() => ManageUserBodyState();
}

class ManageUserBodyState extends State<ManageUserBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Hi manage user'),
      ),
    );
  }
}
