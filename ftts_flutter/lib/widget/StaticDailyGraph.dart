import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import 'package:flutter/material.dart';
import '../model/ConnectServer.dart';

final List<String> nutName = ['kcal', 'carbo', 'protein', 'fat'];
final Map<String, String> nutKor = {
  'kcal': '칼로리',
  'carbo': '탄수화물',
  'protein': '단백질',
  'fat': '지방'
};

Map<String, dynamic> staticDailyData = {
  //[칼로리, 탄, 단, 지]
  '2023-02-25': [2300, 386.8, 133.08, 181.4],
  '2023-02-26': [1748.5, 232.7, 70, 59.576],
  '2023-02-27': [1612.3, 197, 72.8, 60.7],
};

List<Color> setColor(double a) {
  if (a >= 100) {
    return [Colors.deepOrange, Colors.red];
  } else if (a > 60) {
    return [Colors.green, Colors.teal];
  } else {
    return [Colors.limeAccent, Colors.yellow];
  }
}

class DoughnutChartData {
  DoughnutChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class StaticDailyGraph extends StatefulWidget {
  const StaticDailyGraph({Key? key}) : super(key: key);

  @override
  State<StaticDailyGraph> createState() => _StaticDailyGraphState();
}

class _StaticDailyGraphState extends State<StaticDailyGraph> {
  final connectServer = ConnectServer();

  static double kcal = 1165;
  List<DoughnutChartData> doughnutChartData = [
    DoughnutChartData('섭취한 칼로리', (2600 - kcal), Color(0xFF3617CE)),
    DoughnutChartData('남은 칼로리', kcal, Color(0xFFe8e8e8)),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, double> nutPercent = {
      'kcal': 44,
      'carbo': 96,
      'protein': 83,
      'fat': 78
    };
    List<VBarChartModel> barChartData = [];
    for (int i = 0; i < nutName.length; i++) {
      barChartData.add(VBarChartModel(
          index: i,
          colors: setColor(nutPercent[nutName[i]]!),
          jumlah: (nutPercent[nutName[i]]! >= 100)
              ? (100)
              : (nutPercent[nutName[i]]!),
          tooltip: "${nutPercent[nutName[i]]!.toInt()}%",
          label: nutKor[nutName[i]]));
    }

    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.all(0),
      color: Colors.white,
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
                        child: Text(
                          "${kcal.toInt()}kcal",
                          style: TextStyle(fontSize: 18),
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
