import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import 'package:flutter/material.dart';
import '../model/ConnectServer.dart';
import 'dart:io';

class DoughnutChartData {
  DoughnutChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class StackedBarChartData {
  final String x;
  final num y1;
  final num y2;
  final Color color;
  StackedBarChartData(this.x, this.y1, this.y2, this.color);
}

class DailyGraph extends StatefulWidget {
  const DailyGraph({Key? key}) : super(key: key);

  @override
  State<DailyGraph> createState() => _DailyGraphState();
}

class _DailyGraphState extends State<DailyGraph> {
  final connectServer = ConnectServer();

  final List<DoughnutChartData> doughnutChartData = [
    DoughnutChartData('섭취한 칼로리', 1848, Color(0xFF3617CE)),
    DoughnutChartData('남은 칼로리', 752, Color(0xFFe8e8e8)),
  ];

  final double kcal = 28;
  final double carbo = 52;
  final double prot = 28;
  final double fat = 25;

  final Map<String, dynamic> graphColor = {
    'shortage': [Colors.limeAccent, Colors.yellow],
    'appropriate': [Colors.green, Colors.teal],
    'excess': [Colors.deepOrange, Colors.red]
  };

  final List<double> nutPer = [28, 52, 28, 25];
  final List<String> nutName = ['kcal', 'carbo', 'prot', 'fat'];
  final Map<String, String> nutKor = {
    'kcal': '칼로리',
    'carbo': '탄수화물',
    'prot': '단백질',
    'fat': '지방'
  };
  final List<double> nutPercent = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    List<Color> setColor(double a) {
      if (a > 100) {
        return [Colors.deepOrange, Colors.red];
      } else if (a > 60) {
        return [Colors.green, Colors.teal];
      } else {
        return [Colors.limeAccent, Colors.yellow];
      }
    }

    final List<VBarChartModel> barChartData = [
      VBarChartModel(
          index: 0,
          colors: graphColor['shortage'],
          jumlah: kcal,
          tooltip: "$kcal%",
          label: '칼로리'),
      VBarChartModel(
          index: 1,
          colors: graphColor['appropriate'],
          jumlah: carbo,
          tooltip: "$carbo%",
          label: '탄수화물'),
      VBarChartModel(
          index: 2,
          colors: graphColor['shortage'],
          jumlah: prot,
          tooltip: "$prot%",
          label: '단백질'),
      VBarChartModel(
          index: 3,
          colors: graphColor['shortage'],
          jumlah: fat,
          tooltip: "$fat%",
          label: '지방'),
    ];

    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.all(0),
      color: Colors.white,
      // color: Color(0xFFF4F6F9),
      child: Row(
        children: [
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Text(
                  "남은 칼로리",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Container(
                height: 150,
                width: 150,
                child: SfCircularChart(
                    centerY: '80',
                    margin: EdgeInsets.zero,
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                          widget: Container(
                        child: const Text(
                          "1848kcal",
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ))
                    ],
                    series: <CircularSeries>[
                      DoughnutSeries<DoughnutChartData, String>(
                          dataSource: doughnutChartData,
                          pointColorMapper: (DoughnutChartData data, _) =>
                              data.color,
                          xValueMapper: (DoughnutChartData data, _) => data.x,
                          yValueMapper: (DoughnutChartData data, _) => data.y,
                          innerRadius: '70%')
                    ]),
              ),
            ],
          )),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  width: screenWidth * 0.50,
                  child: VerticalBarchart(
                    background: Colors.transparent,
                    labelColor: Colors.black,
                    labelSizeFactor: 0.45,
                    tooltipColor: Colors.black,
                    data: barChartData,
                    showBackdrop: true,
                    barStyle: BarStyle.DEFAULT,
                    barSize: 12,
                    maxX: 100,
                    showLegend: true,
                    legend: [
                      Vlegend(isSquare: false, color: Colors.green, text: "적정"),
                      Vlegend(isSquare: false, color: Colors.red, text: "과잉"),
                      Vlegend(
                          isSquare: false, color: Colors.yellow, text: "부족"),
                    ],
                  ))),
        ],
      ),
    );
  }
}
