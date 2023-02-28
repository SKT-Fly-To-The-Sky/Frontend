import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import 'package:flutter/material.dart';
import '../model/ConnectServer.dart';
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

    Map<String, dynamic> _onedayInfo;

    _onedayInfo = graphprovider.oneday_info;

    List<dynamic> recommedInfo = [
      ['칼로리', 'kcal', 2600],
      ['탄수화물', 'carbo', 130],
      ['단백질', 'protein', 65],
      ['지방', 'fat', 65],
      ['당류', 'sugar', 100],
      ['콜레스트롤', 'chole', 300],
      ['식이섬유', 'fiber', 30],
      ['칼슘', 'calcium', 2500],
      ['철', 'iron', 40],
      ['마그네슘', 'magne', 360],
    ];

    List<VBarChartModel> barChartData = [];
    List<VBarChartModel> barChartData2 = [];

    for (int i = 0; i < 5; i++) {
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
                  "%", //+단위
          label: recommedInfo[i][0]));
    }

    for (int i = 5; i < recommedInfo.length; i++) {
      var result = (_onedayInfo[recommedInfo[i][1]] / recommedInfo[i][2]) * 100;
      if ((result) > 100) {
        result = 100.0;
      }

      barChartData2.add(VBarChartModel(
          index: i,
          colors: setColor(
              (_onedayInfo[recommedInfo[i][1]] / recommedInfo[i][2]) * 100),
          jumlah: result,
          tooltip:
              ((_onedayInfo[recommedInfo[i][1]] / recommedInfo[i][2]) * 100)
                      .ceil()
                      .toString() +
                  "%", //+단위
          label: recommedInfo[i][0]));
    }

    Widget Grape() {
      return Container(
          width: screenWidth * 0.48,
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
              tooltipSize: 30,
              showLegend: false));
    }

    Widget Grape2() {
      return Container(
          width: screenWidth * 0.44,
          child: VerticalBarchart(
            background: Colors.transparent,
            labelColor: Colors.black,
            labelSizeFactor: 0.50,
            tooltipColor: Colors.black,
            data: barChartData2,
            showBackdrop: true,
            barStyle: BarStyle.DEFAULT,
            barSize: 11,
            maxX: 100,
            showLegend: false,
            tooltipSize: 30,
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Grape(),
            Grape2(),
          ],
        ),
      ),
    );
  }
}

Map<String, dynamic> chartData = {
  //[칼로리, 탄, 단, 지]
  '2023-02-25': [2300, 386.8, 133.08, 181.4],
  '2023-02-26': [1748.5, 232.7, 70, 59.576],
  '2023-02-27': [1612.3, 197, 72.8, 60.7],
};

class StaticDetailGraph extends StatefulWidget {
  String graphDate;
  StaticDetailGraph(this.graphDate, {Key? key}) : super(key: key);

  @override
  State<StaticDetailGraph> createState() => _StaticDetailGraphState();
}

class _StaticDetailGraphState extends State<StaticDetailGraph> {

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;


    Map<String, double> nutPercent = {
      'kcal': 62,
      'carbo': 170,
      'protein': 118,
      'fat': 126,
      'sugar': 160,
      'chole': 25,
      'fiber': 25,
      'calcium': 25,
      'iron': 25,
      'magne': 25,
    };


    List<VBarChartModel> barChartData = [];
    List<VBarChartModel> barChartData2 = [];
    if(widget.graphDate=='2023-02-25'||widget.graphDate=='2023-02-26'||widget.graphDate=='2023-02-27'){
      print(widget.graphDate);
      print("testing!!!");
      for (int i = 0; i < 5; i++) {
        barChartData.add(VBarChartModel(
            index: i,
            colors: setColor(nutPercent[nutName[i]]!),
            jumlah: (nutPercent[nutName[i]]! >= 100)
                ? (100)
                : (nutPercent[nutName[i]]!),
            tooltip: "${nutPercent[nutName[i]]!.toInt()}%",
            label: nutKor[nutName[i]]));
      }

      for (int i = 5; i < nutName.length; i++) {
        barChartData2.add(VBarChartModel(
            index: i,
            colors: setColor(nutPercent[nutName[i]]!),
            jumlah: (nutPercent[nutName[i]]! >= 100)
                ? (100)
                : (nutPercent[nutName[i]]!),
            tooltip: "${nutPercent[nutName[i]]!.toInt()}%",
            label: nutKor[nutName[i]]));
      }
    }else {
      for (int i = 0; i < 5; i++) {
        barChartData.add(VBarChartModel(
            index: i,
            colors: [Colors.deepOrange, Colors.red],
            jumlah: 0,
            tooltip: "0%",
            label: nutKor[nutName[i]]));
      }

      for (int i = 5; i < nutName.length; i++) {
        barChartData2.add(VBarChartModel(
            index: i,
            colors: [Colors.deepOrange, Colors.red],
            jumlah: 0,
            tooltip: "0%",
            label: nutKor[nutName[i]]));
      }
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
                width: screenWidth * 0.48,
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
                    tooltipSize: 30,
                    showLegend: false)),
            Container(
                width: screenWidth * 0.44,
                child: VerticalBarchart(
                  background: Colors.transparent,
                  labelColor: Colors.black,
                  labelSizeFactor: 0.50,
                  tooltipColor: Colors.black,
                  data: barChartData2,
                  showBackdrop: true,
                  barStyle: BarStyle.DEFAULT,
                  barSize: 11,
                  maxX: 100,
                  showLegend: false,
                  tooltipSize: 30,
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
