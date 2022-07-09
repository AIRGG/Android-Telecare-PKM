import 'package:android_telecare_pkm/models/login_user_model.dart';
import 'package:android_telecare_pkm/providers/login_user_provider.dart';
import 'package:android_telecare_pkm/screens/beranda/components/beranda_body.dart';
import 'package:android_telecare_pkm/screens/manage_user/manage_user_screen.dart';
import 'package:android_telecare_pkm/screens/profile/profile_screen.dart';
import 'package:android_telecare_pkm/screens/riwayat_medis/components/riwayat_medis_body.dart';
import 'package:android_telecare_pkm/screens/riwayat_medis/riwayat_medis_screen.dart';
import 'package:android_telecare_pkm/size_config.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BerandaScreen extends StatefulWidget {
  BerandaScreen({Key? key}) : super(key: key);

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen>
    with TickerProviderStateMixin {
  var _bottomNavIndex = 0; //default index of first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.home,
    // Icons.person,
    Icons.list
  ];

  final widgetList = <Widget>[BerandaBody(), RiwayatMedisScreen()];
  // final widgetList = <Widget>[BerandaBody(), ProfileScreen()];

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var providerLoginUser = Provider.of<LoginUserProvider>(context);
    LoginUserModel? itemUserLogin;
    itemUserLogin = providerLoginUser.itemUserLogin;
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitoring'),
        // backgroundColor: HexColor('#235997')
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
              Navigator.pushNamed(context, '/profile');
            },
          )
        ],
      ),
      // appBar: null,
      // body: NavigationScreen(
      //   iconList[_bottomNavIndex],
      // ),
      body: widgetList[_bottomNavIndex],
      floatingActionButton: (itemUserLogin.role == 'admin')
          ? ScaleTransition(
              scale: animation,
              child: FloatingActionButton(
                elevation: 8,
                backgroundColor: HexColor('#FFA400'),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  _animationController.reset();
                  Navigator.pushNamed(context, '/manage-user');
                  _animationController.forward();
                },
              ),
            )
          : null,
      floatingActionButtonLocation: (itemUserLogin.role == 'admin')
          ? FloatingActionButtonLocation.centerDocked
          : null,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        // backgroundColor: HexColor('#235997'),
        backgroundColor: Colors.blue,
        activeIndex: _bottomNavIndex,
        // activeColor: Colors.amber,
        activeColor: HexColor('#FFA400'),
        // splashColor: HexColor('#FFA400'),
        inactiveColor: Colors.white,
        notchAndCornersAnimation: animation,
        // splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
      // floatingActionButton:
      //     FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: AnimatedBottomNavigationBar(
      //   icons: iconList,
      //   activeIndex: _bottomNavIndex,
      //   gapLocation: GapLocation.center,
      //   notchSmoothness: NotchSmoothness.verySmoothEdge,
      //   leftCornerRadius: 32,
      //   rightCornerRadius: 32,
      //   onTap: (index) => setState(() => _bottomNavIndex = index),
      //   //other params
      // ),
      // body:
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton:
      //     FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      // bottomNavigationBar: BottomAppBar(
      //     shape: CircularNotchedRectangle(),
      //     child: Container(
      //       height: 56,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: <Widget>[
      //           IconButton(icon: Icon(Icons.home), onPressed: () {}),
      //           SizedBox(width: 40), // The dummy child
      //           IconButton(icon: Icon(Icons.person), onPressed: () {}),
      //         ],
      //       ),
      //     )),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  NavigationScreen(this.iconData) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: Icon(
          widget.iconData,
          color: HexColor('#FFA400'),
          size: 160,
        ),
        // child: CircularRevealAnimation(
        //   animation: animation,
        //   centerOffset: Offset(80, 80),
        //   maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
        //   child: Icon(
        //     widget.iconData,
        //     color: HexColor('#FFA400'),
        //     size: 160,
        //   ),
        // ),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
