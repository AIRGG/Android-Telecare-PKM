import 'dart:convert';

import 'package:android_telecare_pkm/models/manage_user_model.dart';
import 'package:android_telecare_pkm/providers/manage_user_provider.dart';
import 'package:android_telecare_pkm/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ManageUserBody extends StatefulWidget {
  ManageUserBody({Key? key}) : super(key: key);

  @override
  State<ManageUserBody> createState() => ManageUserBodyState();
}

class ManageUserBodyState extends State<ManageUserBody> {
  List<Datum> listUserModel = [];

  Future<void> handleGetListUser() async {
    try {
      String res = await HttpUtil().reqget("/user", body: {});
      ManageUserModel manageUserModel = ManageUserModel.fromRawJson(res);
      setState(() {
        listUserModel = manageUserModel.data ?? [];
      });
      print(res);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    handleGetListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              ProfileListItems(listUserModel, context),
            ],
          ),
        )
      ],
    );
  }
}

final kTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

class ProfileListItems extends StatelessWidget {
  const ProfileListItems(this.listUserModel, this.context, {Key? key})
      : super(key: key);
  final List<Datum> listUserModel;
  final BuildContext context;

  Future<void> handleDeleteUser(Datum itemUserModel) async {
    try {
      String res = await HttpUtil().req("/user/delete", body: {
        'id': itemUserModel.id,
      });
      print(res);
      Map<String, dynamic> jsn = json.decode(res);
      if (jsn['rcode'] == '000') {
        _alertWarning(jsn['msg'], true);
      } else {
        _alertWarning(jsn['msg'], false);
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  void _alertWarning(String msg, bool valid) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Pesan",
      desc: msg,
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => {
            Navigator.pop(context),
            if (valid)
              {
                Navigator.pop(context),
                Navigator.pushNamed(context, '/manage-user')
              }
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  void _alertConfirmation(Datum itemUserModel) {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Pesan",
      desc: "Yakin?",
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => {
            Navigator.pop(context),
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => {handleDeleteUser(itemUserModel)},
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    // var providerManageUser = Provider.of<ManageUserProvider>(context);
    // Datum itemManageUser = providerManageUser.itemManageUser;
    return Expanded(
      child: ListView.builder(
        itemCount: listUserModel.length,
        itemBuilder: (BuildContext context, int index) {
          Datum itemUserModel = listUserModel[index];
          return InkWell(
            onLongPress: () {
              _alertConfirmation(itemUserModel);
            },
            onTap: () => {
              Navigator.pushNamed(context, '/manage-user-detail',
                  arguments: {'item': itemUserModel})
            },
            child: ProfileListItem(
              icon: Icons.person,
              text: (itemUserModel.name).toString(),
              hasNavigation: false,
            ),
          );
        },        
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(
        horizontal: 10,
      ).copyWith(
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade300,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: 25,
          ),
          SizedBox(width: 15),
          Text(
            this.text,
            style: kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500, fontFamily: "Poppins"),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              Icons.arrow_left,
              size: 25,
            ),
        ],
      ),
    );
  }
}
