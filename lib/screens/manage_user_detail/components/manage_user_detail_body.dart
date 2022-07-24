import 'package:android_telecare_pkm/models/manage_user_model.dart';
import 'package:android_telecare_pkm/providers/manage_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Color kAppPrimaryColor = Colors.grey.shade200;
Color kWhite = Colors.white;
Color kLightBlack = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCL = Colors.grey.shade600;

IconData twitter = IconData(0xe900, fontFamily: "CustomIcons");
IconData facebook = IconData(0xe901, fontFamily: "CustomIcons");
IconData googlePlus = IconData(0xe902, fontFamily: "CustomIcons");
IconData linkedin = IconData(0xe903, fontFamily: "CustomIcons");

const kSpacingUnit = 10;

final kTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

BoxDecoration avatarDecoration =
    BoxDecoration(shape: BoxShape.circle, color: kAppPrimaryColor, boxShadow: [
  BoxShadow(
    color: kWhite,
    offset: Offset(10, 10),
    blurRadius: 10,
  ),
  BoxShadow(
    color: kWhite,
    offset: Offset(-10, -10),
    blurRadius: 10,
  ),
]);

class ManageUserDetailBody extends StatefulWidget {
  ManageUserDetailBody({Key? key}) : super(key: key);

  @override
  State<ManageUserDetailBody> createState() => _ManageUserDetailBodyState();
}

class _ManageUserDetailBodyState extends State<ManageUserDetailBody> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    // print(arguments['item']);
    Datum itemManageUser = arguments['item'];
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              AvatarImage(),
              SizedBox(height: 30),
              Text(
                (itemManageUser.name).toString(),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins"),
              ),
              Text(
                (itemManageUser.email).toString(),
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 15),
              Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
              ),
              SizedBox(height: 30),
              ProfileListItems(),
            ],
          ),
        )
      ],
    );
  }
}

class AvatarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      decoration: avatarDecoration,
      child: Container(
        decoration: avatarDecoration,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(
                  'https://randomuser.me/api/portraits/lego/5.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileListItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          InkWell(
            onTap: () => {
              // Navigator.pushReplacementNamed(context, '/login')
            },
            child: ProfileListItem(
              icon: Icons.clear,
              text: 'Delete',
              hasNavigation: false,
            ),
          ),
        ],
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
        color: Colors.red[400],
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: 25,
            color: Colors.white,
          ),
          SizedBox(width: 15),
          Text(
            this.text,
            style: kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: "Poppins"),
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
