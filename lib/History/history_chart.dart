import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LiveChart());
  }
}

class LiveChart extends StatefulWidget {
  @override
  _LiveChartState createState() => _LiveChartState();
}

class _LiveChartState extends State<LiveChart> {
  Timer timer;
 
  List<_ChartData> ESP8266 = <_ChartData>[];
  Map<dynamic, dynamic> data;

  void _updateDataSource(Timer timer) {
    setState(() {
      ESP8266.add(_ChartData(
          x: DateTime.fromMillisecondsSinceEpoch(data['x']), y1: data['Temperature']['data']));
      // if(chartData.length >= 20){
      //   chartData.removeAt(0);
      // }    
    });

 
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _showChart());
  }

  Widget _showChart() {
    return StreamBuilder(
        stream: FirebaseDatabase()
            .reference()
            .child('ESP8266')
            .orderByChild('Temperature')
            .onValue,
        builder: (context, snapshot) {
          Widget widget;
          if (snapshot.hasData &&
              !snapshot.hasError &&
              snapshot.data.snapshot.value != null) {
            List<dynamic> values = snapshot.data.snapshot.value;

            widget = Container(
              child: SfCartesianChart(
                  tooltipBehavior: TooltipBehavior(enable: true),
                  primaryXAxis: DateTimeAxis(),
                  series: <LineSeries<_ChartData, DateTime>>[
                    LineSeries<_ChartData, DateTime>(
                        dataSource: ESP8266,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y1)
                  ]),
            );
          } else {
            widget = Center(child: CircularProgressIndicator());
          }

          return widget;
        });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}

class _ChartData {
  _ChartData({this.x, this.y1});
  final DateTime x;
  final int y1;
}
