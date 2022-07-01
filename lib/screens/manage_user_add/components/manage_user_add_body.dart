import 'package:flutter/material.dart';

class ManageUserAddBody extends StatefulWidget {
  ManageUserAddBody({Key? key}) : super(key: key);

  @override
  State<ManageUserAddBody> createState() => _ManageUserAddBodyState();
}

class _ManageUserAddBodyState extends State<ManageUserAddBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
          SizedBox(height: 24.0),
          logo,
          SizedBox(height: 48.0),
          txt_username,
          SizedBox(height: 8.0),
          txt_nama,
          SizedBox(height: 8.0),
          txt_email,
          SizedBox(height: 8.0),
          txt_password,
          SizedBox(height: 8.0),
          txt_retypepassword,
          SizedBox(height: 24.0),
          saveButton,
        ]));
  }
}

final logo = Hero(
  tag: 'hero',
  child: CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: 48.0,
    child: Image.network('https://picsum.photos/500?image=8'),
  ),
);

final txt_username = TextFormField(
  keyboardType: TextInputType.text,
  autofocus: false,
  decoration: InputDecoration(
    hintText: 'Username',
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  ),
);

final txt_nama = TextFormField(
  keyboardType: TextInputType.text,
  autofocus: false,
  decoration: InputDecoration(
    hintText: 'Nama Lengkap',
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  ),
);

final txt_email = TextFormField(
  keyboardType: TextInputType.emailAddress,
  autofocus: false,
  decoration: InputDecoration(
    hintText: 'Email',
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  ),
);

final txt_password = TextFormField(
  autofocus: false,
  obscureText: true,
  decoration: InputDecoration(
    hintText: 'Password',
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  ),
);

final txt_retypepassword = TextFormField(
  autofocus: false,
  obscureText: true,
  decoration: InputDecoration(
    hintText: 'Retype-Password',
    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  ),
);

final saveButton = Padding(
  padding: EdgeInsets.symmetric(vertical: 16.0),
  child: RaisedButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    onPressed: () {},
    padding: EdgeInsets.all(18),
    color: Colors.blue,
    child: Text('Save', style: TextStyle(color: Colors.white)),
  ),
);
