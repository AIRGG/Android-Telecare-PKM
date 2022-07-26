import 'dart:async';
import 'dart:ffi';
import 'dart:math' as math;

import 'package:android_telecare_pkm/models/login_user_model.dart';
import 'package:android_telecare_pkm/models/monitor_dashboard_model.dart';
import 'package:android_telecare_pkm/models/notification_user_model.dart';
import 'package:android_telecare_pkm/providers/login_user_provider.dart';
import 'package:android_telecare_pkm/providers/notification_user_provider.dart';
import 'package:android_telecare_pkm/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BerandaBody extends StatefulWidget {
  BerandaBody({Key? key}) : super(key: key);

  @override
  State<BerandaBody> createState() => _BerandaBodyState();
}

class _BerandaBodyState extends State<BerandaBody> {
  Timer? timer;
  Timer? timerDashboard;
  List<_ChartData>? chartData;
  late int count;
  ChartSeriesController? _chartSeriesController;
  MonitorDashboardModel? monitorDashboardModel;
  double? monitorSuhu = 0;
  int? monitorHeartrate = 0;
  int? monitorSaturasi = 0;
  double? bawahSuhu = 0;
  double? atasSuhu = 0;
  double? bawahHeartrate = 0;
  double? atasHeartrate = 0;
  double? saturasi = 0;

  @override
  void dispose() {
    timer?.cancel();
    timerDashboard?.cancel();
    chartData!.clear();
    _chartSeriesController = null;
    super.dispose();
  }

  @override
  void initState() {
    timer =
        Timer.periodic(const Duration(milliseconds: 100), _updateDataSource);
    timerDashboard = Timer.periodic(const Duration(seconds: 15), getDashboard);
    count = 19;
    chartData = <_ChartData>[
      _ChartData(0, 42),
      _ChartData(1, 47),
      _ChartData(2, 33),
      _ChartData(3, 49),
      _ChartData(4, 54),
      _ChartData(5, 41),
      _ChartData(6, 58),
      _ChartData(7, 51),
      _ChartData(8, 98),
      _ChartData(9, 41),
      _ChartData(10, 53),
      _ChartData(11, 72),
      _ChartData(12, 86),
      _ChartData(13, 52),
      _ChartData(14, 94),
      _ChartData(15, 92),
      _ChartData(16, 86),
      _ChartData(17, 72),
      _ChartData(18, 94),
    ];
    getDashboard(timerDashboard!);
    super.initState();
  }

