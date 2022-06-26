import 'package:android_telecare_pkm/screens/manage_user/components/manage_user_body.dart';
import 'package:flutter/material.dart';

class ManageUserScreen extends StatefulWidget {
  ManageUserScreen({Key? key}) : super(key: key);

  @override
  State<ManageUserScreen> createState() => _ManageUserScreenState();
}

class _ManageUserScreenState extends State<ManageUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: ManageUserBody(),
    );
  }
}
