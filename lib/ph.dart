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
                              series: <LineSeries<LiveDataPH, int>>[
                                LineSeries<LiveDataPH, int>(
                                  onRendererCreated:
                                      (ChartSeriesController controller) {
                                    _chartSeriesControllerPH = controller;
                                  },
                                  dataSource: chartDataPH,
                                  color: Colors.red,
                                  xValueMapper: (LiveDataPH sales, _) => sales.time,
                                  yValueMapper: (LiveDataPH sales, _) => sales.speed,
                                  
                                ),
                              ],
                              title: ChartTitle(text: 'pH Live'),
                              primaryXAxis: NumericAxis(
                                  majorGridLines: const MajorGridLines(width: 0),
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  interval: 3,
                                  title: AxisTitle(text: 'Time')),
                              primaryYAxis: NumericAxis(
                                  axisLine: const AxisLine(width: 0),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  title: AxisTitle(text: 'pH'))),
                      
                     
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
      LiveDataTEMP(0, 42),
      LiveDataTEMP(1, 47),
      LiveDataTEMP(2, 43),
      LiveDataTEMP(3, 49),
      LiveDataTEMP(4, 54),
      LiveDataTEMP(5, 41),
      LiveDataTEMP(6, 58),
      LiveDataTEMP(7, 51),
      LiveDataTEMP(8, 98),
      LiveDataTEMP(9, 41),
      LiveDataTEMP(10, 53),
      LiveDataTEMP(11, 72),
      LiveDataTEMP(12, 86),
      LiveDataTEMP(13, 52),
      LiveDataTEMP(14, 94),
      LiveDataTEMP(15, 92),
      LiveDataTEMP(16, 86),
      LiveDataTEMP(17, 72),
      LiveDataTEMP(18, 94)
    ];
  }

  List<LiveDataPH> getChartDataPH() {
    return <LiveDataPH>[
      LiveDataPH(0, 7),
      LiveDataPH(1, 7),
      LiveDataPH(2, 7),
      LiveDataPH(3, 7),
      LiveDataPH(4, 7),
      LiveDataPH(5, 7),
      LiveDataPH(6, 7),
      LiveDataPH(7, 7),
      LiveDataPH(8, 7),
      LiveDataPH(9, 7),
      LiveDataPH(10, 7),
      LiveDataPH(11, 7),
      LiveDataPH(12, 7),
      LiveDataPH(13, 7),
      LiveDataPH(14, 7),
      LiveDataPH(15, 7),
      LiveDataPH(16, 7),
      LiveDataPH(17, 7),
      LiveDataPH(18, 7)
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

Widget oldPh1(){return SfCartesianChart(
                      title: ChartTitle(text: 'pH measurements'),
                      series: <ChartSeries>[
                        LineSeries<ChartData, String>(
                          dataSource: [
                            ChartData('Jan', 8.2),
                            ChartData('Feb', 8.3),
                            ChartData('Mar', 8.3),
                            ChartData('Apr', 8.3),
                            ChartData('May', 8.3),
                            ChartData('Jun', 8.3),
                            ChartData('Jul', 8.3),
                            ChartData('Aug', 8.3),
                            ChartData('Sept', 8.3),
                            ChartData('Oct', 8.3),
                            ChartData('Nov', 8.3),
                            ChartData('Dec', 8.3),
                            
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
                        title: AxisTitle(text: 'pH')),
                  );
}

Widget oldPh2(){return SfCartesianChart(
                      title: ChartTitle(text: 'pH measurements'),
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
                        title: AxisTitle(text: 'pH')),
                  );
}

List<ChartData>dataDabaaE() {
  return <ChartData>[
    ChartData('Winter', 8.58),
    ChartData('Spring', 8.04),
    ChartData('Summer', 8.16),
    ChartData('Autumn', 8.13),
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
    ChartData('Winter', 8.63),
    ChartData('Spring', 8.08),
    ChartData('Summer', 8.25),
    ChartData('Autumn', 8.15),
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
    ChartData('Winter', 8.39),
    ChartData('Spring', 8.15),
    ChartData('Summer', 8.32),
    ChartData('Autumn', 8.23),
  ];
}

Widget graph(int state){
  if(state == 0){
    return SizedBox(height: 300,);
  }else if(state == 1){
    return mainGraph();
  }else if(state == 2){
    return oldPh1();
  }else{
    return oldPh2();
  }
}



class ph extends StatefulWidget {
  const ph({Key key}) : super(key: key);

  @override
  State<ph> createState() => _phState();
}



// ignore: camel_case_types
class _phState extends State<ph> {
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
                        isVisble = false;
                        state = 1;
                      });},
                        style: ElevatedButton.styleFrom(
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




