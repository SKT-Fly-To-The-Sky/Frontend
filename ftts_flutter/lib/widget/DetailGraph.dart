import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import 'package:flutter/material.dart';
import '../model/ConnectServer.dart';
import 'package:provider/provider.dart';
import '../provider/dateProvider.dart';

final List<String> nutName = [
  'kcal',
  'carbo',
  'protein',
  'fat',
  'sugar',
  'chole',
  'fiber',
  'calcium',
  'iron',
  'magne'
];
final Map<String, String> nutKor = {
  'kcal': '칼로리',
  'carbo': '탄수화물',
  'protein': '단백질',
  'fat': '지방',
  'sugar': '당류',
  'chole': '콜레스테롤',
  'fiber': '식이섬유',
  'calcium': '칼슘',
  'iron': '철',
  'magne': '마그네슘'
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
    var graphprovider = Provider.of<graphProvider>(context, listen: false);

    Map<String, dynamic>? _onedayInfo;
    Map<String, double>? _nutPercent;
    _onedayInfo = graphprovider.oneday_info;
    _nutPercent = {
      'kcal': _onedayInfo!['kcal']!.toDouble(),
      'carbo': _onedayInfo!['carbo']!.toDouble(),
      'protein': _onedayInfo!['protein']!.toDouble(),
      'fat': _onedayInfo!['fat']!.toDouble(),
      'sugar': _onedayInfo!['sugar']!.toDouble(),
      'chole': _onedayInfo!['chole']!.toDouble(),
      'fiber': _onedayInfo!['fiber']!.toDouble(),
      'calcium': _onedayInfo!['calcium']!.toDouble(),
      'iron': _onedayInfo!['iron']!.toDouble(),
      'magne': _onedayInfo!['magne']!.toDouble(),
    };

    List<VBarChartModel> barChartData = [];
    List<VBarChartModel> barChartData2 = [];

    for (int i = 0; i < 5; i++) {
      barChartData.add(VBarChartModel(
          index: i,
          colors: setColor(_nutPercent[nutName[i]]!),
          jumlah: (_nutPercent[nutName[i]]! >= 100)
              ? (100)
              : (_nutPercent[nutName[i]]!),
          tooltip: "${_nutPercent[nutName[i]]!.toInt()}%",
          label: nutKor[nutName[i]]));
    }
    for (int i = 5; i < nutName.length; i++) {
      barChartData2.add(VBarChartModel(
          index: i,
          colors: setColor(_nutPercent[nutName[i]]!),
          jumlah: (_nutPercent[nutName[i]]! >= 100)
              ? (100)
              : (_nutPercent[nutName[i]]!),
          tooltip: "${_nutPercent[nutName[i]]!.toInt()}%",
          label: nutKor[nutName[i]]));
    }

    return Container(
      width: screenWidth * 0.9,
      margin: EdgeInsets.all(0),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
                width: screenWidth * 0.46,
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
                    tooltipSize: 45,
                    showLegend: false)),
            Container(
                width: screenWidth * 0.48,
                child: VerticalBarchart(
                  background: Colors.transparent,
                  labelColor: Colors.black,
                  labelSizeFactor: 0.50,
                  tooltipColor: Colors.black,
                  data: barChartData2,
                  showBackdrop: true,
                  barStyle: BarStyle.DEFAULT,
                  barSize: 12,
                  maxX: 100,
                  showLegend: false,
                  tooltipSize: 45,
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
