import 'package:android_telecare_pkm/models/login_user_model.dart';
import 'package:android_telecare_pkm/models/notification_model.dart';
import 'package:android_telecare_pkm/models/notification_user_model.dart';
import 'package:android_telecare_pkm/providers/login_user_provider.dart';
import 'package:android_telecare_pkm/providers/notification_provider.dart';
import 'package:android_telecare_pkm/providers/notification_user_provider.dart';
import 'package:android_telecare_pkm/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsBody extends StatefulWidget {
  NotificationsBody({Key? key}) : super(key: key);

  @override
  State<NotificationsBody> createState() => _NotificationsBodyState();
}

class _NotificationsBodyState extends State<NotificationsBody> {
  Future getNotification() async {
    var providerLoginUser =
        Provider.of<LoginUserProvider>(context, listen: false);
    var providerNotifUser =
        Provider.of<NotificationUserProvider>(context, listen: false);
    LoginUserModel itemUserLogin = providerLoginUser.itemUserLogin;
    try {
      String url = '/notification/${itemUserLogin.data!.id}';
      print(url);
      String res = await HttpUtil().reqget(url);
      NotificationUserModel notifuser = NotificationUserModel.fromRawJson(res);
      // print(res);
      providerNotifUser.itemNotification = notifuser;
      // setState(() {
      // });
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future removeNotif(Datum itemNotif) async {
    var providerNotifUser =
        Provider.of<NotificationUserProvider>(context, listen: false);
    var providerLoginUser =
        Provider.of<LoginUserProvider>(context, listen: false);
    try {
      String url = '/notification/mark-as-read';
      print(url);
      String res = await HttpUtil().req(url, body: {
        'user_id': providerLoginUser.itemUserLogin.data?.id,
        'id': itemNotif.id
      });
      // NotificationUserModel notifuser = NotificationUserModel.fromRawJson(res);
      // print(res);
      // providerNotifUser.itemNotification = notifuser;
      // setState(() {
      // });
      getNotification();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    NotificationProvider providerNotification =
        Provider.of<NotificationProvider>(context);
    List<NotificationModel> listNotif = providerNotification.listNotification;
    NotificationUserProvider providerNotifUser =
        Provider.of<NotificationUserProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: Colors.white,
      //   title: Text(
      //     "Notifications",
      //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //     // style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18),
      //   ),
      //   leading: IconButton(
      //       icon: Icon(
      //         Icons.arrow_back,
      //         // color: Colors.black,
      //       ),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       }),
      // ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return createNotificationListItem(providerNotifUser, index);
        },
        itemCount: providerNotifUser.itemNotification.data?.length ?? 0,
      ),
    );
  }

  createNotificationListItem(
      NotificationUserProvider providerNotification, int index) {
    // List<NotificationModel> listNotif = providerNotification.listNotification;
    // NotificationModel itemNotif = listNotif[index];
    List<Datum> listNotif = providerNotification.itemNotification.data ?? [];
    Datum _itemNotif = providerNotification.itemNotification.data![index];
    var itemNotif = _itemNotif.data;
    return Dismissible(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Container(
                width: 4,
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: Colors.red,
                ),
              ),
              flex: 02,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        itemNotif!.judulPesan.toString(),
                        style: TextStyle(fontWeight: FontWeight.w600),
                        // style: CustomTextStyle.textFormFieldBlack
                        //     .copyWith(color: Colors.black, fontSize: 16),
                      ),
                      // IconButton(
                      //     icon: Icon(Icons.close),
                      //     onPressed: () {
                      //       print("HAI");
                      //       getDummyList().removeAt(index);
                      //     }),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 6),
                    child: Text(
                      itemNotif.isiPesan.toString(),
                      softWrap: true,
                      textAlign: TextAlign.start,
                      // style: CustomTextStyle.textFormFieldMedium
                      //     .copyWith(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Divider(),
                ],
              ),
              flex: 98,
            )
          ],
        ),
      ),
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        // getDummyList().removeAt(index);
        listNotif.removeAt(index);
        removeNotif(_itemNotif);
      },
      background: Container(
        color: Colors.red,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }

  static List getDummyList() {
    List list = List.generate(10, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }
}
