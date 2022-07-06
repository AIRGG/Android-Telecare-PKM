import 'package:android_telecare_pkm/screens/manage_user_detail/components/manage_user_detail_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class ManageUserDetailScreen extends StatefulWidget {
  ManageUserDetailScreen({Key? key}) : super(key: key);

  @override
  State<ManageUserDetailScreen> createState() => _ManageUserDetailScreenState();
}

class _ManageUserDetailScreenState extends State<ManageUserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: ManageUserDetailBody(),
    );
  }
}
