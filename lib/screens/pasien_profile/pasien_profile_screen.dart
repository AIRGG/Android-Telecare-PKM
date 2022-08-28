import 'package:android_telecare_pkm/screens/pasien_profile/components/pasien_profile_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class PasienProfileScreen extends StatefulWidget {
  PasienProfileScreen({Key? key}) : super(key: key);

  @override
  State<PasienProfileScreen> createState() => _PasienProfileScreenState();
}

class _PasienProfileScreenState extends State<PasienProfileScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text('Profil Pasien')),
      body: PasienProfileBody(),
    );
  }
}