  /// Returns the realtime Cartesian line chart.
  SfCartesianChart get _buildLiveLineChart {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis:
            NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0)),
        series: <LineSeries<_ChartData, int>>[
          LineSeries<_ChartData, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: chartData!,
            color: const Color.fromRGBO(192, 108, 132, 1),
            xValueMapper: (_ChartData sales, _) => sales.country,
            yValueMapper: (_ChartData sales, _) => sales.sales,
            animationDuration: 0,
          )
        ]);
  }

  ///Continously updating the data source based on timer
  void _updateDataSource(Timer timer) {
    chartData!.add(_ChartData(count, _getRandomInt(10, 100)));
    if (chartData!.length == 20) {
      chartData!.removeAt(0);
      _chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[chartData!.length - 1],
        removedDataIndexes: <int>[0],
      );
    } else {
      _chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[chartData!.length - 1],
      );
    }
    count = count + 1;
  }

  ///Get the random data
  int _getRandomInt(int min, int max) {
    final math.Random random = math.Random();
    return min + random.nextInt(max - min);
  }

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
      providerNotifUser.itemNotification = notifuser;
      // print(res);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future getDashboard(Timer timer) async {
    try {
      String url = '/medis/realtime/ajax';
      print(url);
      String res = await HttpUtil().reqget(url);
      print(res);
      setState(() {
        monitorDashboardModel = MonitorDashboardModel.fromRawJson(res);
        print(monitorDashboardModel?.data?.suhu?.value);
        monitorSuhu = (monitorDashboardModel?.data?.suhu?.value)!.toDouble();
        monitorHeartrate =
            (monitorDashboardModel?.data?.heartrate?.value)!.toInt();
        monitorSaturasi =
            (monitorDashboardModel?.data?.saturasi?.value)!.toInt();

        bawahSuhu = double.parse(
            (monitorDashboardModel?.data?.batas?.bawahSuhu).toString());
        atasSuhu = double.parse(
            (monitorDashboardModel?.data?.batas?.atasSuhu).toString());
        bawahHeartrate = double.parse(
            (monitorDashboardModel?.data?.batas?.bawahHeartrate).toString());
        atasHeartrate = double.parse(
            (monitorDashboardModel?.data?.batas?.atasHeartrate).toString());
        saturasi = double.parse(
            (monitorDashboardModel?.data?.batas?.saturasi).toString());
        // monitorSuhu = double.parse((monitorDashboardModel?.data?.suhu?.value).toString());
        // monitorHeartrate = int.parse(
        //     (monitorDashboardModel?.data?.heartrate?.value).toString());
        // monitorSaturasi = int.parse(
        //     (monitorDashboardModel?.data?.saturasi?.value).toString());
      });
    } catch (err) {
      print(err);
      // throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    var providerLoginUser = Provider.of<LoginUserProvider>(context);
    LoginUserModel? itemUserLogin;
    itemUserLogin = providerLoginUser.itemUserLogin;

    return Container(
      child: ListView(
        children: [
          // ElevatedButton(
          //     onPressed: () => {getDashboard()}, child: Text('Notif')),
          SizedBox(
            height: 24,
          ),
          // SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Suhu Tubuh',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SuhuImage(),
              Column(
                children: [
                  Text(
                    '${monitorSuhu.toString()}\u2103',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Status: ${((monitorSuhu ?? 0) >= bawahSuhu! && (monitorSuhu ?? 0) <= atasSuhu!) ? 'Baik' : 'Bahaya'}')
                ],
              )
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Denyut Jantung',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DenyutImage(),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${monitorHeartrate.toString()}',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'bpm',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                      'Status: ${((monitorHeartrate ?? 0) >= bawahHeartrate! && (monitorSuhu ?? 0) <= atasHeartrate!) ? 'Baik' : 'Bahaya'}')
                ],
              )
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Saturasi Oksigen',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SaturasiImage(),
              Column(
                children: [
                  Text(
                    '${monitorSaturasi.toString()}%',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Status: ${((monitorSaturasi ?? 0) >= saturasi!) ? 'Baik' : 'Bahaya'}')
                ],
              )
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ECG',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: _buildLiveLineChart,
          )
        ],
      ),
    );
    // return Container(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       // Text(providerLoginUser.itemUserLogin.name),
    //       Text(itemUserLogin.name),
    //       Text(itemUserLogin.role),

    //       ElevatedButton(
    //           onPressed: () {
    //             Navigator.pushReplacementNamed(context, '/login');
    //           },
    //           child: Text('Logout')),

    //       if (itemUserLogin.role == 'admin') ...[
    //         ElevatedButton(
    //             onPressed: () {
    //               print('Halo admin');
    //             },
    //             child: Text('Tombol Khusus Admin'))
    //       ]
    //     ],
    //   ),
    // );
  }
}

class _ChartData {
  _ChartData(this.country, this.sales);
  final int country;
  final num sales;
}

// -- Image Dll -- \\
Color kAppPrimaryColor = Colors.grey.shade200;
Color kWhite = Colors.white;
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

class SuhuImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/icons/suhu.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class DenyutImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/icons/denyut.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class SaturasiImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/icons/saturasi.png'),
            ),
          ),
        ),
      ),
    );
  }
}


// class AvatarImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150,
//       height: 150,
//       padding: EdgeInsets.all(8),
//       decoration: avatarDecoration,
//       child: Container(
//         decoration: avatarDecoration,
//         padding: EdgeInsets.all(3),
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: DecorationImage(
//               image: NetworkImage(
//                   'https://randomuser.me/api/portraits/lego/6.jpg'),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }