import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import 'dart:io';
import 'GraphScreen.dart';
import 'MainScreen.dart';

class ResultScreen extends StatelessWidget {
  final XFile? _image;
  final String? _result;
  const ResultScreen(this._image, this._result, {super.key});
  @override
  Widget build(BuildContext context) {
    List<VBarChartModel> bardata = [
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
    List<DoughnutChartData> doughnutChartData = [
      DoughnutChartData('탄수화물', 64.7, Color(0xFF5757)),
      DoughnutChartData('단백질', 20.5, Color(0xD81665)),
      DoughnutChartData('지방', 14.9, Color(0xA2006E)),
    ];
    List<DoughnutChartData> doughnutChartData2 = [
      DoughnutChartData('탄수화물', 55.1, Color(0x008037)),
      DoughnutChartData('단백질', 23.3, Color(0x00A068)),
      DoughnutChartData('지방', 21.6, Color(0x1DC09A)),
    ];
    //추천 메뉴
    Widget Specialities() {
      return Container(
        margin: EdgeInsets.only(left: 0, top: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.blueGrey,
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("탄수화물 위주의 식사를 했어요"),
                    Text("다음식사는 샐러드 어때요?"),
                  ]),
            ),
            Expanded(
                flex: 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(image: AssetImage('assets/salad.jpg'))))
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

    Widget Circleh2() {
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
                    child: (_image != 'fail')
                        ? Expanded(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(File(_image!.path))))
                        : Expanded(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image(
                                    image: AssetImage('assets/kimchi.jpg'),
                                    fit: BoxFit.fitWidth)))),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        (_result != 'fail')
                            ? Text(_result!)
                            : Text("test error"),
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
                          builder: (context) => GraphScreen(_image, _result)));
                },
                child: Text("영양성분 더보기"))
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
                          Text("오늘 섭취 영양소"),
                          CircleGraph(),
                        ]),
                        Column(
                            children: <Widget>[Text("권장 섭취 영양소"), Circleh2()])
                      ],
                    ),
                  ))
                ],
              ),
              Specialities(),
            ],
          ));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        //AppBar 설정(UI 적용 완료)
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white, //appbar 투명색
        centerTitle: true,
        elevation: 1.0, // 그림자 농도 0
        title: const Text(
          "A.식단",
          style: TextStyle(
              fontFamily: 'NotoSansKR', color: Colors.black, fontSize: 18),
        ),
        actions: [
          IconButton(
            //닫기 버튼 (뒤로가기와 기능적으로 같다)
            icon: const Icon(Icons.close),
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
