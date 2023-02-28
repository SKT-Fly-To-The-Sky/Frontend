import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/dateProvider.dart';

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

class DailyGraph extends StatefulWidget {
  const DailyGraph({Key? key}) : super(key: key);

  @override
  State<DailyGraph> createState() => _DailyGraphState();
}

class _DailyGraphState extends State<DailyGraph> {
  //final connectServer = ConnectServer();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var graphprovider = Provider.of<graphProvider>(context, listen: false);

    Map<String, dynamic> _onedayInfo;

    _onedayInfo = graphprovider.oneday_info;

    print("데이터 확인 ---------------");
    print(_onedayInfo['kcal']);
    List<dynamic> recommedInfo = [
      [
        '칼로리',
        'kcal',
        2600,
      ],
      ['탄수화물', 'carbo', 130],
      ['단백질', 'protein', 65],
      ['지방', 'fat', 65],
    ];

    List<VBarChartModel> barChartData = [];

    List<DoughnutChartData> doughnutChartData = [
      DoughnutChartData('섭취한 칼로리', (recommedInfo[0][2] - (_onedayInfo['kcal'])),
          Color(0xFF3617CE)),
      DoughnutChartData('남은 칼로리', (_onedayInfo['kcal']), Color(0xFFe8e8e8)),
    ];

    for (int i = 0; i < recommedInfo.length; i++) {
      var result = (_onedayInfo[recommedInfo[i][1]] / recommedInfo[i][2]) * 100;
      if ((result) > 100) {
        result = 100.0;
      }

      barChartData.add(VBarChartModel(
          index: i,
          colors: setColor(
              (_onedayInfo[recommedInfo[i][1]] / recommedInfo[i][2]) * 100),
          jumlah: result,
          tooltip:
              ((_onedayInfo[recommedInfo[i][1]] / recommedInfo[i][2]) * 100)
                      .ceil()
                      .toString() +
                  "%",
          label: recommedInfo[i][0]));
    }

    Widget Grape() {
      return Container(
          width: screenWidth * 0.50,
          child: VerticalBarchart(
            background: Colors.transparent,
            labelColor: Colors.black,
            labelSizeFactor: 0.50,
            tooltipColor: Colors.black,
            data: barChartData,
            showBackdrop: true,
            barStyle: BarStyle.DEFAULT,
            barSize: 11,
            maxX: 100,
            showLegend: true,
            legend: [
              Vlegend(isSquare: false, color: Colors.green, text: "적정"),
              Vlegend(isSquare: false, color: Colors.red, text: "과잉"),
              Vlegend(isSquare: false, color: Colors.yellow, text: "부족"),
            ],
          ));
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
                height: 130,
                width: 130,
                child: SfCircularChart(
                    centerY: '80',
                    margin: EdgeInsets.zero,
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                          widget: Container(
                            child: Text(
                          ((recommedInfo[0][2] - (_onedayInfo['kcal'])).ceil())
                                  .toString() +
                              "kcal",
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
              scrollDirection: Axis.horizontal, child: Grape()),
        ],
      ),
    );
  }
}
