import 'package:flutter/material.dart';

class ManageUserBody extends StatefulWidget {
  ManageUserBody({Key? key}) : super(key: key);

  @override
  State<ManageUserBody> createState() => ManageUserBodyState();
}

class ManageUserBodyState extends State<ManageUserBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: <Widget>[
              // SizedBox(height: 30),
              ProfileListItems(),
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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          InkWell(
            onTap: () => {
              // Navigator.pushReplacementNamed(context, '/login')
              Navigator.pushNamed(context, '/manage-user-detail')
            },
            child: ProfileListItem(
              icon: Icons.person,
              text: 'Budiantoro',
              hasNavigation: false,
            ),
          ),
          InkWell(
            onTap: () => {
              // Navigator.pushReplacementNamed(context, '/login')
              Navigator.pushNamed(context, '/manage-user-detail')
            },
            child: ProfileListItem(
              icon: Icons.person,
              text: 'Bambang',
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
