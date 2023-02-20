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

class SupplementsGraph extends StatefulWidget {
  const SupplementsGraph({Key? key}) : super(key: key);

  @override
  State<SupplementsGraph> createState() => _SupplementsGraphState();
}

class _SupplementsGraphState extends State<SupplementsGraph> {
  final connectServer = ConnectServer();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    List<VBarChartModel> barChartData = [
      const VBarChartModel(
        index: 0,
        colors: [Color(0xFF3617CE), Colors.teal],
        jumlah: 83,
        tooltip: "83%",
        // label: '칼로리'
      ),
    ];

    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.all(0),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              width: screenWidth * 0.90,
              child: VerticalBarchart(
                  background: Colors.transparent,
                  labelColor: Colors.black,
                  // labelSizeFactor: 1.0,
                  tooltipColor: Colors.black,
                  data: barChartData,
                  showBackdrop: true,
                  barStyle: BarStyle.DEFAULT,
                  barSize: 20,
                  maxX: 100,
                  backdropColor: Color(0xffd6d0f5)))),
    );
  }
}
