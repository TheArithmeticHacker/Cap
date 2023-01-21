//@dart = 2.9
// ignore_for_file: depend_on_referenced_packages


import 'package:cap_ph/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';




class mainGraph extends StatefulWidget {
  const mainGraph({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _mainGraphState createState() => _mainGraphState();
}

class _mainGraphState extends State<mainGraph> {
  List<LiveDataPH> chartDataPH;
  List<LiveDataTEMP> chartDataTEMP;
  ChartSeriesController _chartSeriesControllerPH;
  ChartSeriesController _chartSeriesControllerTEMP;
  final referenceDatase = FirebaseDatabase.instance.ref('test');
  
  double x;
  double y;

  @override
  void initState() {
    chartDataPH = getChartDataPH();
    chartDataTEMP = getChartDataTEMP();
    Timer.periodic(const Duration(seconds: 3), updateDataSource);
    Timer.periodic(const Duration(seconds: 3), updateDataSourceTEMP);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
            stream: referenceDatase.onValue,
            builder:
                (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData) {
                Map<dynamic, dynamic> map =
                    snapshot.data.snapshot.value as dynamic;
                List<dynamic> l = [];
                l.clear();
                l = map.values.toList();
                x = l[1].toDouble();
                y = l[0].toDouble();
              } else {
                x = 5;
                y=8;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      child: 
                      SfCartesianChart(
                              title: ChartTitle(text: 'Temperature Live'),
                              series: <LineSeries<LiveDataTEMP, int>>[
                                LineSeries<LiveDataTEMP, int>(
                                  onRendererCreated:
                                      (ChartSeriesController controller) {
                                    _chartSeriesControllerTEMP = controller;
                                  },
                                  dataSource: chartDataTEMP,
                                  color: Colors.red,
                                  xValueMapper: (LiveDataTEMP sales, _) => sales.time,
                                  yValueMapper: (LiveDataTEMP sales, _) => sales.speed,
                                  
                                ),
                              ],
                              primaryXAxis: NumericAxis(
                                  majorGridLines: const MajorGridLines(width: 0),
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  interval: 3,
                                  title: AxisTitle(text: 'Time')),
                              primaryYAxis: NumericAxis(
                                  axisLine: const AxisLine(width: 0),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  title: AxisTitle(text: 'Temp'))),
                      
                     
                    ),
                ],
              );
            });
  }

  int timesy = 19;
  void updateDataSource(Timer timer) {
    chartDataPH.add(LiveDataPH(timesy, y));
    timesy++;
    chartDataPH.removeAt(0);
    _chartSeriesControllerPH.updateDataSource(
        addedDataIndex: chartDataPH.length - 1, removedDataIndex: 0);
  }

  int timesx = 19;
  void updateDataSourceTEMP(Timer timer) {
    chartDataTEMP.add(LiveDataTEMP(timesx, x));
    timesx++;
    chartDataTEMP.removeAt(0);
    _chartSeriesControllerTEMP.updateDataSource(
        addedDataIndex: chartDataTEMP.length - 1, removedDataIndex: 0);
  }

  List<LiveDataTEMP> getChartDataTEMP() {
    return <LiveDataTEMP>[
      LiveDataTEMP(0, 20),
      LiveDataTEMP(1, 20),
      LiveDataTEMP(2, 20),
      LiveDataTEMP(3, 20),
      LiveDataTEMP(4, 20),
      LiveDataTEMP(5, 20),
      LiveDataTEMP(6, 20),
      LiveDataTEMP(7, 20),
      LiveDataTEMP(8, 20),
      LiveDataTEMP(9, 20),
      LiveDataTEMP(10, 20),
      LiveDataTEMP(11, 20),
      LiveDataTEMP(12, 20),
      LiveDataTEMP(13, 20),
      LiveDataTEMP(14, 20),
      LiveDataTEMP(15, 20),
      LiveDataTEMP(16, 20),
      LiveDataTEMP(17, 20),
      LiveDataTEMP(17, 20),
      LiveDataTEMP(18, 20)
    ];
  }

  List<LiveDataPH> getChartDataPH() {
    return <LiveDataPH>[
      LiveDataPH(0, 42),
      LiveDataPH(1, 47),
      LiveDataPH(2, 43),
      LiveDataPH(3, 49),
      LiveDataPH(4, 54),
      LiveDataPH(5, 41),
      LiveDataPH(6, 58),
      LiveDataPH(7, 51),
      LiveDataPH(8, 98),
      LiveDataPH(9, 41),
      LiveDataPH(10, 53),
      LiveDataPH(11, 72),
      LiveDataPH(12, 86),
      LiveDataPH(13, 52),
      LiveDataPH(14, 94),
      LiveDataPH(15, 92),
      LiveDataPH(16, 86),
      LiveDataPH(17, 72),
      LiveDataPH(18, 94)
    ];
  }
}

class LiveDataTEMP {
  LiveDataTEMP(this.time, this.speed);
  final int time;
  final double speed;
}

class LiveDataPH {
  LiveDataPH(this.time, this.speed);
  final int time;
  final double speed;
}

