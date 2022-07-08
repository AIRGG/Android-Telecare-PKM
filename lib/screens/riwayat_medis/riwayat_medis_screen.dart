import 'package:android_telecare_pkm/screens/riwayat_medis/components/riwayat_medis_body.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:flutter/material.dart';

class RiwayatMedisScreen extends StatefulWidget {
  RiwayatMedisScreen({Key? key}) : super(key: key);

  @override
  State<RiwayatMedisScreen> createState() => _RiwayatMedisScreenState();
}

class _RiwayatMedisScreenState extends State<RiwayatMedisScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: null,
      body: RiwayatMedisBody(),
    );
  }
}
