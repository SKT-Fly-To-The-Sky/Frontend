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

class WeeklyGraph extends StatefulWidget {
  const WeeklyGraph({Key? key}) : super(key: key);

  @override
  State<WeeklyGraph> createState() => _WeeklyGraphState();
}

class _WeeklyGraphState extends State<WeeklyGraph> {
  final connectServer = ConnectServer();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final List<DoughnutChartData> doughnutChartData = [
      DoughnutChartData('섭취한 칼로리', 1700, Color(0xFF3617CE)),
      DoughnutChartData('남은 칼로리', 400, Color(0xFFe8e8e8)),
    ];

    List<VBarChartModel> barChartData = [
      const VBarChartModel(
          index: 0,
          colors: [Colors.green, Colors.teal],
          jumlah: 83,
          tooltip: "83%",
          label: '칼로리'),
      const VBarChartModel(
          index: 1,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          tooltip: "152%",
          label: '탄수화물'),
      const VBarChartModel(
          index: 2,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          tooltip: "114%",
          label: '단백질'),
      const VBarChartModel(
          index: 3,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 89,
          tooltip: "89%",
          label: '지방'),
    ];

    List<StackedBarChartData> stackedBarChartData = [
      StackedBarChartData('지방', 65, 35, Color(0xFF6ec0ff)),
      StackedBarChartData('단백질', 45, 55, Color(0xFF6eff8d)),
      StackedBarChartData('탄수화물', 70, 30, Color(0xFFff6775)),
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
                          "1700kcal",
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
