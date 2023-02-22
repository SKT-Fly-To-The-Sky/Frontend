import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';

import '../provider/supplementProvider.dart';

class SupplementsGrapeScreen extends StatelessWidget {
  final String? _result;
  const SupplementsGrapeScreen(this._result, {super.key});

  List<Color> setColor(double a){
    if (a>100){
      return [Colors.deepOrange, Colors.red];
    }else if(a>60){
      return [Colors.green, Colors.teal];
    }
    else {return [Colors.limeAccent, Colors.yellow];}
  }

  @override
  Widget build(BuildContext context) {
    var _nutinfo=Provider.of<supplementProvider>(context,listen: false).supplementnutInfo;
    List<VBarChartModel> bardata = [
      VBarChartModel(
          index: 0,
          colors: setColor((_nutinfo!['kcal'] / 2600) * 100),
          jumlah: (_nutinfo!['kcal'] / 2600) * 100,
          tooltip: ((_nutinfo!['kcal'] / 2600) * 100).ceil().toString() + "%",
          label: '칼로리'),
      VBarChartModel(
          index: 1,
          colors: setColor((_nutinfo!['carbo'] / 130) * 100),
          jumlah: (_nutinfo!['carbo'] / 130) * 100,
          tooltip: ((_nutinfo!['carbo'] / 130) * 100).ceil().toString() + "%",
          label: '탄수화물'),
      VBarChartModel(
          index: 2,
          colors: setColor((_nutinfo!['protein'] / 65) * 100),
          jumlah: (_nutinfo!['protein'] / 65) * 100,
          tooltip: ((_nutinfo!['protein'] / 65) * 100).ceil().toString() + "%",
          label: '단백질'),
      VBarChartModel(
          index: 3,
          colors: setColor((_nutinfo!['fat'] / 65) * 100),
          jumlah: (_nutinfo!['fat'] / 65) * 100,
          tooltip: ((_nutinfo!['fat'] / 65) * 100).ceil().toString() + "%",
          label: '지방'),
      VBarChartModel(
          index: 4,
          colors: setColor((_nutinfo!['sugar'] / 100) * 100),
          jumlah: (_nutinfo!['sugar'] / 100) * 100,
          tooltip: ((_nutinfo!['sugar'] /100) * 100).ceil().toString() + "%",
          label: '설탕'),
      VBarChartModel(
          index: 5,
          colors: setColor((_nutinfo!['chole'] / 300) * 100),
          jumlah: (_nutinfo!['chole'] / 300) * 100,
          tooltip: ((_nutinfo!['chole'] / 300) * 100).ceil().toString() + "%",
          label: '콜레스테롤'),
      VBarChartModel(
          index: 6,
          colors: setColor((_nutinfo!['fiber'] / 30) * 100),
          jumlah: (_nutinfo!['fiber'] / 30) * 100,
          tooltip: ((_nutinfo!['fiber'] / 30) * 100).ceil().toString() + "%",
          label: '식이섬유'),
      VBarChartModel(
          index: 7,
          colors: setColor((_nutinfo!['calcium'] / 2500) * 100),
          jumlah: (_nutinfo!['calcium'] / 2500) * 100,
          tooltip: ((_nutinfo!['calcium'] / 2500) * 100).ceil().toString() + "%",
          label: '칼슘'),
      VBarChartModel(
          index: 8,
          colors: setColor((_nutinfo!['iron'] / 45) * 100),
          jumlah: (_nutinfo!['iron'] / 45) * 100,
          tooltip: ((_nutinfo!['iron'] / 45) * 100).ceil().toString() + "%",
          label: '철'),
      VBarChartModel(
          index: 9,
          colors: setColor((_nutinfo!['magne'] / 360) * 100),
          jumlah: (_nutinfo!['magne'] / 360) * 100,
          tooltip: ((_nutinfo!['magne'] / 360) * 100).ceil().toString() + "%",
          label: '마그네슘'),
      VBarChartModel(
          index: 10,
          colors: setColor((_nutinfo!['potass'] / 3500) * 100),
          jumlah: (_nutinfo!['potass'] / 3500) * 100,
          tooltip: ((_nutinfo!['potass'] / 3500) * 100).ceil().toString() + "%",
          label: '칼륨'),
      VBarChartModel(
          index: 11,
          colors: setColor((_nutinfo!['sodium'] / 2300) * 100),
          jumlah: (_nutinfo!['sodium'] / 2300) * 100,
          tooltip: ((_nutinfo!['sodium'] / 2300) * 100).ceil().toString() + "%",
          label: '나트륨'),
      VBarChartModel(
          index: 12,
          colors: setColor((_nutinfo!['zinc'] / 35) * 100),
          jumlah: (_nutinfo!['zinc'] / 35) * 100,
          tooltip: ((_nutinfo!['zinc'] / 35) * 100).ceil().toString() + "%",
          label: '아연'),
      VBarChartModel(
          index: 13,
          colors: setColor((_nutinfo!['copper'] / 10000) * 100),
          jumlah: (_nutinfo!['copper'] / 10000) * 100,
          tooltip: ((_nutinfo!['copper'] / 10000) * 100).ceil().toString() + "%",
          label: '구리'),
      VBarChartModel(
          index: 14,
          colors: setColor((_nutinfo!['vitA'] / 3000) * 100),
          jumlah: (_nutinfo!['vitA'] / 3000) * 100,
          tooltip: ((_nutinfo!['vitA'] / 3000) * 100).ceil().toString() + "%",
          label: '비타민 A'),
      VBarChartModel(
          index: 15,
          colors: setColor((_nutinfo!['vitB1'] / 1.2)* 100),
          jumlah: (_nutinfo!['vitB1'] / 1.2) * 100,
          tooltip: ((_nutinfo!['vitB1'] / 1.2) * 100).ceil().toString() + "%",
          label: '비타민 B1'),
      VBarChartModel(
          index: 16,
          colors: setColor((_nutinfo!['vitB2'] / 1.5) * 100),
          jumlah: (_nutinfo!['vitB2'] / 1.5) * 100,
          tooltip: ((_nutinfo!['vitB2'] / 1.5) * 100).ceil().toString() + "%",
          label: '비타민 B2'),
      VBarChartModel(
          index: 17,
          colors: setColor((_nutinfo!['vitB3'] / 16) * 100),
          jumlah: (_nutinfo!['vitB3'] / 16) * 100,
          tooltip: ((_nutinfo!['vitB3'] / 16) * 100).ceil().toString() + "%",
          label: '비타민 B3'),
      VBarChartModel(
          index: 18,
          colors: setColor((_nutinfo!['vitB5'] / 5) * 100),
          jumlah: (_nutinfo!['vitB5'] / 5) * 100,
          tooltip: ((_nutinfo!['vitB5'] / 16) * 100).ceil().toString() + "%",
          label: '비타민 B5'),
      VBarChartModel(
          index: 19,
          colors: setColor((_nutinfo!['vitB6'] / 100) * 100),
          jumlah: (_nutinfo!['vitB6'] / 100) * 100,
          tooltip: ((_nutinfo!['vitB6'] / 100) * 100).ceil().toString() + "%",
          label: '비타민 B6'),
      VBarChartModel(
          index: 20,
          colors: setColor((_nutinfo!['vitB7'] / 30) * 100),
          jumlah: (_nutinfo!['vitB7'] / 30) * 100,
          tooltip: ((_nutinfo!['vitB7'] / 30) * 100).ceil().toString() + "%",
          label: '비타민 B7'),
      VBarChartModel(
          index: 21,
          colors: setColor((_nutinfo!['vitB9'] / 1000) * 100),
          jumlah: (_nutinfo!['vitB9'] / 1000) * 100,
          tooltip: ((_nutinfo!['vitB9'] / 1000) * 100).ceil().toString() + "%",
          label: '비타민 B9'),
      VBarChartModel(
          index: 22,
          colors: setColor((_nutinfo!['vitB12'] / 2.4) * 100),
          jumlah: (_nutinfo!['vitB12'] / 2.4) * 100,
          tooltip: ((_nutinfo!['vitB12'] / 2.4) * 100).ceil().toString() + "%",
          label: '비타민 B12'),
      VBarChartModel(
          index: 23,
          colors: setColor((_nutinfo!['vitC'] / 2000) * 100),
          jumlah: (_nutinfo!['vitC'] / 2000) * 100,
          tooltip: ((_nutinfo!['vitC'] / 2000) * 100).ceil().toString() + "%",
          label: '비타민 C'),
      VBarChartModel(
          index: 24,
          colors: setColor((_nutinfo!['vitD'] / 100) * 100),
          jumlah: (_nutinfo!['vitD'] / 100) * 100,
          tooltip: ((_nutinfo!['vitD'] / 100) * 100).ceil().toString() + "%",
          label: '비타민 D'),
      VBarChartModel(
          index: 25,
          colors: setColor((_nutinfo!['vitE'] / 540) * 100),
          jumlah: (_nutinfo!['vitE'] / 540) * 100,
          tooltip: ((_nutinfo!['vitE'] / 540) * 100).ceil().toString() + "%",
          label: '비타민 E'),
      VBarChartModel(
          index: 26,
          colors: setColor((_nutinfo!['vitK'] / 75) * 100),
          jumlah: (_nutinfo!['vitK'] / 75) * 100,
          tooltip: ((_nutinfo!['vitK'] / 75) * 100).ceil().toString() + "%",
          label: '비타민 K'),
      VBarChartModel(
          index: 27,
          colors: setColor((_nutinfo!['omega'] / 210) * 100),
          jumlah: (_nutinfo!['omega'] / 210) * 100,
          tooltip: ((_nutinfo!['omega'] / 210) * 100).ceil().toString() + "%",
          label: '오메가'),
    ];

    Widget Grape() {
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
            Grape(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        //AppBar 설정(UI 적용 완료)
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        //appbar 투명색
        centerTitle: true,
        elevation: 1.0,
        // 그림자 농도 0
        title: const Text(
          "A.영양제",
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
                      Icon(Icons.medication_outlined),
                      Text("섭취 영양성분"),
                    ],
                  ))
            ],
          ),
          Expanded(child: Container1()),
        ],
      ),
    );
  }
}
