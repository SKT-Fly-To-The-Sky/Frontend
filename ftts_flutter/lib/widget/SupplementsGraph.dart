import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:flutter/material.dart';
import '../model/ConnectServer.dart';

class SupplementsGraph extends StatefulWidget {
  const SupplementsGraph({Key? key}) : super(key: key);

  @override
  State<SupplementsGraph> createState() => _SupplementsGraphState();
}

class _SupplementsGraphState extends State<SupplementsGraph> {
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