Widget oldTemp1(){return SfCartesianChart(
                      title: ChartTitle(text: 'Temperature measurements'),
                      series: <ChartSeries>[
                        LineSeries<ChartData, String>(
                          dataSource: [
                            ChartData('Jan', 16.8),
                            ChartData('Feb', 19.6),
                            ChartData('Mar', 20.8),
                            ChartData('Apr', 24.9),
                            ChartData('May', 28.7),
                            ChartData('Jun', 26.9),
                            ChartData('Jul', 29.4),
                            ChartData('Aug', 29.1),
                            ChartData('Sept', 27.9),
                            ChartData('Oct', 26.2),
                            ChartData('Nov', 24.9),
                            ChartData('Dec', 20.3),
                            
                          ],
                          color: Colors.cyan,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings:const DataLabelSettings(isVisible : true))
                      ],
                      primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        title: AxisTitle(text: 'Month')),
                      primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        title: AxisTitle(text: 'Temp')),
                  );
}

Widget oldTemp2(){return SfCartesianChart(
                      title: ChartTitle(text: 'Temperature measurements'),
                      legend: Legend(isVisible: true),
                      series: <ChartSeries>[
                        LineSeries<ChartData, String>(
                          dataSource: dataDabaaE(),
                          name: 'El-Dabaa E',
                          color: Color.fromARGB(255, 211, 43, 211),
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings:const DataLabelSettings(isVisible : true)
                          ),
                          
                          LineSeries<ChartData, String>(
                          dataSource: dataMrsa(),
                          name: 'Mrsa Matrouh',
                          color: Colors.blue,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings:const DataLabelSettings(isVisible : true)
                          ),
                         
                          LineSeries<ChartData, String>(
                          dataSource: dataSaloum(),
                          name: 'El-Saloum',
                          color: Colors.green,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings:const DataLabelSettings(isVisible : true)
                          ),
                      ],
                      primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        title: AxisTitle(text: 'Season')),
                      primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        title: AxisTitle(text: 'Temp')),
                  );
}

List<ChartData>dataDabaaE() {
  return <ChartData>[
    ChartData('Winter', 17.80),
    ChartData('Spring', 24.30),
    ChartData('Summer', 24.00),
    ChartData('Autumn', 16.00),
  ];
}
List<ChartData>dataDabaaW() {
  return <ChartData>[
    ChartData('Winter', 8.59),
    ChartData('Spring', 8.04),
    ChartData('Summer', 8.20),
    ChartData('Autumn', 8.15),
  ];
}
List<ChartData>dataAlam() {
  return <ChartData>[
    ChartData('Winter', 8.62),
    ChartData('Spring', 8.08),
    ChartData('Summer', 8.25),
    ChartData('Autumn', 8.16),
  ];
}
List<ChartData>dataMrsa() {
  return <ChartData>[
    ChartData('Winter', 19.60),
    ChartData('Spring', 29.00),
    ChartData('Summer', 25.00),
    ChartData('Autumn', 20.00),
  ];
}
List<ChartData>dataNegala() {
  return <ChartData>[
    ChartData('Winter', 8.54),
    ChartData('Spring', 8.06),
    ChartData('Summer', 8.25),
    ChartData('Autumn', 8.15),
  ];
}
List<ChartData>dataSidi() {
  return <ChartData>[
    ChartData('Winter', 8.60),
    ChartData('Spring', 8.08),
    ChartData('Summer', 8.29),
    ChartData('Autumn', 8.18),
  ];
}
List<ChartData>dataSaloum() {
  return <ChartData>[
    ChartData('Winter', 20.20),
    ChartData('Spring', 25.65),
    ChartData('Summer', 26.00),
    ChartData('Autumn', 19.20),
  ];
}

Widget graph(int state){
  if(state == 0){
    return SizedBox(height: 300,);
  }else if(state == 1){
    return mainGraph();
  }else if(state == 2){
    return oldTemp1();
  }else{
    return oldTemp2();
  }
}



class temp extends StatefulWidget {
  const temp({Key key}) : super(key: key);

  @override
  State<temp> createState() => _tempState();
}



// ignore: camel_case_types
class _tempState extends State<temp> {
  @override
  var state = 0;
  bool isVisble = false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
          body: Column(
            children: [
              graph(state),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {setState(() {
                        state = 1;
                        isVisble = false;
                      });},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellowAccent[500],
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                          ),
                       child: const Text(
                            'REALTIME',
                          ),
                        ),
                  ),
                  SizedBox(width: 40,),
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {setState(() {
                        isVisble = true;
                        state = 0;
                      });},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellowAccent[500],
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                       child: const Text(
                            'COLLECTED',
                          ),
                        ),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Visibility(
                visible: isVisble,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => setState(() => state = 2),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              width: 1, // thickness
                              color: Colors.blue // color
                              ),
                            ),
                            ),
                         child: const Text(
                              "Maadi '18",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                    ),
                    SizedBox(height: 40,),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => setState(() => state = 3),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              width: 1, // thickness
                              color: Colors.blue // color
                              ),
                            ),
                            ),
                         child: const Text(
                              "Mid Sea '14",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
              ],
              
          )
        ),
      );
  }
}



class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}




