import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import 'package:flutter/material.dart';
import '../model/ConnectServer.dart';

class DetailGraph extends StatefulWidget {
  const DetailGraph({Key? key}) : super(key: key);

  @override
  State<DetailGraph> createState() => _DetailGraphState();
}

class _DetailGraphState extends State<DetailGraph> {
  final connectServer = ConnectServer();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
      const VBarChartModel(
          index: 1,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          tooltip: "152%",
          label: '당류'),
    ];

    List<VBarChartModel> barChartData2 = [
      const VBarChartModel(
          index: 2,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          tooltip: "114%",
          label: '콜레스테롤'),
      const VBarChartModel(
          index: 3,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 89,
          tooltip: "89%",
          label: '식이섬유'),
      const VBarChartModel(
          index: 3,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 89,
          tooltip: "89%",
          label: '나트륨'),
    ];

    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.all(0),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
                width: screenWidth * 0.50,
                child: VerticalBarchart(
                    background: Colors.transparent,
                    labelColor: Colors.black,
                    labelSizeFactor: 0.48,
                    tooltipColor: Colors.black,
                    data: barChartData,
                    showBackdrop: true,
                    barStyle: BarStyle.DEFAULT,
                    barSize: 12,
                    maxX: 100,
                    showLegend: false)),
            Container(
                width: screenWidth * 0.50,
                child: VerticalBarchart(
                  background: Colors.transparent,
                  labelColor: Colors.black,
                  labelSizeFactor: 0.48,
                  tooltipColor: Colors.black,
                  data: barChartData2,
                  showBackdrop: true,
                  barStyle: BarStyle.DEFAULT,
                  barSize: 12,
                  maxX: 100,
                  showLegend: true,
                  legend: [
                    Vlegend(isSquare: false, color: Colors.green, text: "적정"),
                    Vlegend(isSquare: false, color: Colors.red, text: "과잉"),
                    Vlegend(isSquare: false, color: Colors.yellow, text: "부족"),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}