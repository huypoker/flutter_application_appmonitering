import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_appmonitering/History/dt_button.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryChart extends StatefulWidget {
  @override
  _HistoryChartState createState() => _HistoryChartState();
}

class _HistoryChartState extends State<HistoryChart> {
  final dbref = FirebaseDatabase.instance.reference();
  List<Record> tempData = [];
  List<Record> speedData = [];
  List<Record> phData = [];
  List<Record> tdsData = [];
  List<Record> flowData = [];

  ChartSeriesController tempController;
  ChartSeriesController speedController;
  ChartSeriesController phController;
  ChartSeriesController tdsController;
  ChartSeriesController flowController;

  bool isRealtime = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();

    DateTime current = DateTime.now();
    int num = current.hour*4 + (current.minute/15).round();

    for (var i = num; i >= 0; i--) {
      tempData.add(Record(Random().nextInt(21)+20, DateTime.now().subtract(Duration(seconds: i*5))));
      speedData.add(Record(Random().nextInt(46)+15, DateTime.now().subtract(Duration(seconds: i*5))));
      phData.add(Record(Random().nextInt(16), DateTime.now().subtract(Duration(seconds: i*5))));
      tdsData.add(Record(Random().nextInt(401)+100, DateTime.now().subtract(Duration(seconds: i*5))));
      flowData.add(Record(Random().nextInt(36)+15, DateTime.now().subtract(Duration(seconds: i*5))));
    }
  }

  int currentTimestamp = 0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            SizedBox(height: 20),
            Center(child: DTButton(updateChartsStatus: updateChartsStatus,)),
            SizedBox(height: 20),
            isRealtime ? StreamBuilder(
              stream: dbref.child("ESP8266").onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && !snapshot.hasError && snapshot.data.snapshot.value != null) {
                  var timestamp = snapshot.data.snapshot.value["currentTimestamp"];
                  
                  if (currentTimestamp < timestamp) {
      
                    Data data = new Data(
                      temperature: snapshot.data.snapshot.value["Temperature"][timestamp.toString()],
                      speed: snapshot.data.snapshot.value["Speed"][timestamp.toString()],
                      ph: snapshot.data.snapshot.value["pH"][timestamp.toString()],
                      tds: snapshot.data.snapshot.value["TDS"][timestamp.toString()],
                      flow: snapshot.data.snapshot.value["Flow"][timestamp.toString()],
                    );
      
                    if (data.isNotNull()) {
                      updateData(data);
                      currentTimestamp = timestamp;
                    }
                  }
      
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SfCartesianChart( 
                          series: <LineSeries<Record, DateTime>>[
                            LineSeries<Record, DateTime>(
                              onRendererCreated: (ChartSeriesController controller) {
                                tempController = controller;
                              },
                              dataSource: tempData,
                              color: Colors.redAccent,
                              xValueMapper: (Record record, _) => record.timestamp,
                              yValueMapper: (Record record, _) => record.value
                            )
                          ],
                          primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat.jms(),
                            majorGridLines: MajorGridLines(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            interval: 3,
                            title: AxisTitle(text: 'Timestamp')
                          ),
                          primaryYAxis: NumericAxis(
                            axisLine: AxisLine(width: 0),
                            majorTickLines: MajorTickLines(size: 0),
                            title: AxisTitle(text: 'Temperature')
                          )
                        ),
                        SfCartesianChart( 
                          series: <LineSeries<Record, DateTime>>[
                            LineSeries<Record, DateTime>(
                              onRendererCreated: (ChartSeriesController controller) {
                                speedController = controller;
                              },
                              dataSource: speedData,
                              color: Colors.deepPurple,
                              xValueMapper: (Record record, _) => record.timestamp,
                              yValueMapper: (Record record, _) => record.value
                            )
                          ],
                          primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat.jms(),
                            majorGridLines: MajorGridLines(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            interval: 3,
                            title: AxisTitle(text: 'Timestamp')
                          ),
                          primaryYAxis: NumericAxis(
                            axisLine: AxisLine(width: 0),
                            majorTickLines: MajorTickLines(size: 0),
                            title: AxisTitle(text: 'Speed')
                          )
                        ),
                        SfCartesianChart( 
                          series: <LineSeries<Record, DateTime>>[
                            LineSeries<Record, DateTime>(
                              onRendererCreated: (ChartSeriesController controller) {
                                phController = controller;
                              },
                              dataSource: phData,
                              color: Colors.greenAccent,
                              xValueMapper: (Record record, _) => record.timestamp,
                              yValueMapper: (Record record, _) => record.value
                            )
                          ],
                          primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat.jms(),
                            majorGridLines: MajorGridLines(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            interval: 3,
                            title: AxisTitle(text: 'Timestamp')
                          ),
                          primaryYAxis: NumericAxis(
                            axisLine: AxisLine(width: 0),
                            majorTickLines: MajorTickLines(size: 0),
                            title: AxisTitle(text: 'pH')
                          )
                        ),
                        SfCartesianChart( 
                          series: <LineSeries<Record, DateTime>>[
                            LineSeries<Record, DateTime>(
                              onRendererCreated: (ChartSeriesController controller) {
                                tdsController = controller;
                              },
                              dataSource: tdsData,
                              color: Colors.orangeAccent,
                              xValueMapper: (Record record, _) => record.timestamp,
                              yValueMapper: (Record record, _) => record.value
                            )
                          ],
                          primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat.jms(),
                            majorGridLines: MajorGridLines(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            interval: 3,
                            title: AxisTitle(text: 'Timestamp')
                          ),
                          primaryYAxis: NumericAxis(
                            axisLine: AxisLine(width: 0),
                            majorTickLines: MajorTickLines(size: 0),
                            title: AxisTitle(text: 'TDS')
                          )
                        ),
                        SfCartesianChart( 
                          series: <LineSeries<Record, DateTime>>[
                            LineSeries<Record, DateTime>(
                              onRendererCreated: (ChartSeriesController controller) {
                                flowController = controller;
                              },
                              dataSource: flowData,
                              color: Colors.blueAccent,
                              xValueMapper: (Record record, _) => record.timestamp,
                              yValueMapper: (Record record, _) => record.value
                            )
                          ],
                          primaryXAxis: DateTimeAxis(
                            dateFormat: DateFormat.jms(),
                            majorGridLines: MajorGridLines(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            interval: 3,
                            title: AxisTitle(text: 'Timestamp')
                          ),
                          primaryYAxis: NumericAxis(
                            axisLine: AxisLine(width: 0),
                            majorTickLines: MajorTickLines(size: 0),
                            title: AxisTitle(text: 'Flow')
                          )
                        ),
                      ],
                    ),
                  );
                }
      
                return Container();
              }
            ) :
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SfCartesianChart( 
                    series: <LineSeries<Record, DateTime>>[
                      LineSeries<Record, DateTime>(
                        dataSource: tempData,
                        color: Colors.redAccent,
                        xValueMapper: (Record record, _) => record.timestamp,
                        yValueMapper: (Record record, _) => record.value
                      )
                    ],
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat.jms(),
                      majorGridLines: MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 3,
                      title: AxisTitle(text: 'Timestamp')
                    ),
                    primaryYAxis: NumericAxis(
                      axisLine: AxisLine(width: 0),
                      majorTickLines: MajorTickLines(size: 0),
                      title: AxisTitle(text: 'Temperature')
                    )
                  ),
                  SfCartesianChart( 
                    series: <LineSeries<Record, DateTime>>[
                      LineSeries<Record, DateTime>(
                        dataSource: speedData,
                        color: Colors.deepPurple,
                        xValueMapper: (Record record, _) => record.timestamp,
                        yValueMapper: (Record record, _) => record.value
                      )
                    ],
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat.jms(),
                      majorGridLines: MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 3,
                      title: AxisTitle(text: 'Timestamp')
                    ),
                    primaryYAxis: NumericAxis(
                      axisLine: AxisLine(width: 0),
                      majorTickLines: MajorTickLines(size: 0),
                      title: AxisTitle(text: 'Speed')
                    )
                  ),
                  SfCartesianChart( 
                    series: <LineSeries<Record, DateTime>>[
                      LineSeries<Record, DateTime>(
                        dataSource: phData,
                        color: Colors.greenAccent,
                        xValueMapper: (Record record, _) => record.timestamp,
                        yValueMapper: (Record record, _) => record.value
                      )
                    ],
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat.jms(),
                      majorGridLines: MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 3,
                      title: AxisTitle(text: 'Timestamp')
                    ),
                    primaryYAxis: NumericAxis(
                      axisLine: AxisLine(width: 0),
                      majorTickLines: MajorTickLines(size: 0),
                      title: AxisTitle(text: 'pH')
                    )
                  ),
                  SfCartesianChart( 
                    series: <LineSeries<Record, DateTime>>[
                      LineSeries<Record, DateTime>(
                        dataSource: tdsData,
                        color: Colors.orangeAccent,
                        xValueMapper: (Record record, _) => record.timestamp,
                        yValueMapper: (Record record, _) => record.value
                      )
                    ],
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat.jms(),
                      majorGridLines: MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 3,
                      title: AxisTitle(text: 'Timestamp')
                    ),
                    primaryYAxis: NumericAxis(
                      axisLine: AxisLine(width: 0),
                      majorTickLines: MajorTickLines(size: 0),
                      title: AxisTitle(text: 'TDS')
                    )
                  ),
                  SfCartesianChart( 
                    series: <LineSeries<Record, DateTime>>[
                      LineSeries<Record, DateTime>(
                        dataSource: flowData,
                        color: Colors.blueAccent,
                        xValueMapper: (Record record, _) => record.timestamp,
                        yValueMapper: (Record record, _) => record.value
                      )
                    ],
                    primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat.jms(),
                      majorGridLines: MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 3,
                      title: AxisTitle(text: 'Timestamp')
                    ),
                    primaryYAxis: NumericAxis(
                      axisLine: AxisLine(width: 0),
                      majorTickLines: MajorTickLines(size: 0),
                      title: AxisTitle(text: 'Flow')
                    )
                  ),
                ],
              ),
            )
          ]
        ),
      )
    );
  }

  void updateData(Data data) {
    if (tempController == null || 
        speedController == null || 
        phController == null ||
        tdsController == null ||
        flowController == null
    )
      return;

    tempData.add(Record(data.temperature, DateTime.now()));
    tempData.removeAt(0);
    tempController.updateDataSource(
      addedDataIndex: tempData.length - 1,
      removedDataIndex: 0
    );

    speedData.add(Record(data.speed, DateTime.now()));
    speedData.removeAt(0);
    speedController.updateDataSource(
      addedDataIndex: speedData.length - 1,
      removedDataIndex: 0
    );

    phData.add(Record(data.ph, DateTime.now()));
    phData.removeAt(0);
    phController.updateDataSource(
      addedDataIndex: phData.length - 1,
      removedDataIndex: 0
    );

    tdsData.add(Record(data.tds, DateTime.now()));
    tdsData.removeAt(0);
    tdsController.updateDataSource(
      addedDataIndex: tdsData.length - 1,
      removedDataIndex: 0
    );

    flowData.add(Record(data.flow, DateTime.now()));
    flowData.removeAt(0);
    flowController.updateDataSource(
      addedDataIndex: flowData.length - 1,
      removedDataIndex: 0
    );
  }

  

  updateChartsStatus(bool status) {
    setState(() {
      isRealtime = status;

      int num;
      if (status) {
        DateTime current = DateTime.now();
        num = current.hour*4 + (current.minute/15).round();
      }
      else
        num = 96;

      tempData = [];
      speedData = [];
      phData = [];
      tdsData = [];
      flowData = [];
      for (var i = num; i >= 0; i--) {
        tempData.add(Record(Random().nextInt(21)+20, DateTime.now().subtract(Duration(seconds: i*5))));
        speedData.add(Record(Random().nextInt(46)+15, DateTime.now().subtract(Duration(seconds: i*5))));
        phData.add(Record(Random().nextInt(16), DateTime.now().subtract(Duration(seconds: i*5))));
        tdsData.add(Record(Random().nextInt(401)+100, DateTime.now().subtract(Duration(seconds: i*5))));
        flowData.add(Record(Random().nextInt(36)+15, DateTime.now().subtract(Duration(seconds: i*5))));
      }
    });
  }
}

class Record {
  final int value;
  final DateTime timestamp;

  Record(this.value, this.timestamp);
}

class Data {
  final int temperature;
  final int speed;
  final int ph;
  final int tds;
  final int flow;

  Data({
    this.temperature, 
    this.speed, 
    this.ph,
    this.tds,
    this.flow
  });

  bool isNotNull() => 
    this.temperature != null && 
    this.speed != null &&
    this.tds != null &&
    this.flow != null &&
    this.ph != null ? 
    true : false;
}