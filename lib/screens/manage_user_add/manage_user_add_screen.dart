import 'package:android_telecare_pkm/screens/manage_user_add/components/manage_user_add_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class ManageUserAddScreen extends StatefulWidget {
  ManageUserAddScreen({Key? key}) : super(key: key);

  @override
  State<ManageUserAddScreen> createState() => _ManageUserAddScreenState();
}

class _ManageUserAddScreenState extends State<ManageUserAddScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: ManageUserAddBody(),
    );
  }
}
