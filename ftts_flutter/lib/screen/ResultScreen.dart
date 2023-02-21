import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import 'dart:io';
import 'GraphScreen.dart';
import 'MainScreen.dart';
import '../widget/DailyGraph.dart';

class ResultScreen extends StatelessWidget {
  final XFile? _image;
  final List<String>? _result;
  final Map<String, dynamic>? _nutinfo;

  ResultScreen(this._image, this._result, this._nutinfo, {super.key});

  @override
  Widget build(BuildContext context) {
    List<VBarChartModel> bardata = [
      VBarChartModel(
          index: 0,
          colors: [Colors.green, Colors.teal],
          jumlah: (_nutinfo!['kcal'] / 2600) * 100,
          tooltip: ((_nutinfo!['kcal'] / 2600) * 100).toInt().toString() + "%",
          label: '칼로리'),
      VBarChartModel(
          index: 1,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: (_nutinfo!['carbo'] / 130) * 100,
          tooltip: ((_nutinfo!['carbo'] / 130) * 100).toInt().toString() + "%",
          label: '탄수화물'),
      VBarChartModel(
          index: 2,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: (_nutinfo!['protein'] / 65) * 100,
          tooltip: ((_nutinfo!['protein'] / 65) * 100).toInt().toString() + "%",
          label: '단백질'),
      VBarChartModel(
          index: 3,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: (_nutinfo!['fat'] / 65) * 100,
          tooltip: ((_nutinfo!['fat'] / 65) * 100).toInt().toString() + "%",
          label: '지방'),
    ];
    List<DoughnutChartData> doughnutChartData = [
      DoughnutChartData(
          '탄수화물',
          _nutinfo!['carbo'] /
              (_nutinfo!['carbo'] + _nutinfo!['protein'] + _nutinfo!['fat']),
          Color(0xFF5757)),
      DoughnutChartData(
          '단백질',
          _nutinfo!['protein'] /
              (_nutinfo!['carbo'] + _nutinfo!['protein'] + _nutinfo!['fat']),
          Color(0xD81665)),
      DoughnutChartData(
          '지방',
          _nutinfo!['fat'] /
              (_nutinfo!['carbo'] + _nutinfo!['protein'] + _nutinfo!['fat']),
          Color(0xA2006E)),
    ];
    List<DoughnutChartData> doughnutChartData2 = [
      DoughnutChartData('탄수화물', 130 / (130 + 65 + 65), Color(0x008037)),
      DoughnutChartData('단백질', 65 / (130 + 65 + 65), Color(0x00A068)),
      DoughnutChartData('지방', 65 / (130 + 65 + 65), Color(0x1DC09A)),
    ];
    //추천 메뉴
    Widget Specialities() {
      return Container(
        margin: EdgeInsets.only(left: 0, top: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xFFE6E9FD),
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "탄수화물 위주의 식사를 했어요",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 5,
                    ),
                    Text("다음식사는 샐러드 어때요?"),
                  ]),
            ),
            Expanded(
                flex: 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                        width: 200,
                        height: 100,
                        child: Image(
                          image: AssetImage('assets/salad.jpg'),
                          fit: BoxFit.fill,
                        )))),
          ],
        ),
      );
    }

    Widget Graph() {
      return VerticalBarchart(
        background: Colors.transparent,
        data: bardata,
        maxX: 100,
        showBackdrop: true,
        showLegend: true,
        barStyle: BarStyle.DEFAULT,
        legend: [
          Vlegend(isSquare: false, color: Colors.green, text: "적정"),
          Vlegend(isSquare: false, color: Colors.red, text: "과잉"),
          Vlegend(isSquare: false, color: Colors.yellow, text: "부족"),
        ],
      );
    }

    Widget CircleGraph() {
      return Container(
          height: 150,
          width: 150,
          child: SfCircularChart(series: <CircularSeries>[
            // Renders doughnut chart
            DoughnutSeries<DoughnutChartData, String>(
                dataSource: doughnutChartData,
                pointColorMapper: (DoughnutChartData data, _) => data.color,
                xValueMapper: (DoughnutChartData data, _) => data.x,
                yValueMapper: (DoughnutChartData data, _) => data.y,
                radius: '90%'
                // cornerStyle: CornerStyle.bothCurve
                )
          ]));
    }

    Widget CircleGraph2() {
      return Container(
          height: 150,
          width: 150,
          child: SfCircularChart(series: <CircularSeries>[
            // Renders doughnut chart
            DoughnutSeries<DoughnutChartData, String>(
                dataSource: doughnutChartData2,
                pointColorMapper: (DoughnutChartData data, _) => data.color,
                xValueMapper: (DoughnutChartData data, _) => data.x,
                yValueMapper: (DoughnutChartData data, _) => data.y,
                radius: '90%'
                // cornerStyle: CornerStyle.bothCurve
                )
          ]));
    }

    //이미지를 보여주는 위젯으로 image를 받으면 A.식단 결과 페이지가 나타난다
    Widget Container1() {
      return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    //child: (_image!='fail')?Expanded(child:Image.network(_result![0])):
                    child: (_image != null) && (_result != 'fail')
                        //음식 추정 실패시 김치전 사진이 나오도록
                        ? Expanded(
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                                width: 200,
                                height: 100,
                                child: Image.file(File(_image!.path!),
                                    fit: BoxFit.fill)),
                          ))
                        : Expanded(
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: 200,
                              height: 100,
                              child: Image(
                                  image: AssetImage('assets/kimchi.jpg'),
                                  fit: BoxFit.fill),
                            ),
                          ))),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        //classfication food_Name 결과
                        (_result != 'fail')
                            ? Column(
                                children: [
                                  for (var res in _result!) Text(res as String)
                                ],
                              )
                            : Text("김치전"),
                      ],
                    ))
              ],
            ),
            Graph(),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GraphScreen(_image!, _result!, _nutinfo!)));
                },
                child: Text("영양성분 더보기", style: TextStyle(fontSize: 14)))
          ],
        ),
      );
    }

    Widget Container2() {
      return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      children: <Widget>[
                        Column(children: <Widget>[
                          Text("오늘 섭취 영양소",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          CircleGraph(),
                        ]),
                        Column(children: <Widget>[
                          Text("권장 섭취 영양소",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          CircleGraph2()
                        ])
                      ],
                    ),
                  ))
                ],
              ),
              Specialities(),
            ],
          ));
    }

    return this._image != null
        ? Scaffold(
            backgroundColor: Color(0xFFF4F6F9),
            appBar: AppBar(
              //AppBar 설정(UI 적용 완료)
              iconTheme: IconThemeData(color: Colors.black),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              //appbar 투명색
              centerTitle: true,
              elevation: 1.0,
              // 그림자 농도 0
              title: Text(
                "A.식단",
                style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    color: Colors.black,
                    fontSize: 18),
              ),
              actions: [
                IconButton(
                  //닫기 버튼 (뒤로가기와 기능적으로 같다)
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            body: Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.restaurant),
                            Container(
                              width: 5,
                            ),
                            Text("추가한 식단"),
                          ],
                        ))
                  ],
                ),
                Container1(),
                Container2()
              ],
            ),
          )
        : Scaffold(
            backgroundColor: Color(0xFFF4F6F9),
            appBar: AppBar(
              //AppBar 설정(UI 적용 완료)
              iconTheme: IconThemeData(color: Colors.black),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              //appbar 투명색
              centerTitle: true,
              elevation: 1.0,
              // 그림자 농도 0
              title: Text(
                "A.식단",
                style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    color: Colors.black,
                    fontSize: 18),
              ),
              actions: [
                IconButton(
                  //닫기 버튼 (뒤로가기와 기능적으로 같다)
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            body: Column(
              children: [
                Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.restaurant),
                            Container(
                              width: 5,
                            ),
                            Text("추가한 식단"),
                          ],
                        ))
                  ],
                ),
                Container1(),
                Container2()
              ],
            ),
          );
  }
}
