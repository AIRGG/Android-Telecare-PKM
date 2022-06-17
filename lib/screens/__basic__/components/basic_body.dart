import 'package:flutter/material.dart';

class BasicBody extends StatefulWidget {
  BasicBody({Key? key}) : super(key: key);

  @override
  State<BasicBody> createState() => _BasicBodyState();
}

class _BasicBodyState extends State<BasicBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Basic'),
    );
  }
}
