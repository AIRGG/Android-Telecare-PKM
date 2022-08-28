import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:android_telecare_pkm/utils/http_util.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RiwayatMedisBody extends StatefulWidget {
  RiwayatMedisBody({Key? key}) : super(key: key);

  @override
  State<RiwayatMedisBody> createState() => _RiwayatMedisBodyState();
}

class _RiwayatMedisBodyState extends State<RiwayatMedisBody> {
  Timer? _timer;
  List<_ChartData> _chartDataSuhu = [];
  List<_ChartData> _chartDataHeartrate = [];
  List<_ChartData> _chartDataSaturasi = [];
  // List<_ChartData>? _chartData;
  String suhuDropdownValue = '1 Hari';
  String jantungDropdownValue = '1 Hari';
  String oksigenDropdownValue = '1 Hari';
  String ecgDropdownValue = '1 Hari';

  // List of items in our dropdown menu
  var suhuItems = [
    '1 Hari',
    '3 Hari',
    '7 Hari',
  ];

  var jantungItems = [
    '1 Hari',
    '3 Hari',
    '7 Hari',
  ];

  var oksigenItems = [
    '1 Hari',
    '3 Hari',
    '7 Hari',
  ];

  var ecgItems = [
    '1 Hari',
    '3 Hari',
    '7 Hari',
  ];

  Future<void> handleGetSuhu(
      {String tipe = 'suhu', String ket = 'day', hari = '1'}) async {
    String url = 'medis/riwayat/${tipe}/${hari}';
    try {
      print(url);
      String resp = await HttpUtil().reqget("/" + url, body: {});
      setState(() {
        if (tipe == 'suhu') _chartDataSuhu = <_ChartData>[];
        if (tipe == 'heartrate') _chartDataHeartrate = <_ChartData>[];
        if (tipe == 'saturasi') _chartDataSaturasi = <_ChartData>[];
      });
      if (resp.length == 2) return;
      print('- disini --');
      print(resp);
      Map<String, dynamic> res = json.decode(resp);
      setState(() {
        if (tipe == 'suhu') _chartDataSuhu = <_ChartData>[];
        if (tipe == 'heartrate') _chartDataHeartrate = <_ChartData>[];
        if (tipe == 'saturasi') _chartDataSaturasi = <_ChartData>[];
        for (var i = 0; i < res.length; i++) {
          _ChartData dt = _ChartData(res.keys.toList()[i].toString(),
              res.values.toList()[i].toDouble());
          if (tipe == 'suhu') _chartDataSuhu.add(dt);
          if (tipe == 'heartrate') _chartDataHeartrate.add(dt);
          if (tipe == 'saturasi') _chartDataSaturasi.add(dt);
        }
      });
    } catch (err) {
      print(err);
      throw err;
    }
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, String>> _getDefaultLineSeries(
      {String kat = 'suhu'}) {
    print('SINI !');

    List<_ChartData> _chartData = _chartDataSuhu;
    if (kat == 'suhu') _chartData = _chartDataSuhu;
    if (kat == 'jantung') _chartData = _chartDataHeartrate;
    if (kat == 'oksigen') _chartData = _chartDataSaturasi;
    return <LineSeries<_ChartData, String>>[
      LineSeries<_ChartData, String>(
          dataSource: _chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          markerSettings: const MarkerSettings(isVisible: false))
    ];
  }

  ///Get the cartesian chart with line series
  SfCartesianChart _buildAnimationLineChart({String kat = 'suhu'}) {
    double minskala = 0;
    double maxskala = 0;
    if (kat == 'suhu') {
      minskala = 34;
      maxskala = 40;
    }
    if (kat == 'jantung') {
      minskala = 30;
      maxskala = 150;
    }
    if (kat == 'oksigen') {
      minskala = 0;
      maxskala = 100;
    }
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(labelRotation: 90),
        primaryYAxis: NumericAxis(
            majorTickLines:
                const MajorTickLines(size: 0, color: Colors.transparent),
            axisLine: const AxisLine(width: 0),
            minimum: minskala,
            maximum: maxskala),
        series: _getDefaultLineSeries(kat: kat));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    handleGetSuhu(tipe: 'suhu', hari: '1');
    handleGetSuhu(tipe: 'heartrate', hari: '1');
    handleGetSuhu(tipe: 'saturasi', hari: '1');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: [
      SizedBox(height: 50.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text('Suhu Tubuh',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              DropdownButton(
                // Initial Value
                value: suhuDropdownValue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: suhuItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    suhuDropdownValue = newValue!;
                    print(newValue);
                  });
                  handleGetSuhu(
                      tipe: 'suhu', ket: 'day', hari: newValue!.split(' ')[0]);
                },
              ),
            ],
          )
        ],
      ),
      SizedBox(height: 10),
      _buildAnimationLineChart(kat: "suhu"),
      SizedBox(height: 50.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // ElevatedButton(
              //   onPressed: () => {handleGetSuhu(tipe: 'heartrate', ket: 'day')},
              //   child: Text('Heart day'),
              // ),
              // ElevatedButton(
              //   onPressed: () =>
              //       {handleGetSuhu(tipe: 'heartrate', ket: 'week')},
              //   child: Text('Heart week'),
              // ),
              // ElevatedButton(
              //   onPressed: () =>
              //       {handleGetSuhu(tipe: 'heartrate', ket: 'month')},
              //   child: Text('Heart month'),
              // ),
              Text('Denyut Jantung',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              DropdownButton(
                // Initial Value
                value: jantungDropdownValue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: jantungItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    jantungDropdownValue = newValue!;
                    print(newValue);
                  });
                  handleGetSuhu(
                      tipe: 'heartrate',
                      ket: 'day',
                      hari: newValue!.split(' ')[0]);
                },
              ),
            ],
          )
        ],
      ),
      _buildAnimationLineChart(kat: "jantung"),
      SizedBox(height: 50.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // ElevatedButton(
              //   onPressed: () => {handleGetSuhu(tipe: 'saturasi', ket: 'day')},
              //   child: Text('Saturasi day'),
              // ),
              // ElevatedButton(
              //   onPressed: () => {handleGetSuhu(tipe: 'saturasi', ket: 'week')},
              //   child: Text('Saturasi week'),
              // ),
              // ElevatedButton(
              //   onPressed: () =>
              //       {handleGetSuhu(tipe: 'saturasi', ket: 'month')},
              //   child: Text('Saturasi month'),
              // ),
              Text('Saturasi Oksigen',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              DropdownButton(
                // Initial Value
                value: oksigenDropdownValue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: oksigenItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    oksigenDropdownValue = newValue!;
                    print(newValue);
                  });
                  handleGetSuhu(
                      tipe: 'saturasi',
                      ket: 'day',
                      hari: newValue!.split(' ')[0]);
                },
              ),
            ],
          )
        ],
      ),
      _buildAnimationLineChart(kat: "oksigen"),
      SizedBox(height: 50.0),
    ]));
    // return Container(
    //   child: _buildAnimationLineChart(kat: "oksigen"),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    // _chartData.clear();
    // _chartData!.clear();
  }

  int _getRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }

  // void _getChartData() {
  //   _chartData = <_ChartData>[];
  //   List arr = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K'];
  //   for (int i = 0; i < 11; i++) {
  //     // _chartData!.add(_ChartData(i.toString(), _getRandomInt(35, 40)));
  //     // _chartData!.add(_ChartData(arr[i], _getRandomInt(35, 40)));
  //   }
  //   _timer?.cancel();
  // }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}
