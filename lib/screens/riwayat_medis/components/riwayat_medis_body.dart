import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RiwayatMedisBody extends StatefulWidget {
  RiwayatMedisBody({Key? key}) : super(key: key);

  @override
  State<RiwayatMedisBody> createState() => _RiwayatMedisBodyState();
}

class _RiwayatMedisBodyState extends State<RiwayatMedisBody> {
  Timer? _timer;
  List<_ChartData>? _chartData;
  String suhuDropdownValue = '1 Hari';
  String jantungDropdownValue = '1 Hari';
  String oksigenDropdownValue = '1 Hari';
  String ecgDropdownValue = '1 Hari';

  // List of items in our dropdown menu
  var suhuItems = [
    '1 Hari',
    '1 Minggu',
    '1 Bulan',
  ];

  var jantungItems = [
    '1 Hari',
    '1 Minggu',
    '1 Bulan',
  ];

  var oksigenItems = [
    '1 Hari',
    '1 Minggu',
    '1 Bulan',
  ];

  var ecgItems = [
    '1 Hari',
    '1 Minggu',
    '1 Bulan',
  ];

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   children: <Widget>[
    //     Padding(
    //       padding: EdgeInsets.all(25),
    //       child: Column(
    //         children: <Widget>[
    //           // SizedBox(height: 30),
    //           Text('Hi X')
    //         ],
    //       ),
    //     )
    //   ],
    // );
    _getChartData();
    // _timer = Timer(const Duration(seconds: 2), () {
    //   setState(() {
    //     _getChartData();
    //   });
    // });

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
                },
              ),
            ],
          )
        ],
      ),
      SizedBox(height: 10),
      _buildAnimationLineChart(),
      SizedBox(height: 50.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
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
                },
              ),
            ],
          )
        ],
      ),
      _buildAnimationLineChart(),
      SizedBox(height: 50.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
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
                },
              ),
            ],
          )
        ],
      ),
      _buildAnimationLineChart(),
      SizedBox(height: 50.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text('Saturasi Oksigen',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              DropdownButton(
                // Initial Value
                value: ecgDropdownValue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: ecgItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    ecgDropdownValue = newValue!;
                    print(newValue);
                  });
                },
              ),
            ],
          )
        ],
      ),
      _buildAnimationLineChart(),
      SizedBox(height: 50.0),
    ]));
  }

  ///Get the cartesian chart with line series
  SfCartesianChart _buildAnimationLineChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis:
            NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
            majorTickLines: const MajorTickLines(color: Colors.transparent),
            axisLine: const AxisLine(width: 0),
            minimum: 0,
            maximum: 100),
        series: _getDefaultLineSeries());
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          dataSource: _chartData!,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _chartData!.clear();
  }

  int _getRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }

  void _getChartData() {
    _chartData = <_ChartData>[];
    for (int i = 0; i < 11; i++) {
      _chartData!.add(_ChartData(i, _getRandomInt(5, 95)));
    }
    _timer?.cancel();
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final int x;
  final int y;
}
