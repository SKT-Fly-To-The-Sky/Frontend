
import 'package:flutter/material.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';

import 'ResultScreen.dart';

class GrapeScreen extends StatelessWidget{
  // final String? _image;
  final List<String>? _result;
//  const ResultScreen(this._image, {super.key});
  const GrapeScreen(this._result,{super.key});

  @override
  Widget build(BuildContext context) {

    List<VBarChartModel> bardata = [
      const VBarChartModel(
          index: 0,
          colors: [Colors.green, Colors.teal],
          jumlah: 83,
          tooltip: "83%",
          label: '칼로리'
      ),
      const VBarChartModel(
          index: 1,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          tooltip: "152%",
          label: '탄수화물'
      ),
      const VBarChartModel(
          index: 2,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          tooltip: "114%",
          label: '단백질'
      ),
      const VBarChartModel(
          index: 3,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 89,
          tooltip: "89%",
          label: '지방'
      ),
      const VBarChartModel(
          index: 4,
          colors: [Colors.green, Colors.teal],
          jumlah: 87,
          tooltip: "87%",
          label: '설탕'
      ),
      const VBarChartModel(
          index: 5,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 56,
          tooltip: "56%",
          label: '식이섬유'
      ),
      const VBarChartModel(
          index: 6,
          colors: [Colors.green, Colors.teal],
          jumlah: 65,
          tooltip: "65%",
          label: '포화지방'
      ),
      const VBarChartModel(
          index: 7,
          colors: [Colors.green, Colors.teal],
          jumlah: 89,
          tooltip: "89%",
          label: '콜레스트롤'
      ),
      const VBarChartModel(
          index: 8,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          label: '트랜스지방'
      ),
      const VBarChartModel(
          index: 9,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          label: '나트륨'
      ),
      const VBarChartModel(
          index: 10,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 36,
          tooltip: "36%",
          label: '칼슘'
      ),
      const VBarChartModel(
          index: 11,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 19,
          tooltip: "19%",
          label: '비타민A'
      ),
      const VBarChartModel(
          index: 12,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 73,
          tooltip: "73%",
          label: '비타민B'
      ),
      const VBarChartModel(
          index: 13,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 15,
          tooltip: "15%",
          label: '비타민C'
      ),
      const VBarChartModel(
          index: 14,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 0,
          tooltip: "0%",
          label: '비타민D'
      ),
      const VBarChartModel(
          index: 15,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 67,
          tooltip: "67%",
          label: '비타민E'
      ),

    ];
    Widget Grape(){
      return VerticalBarchart(
        background: Colors.transparent,
        data: bardata,
        maxX: 100,
        showBackdrop: true,
        showLegend: true,
        barStyle: BarStyle.DEFAULT,
        legend: [
          Vlegend(
              isSquare: false,
              color: Colors.green,
              text:"적정"
          ),
          Vlegend(
              isSquare: false,
              color: Colors.red,
              text:"과잉"
          ),
          Vlegend(
              isSquare: false,
              color: Colors.yellow,
              text:"부족"
          ),
        ],
      );
    }
    Widget Container1() {
      return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color:Colors.white,
        ),
        padding: EdgeInsets.fromLTRB(10,10,0,0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                  flex:1 ,
                  child: (_result![0]!='fail')?Expanded(child:Image.network(_result![0])):
                  Expanded(child:ClipRRect(borderRadius: BorderRadius.circular(8.0),child:Image(image:AssetImage('assets/kimchi.jpg'),fit:BoxFit.fitWidth)))),
              Expanded(flex:2 ,child: Column(children: <Widget>[(_result![1]!='fail')?Text(_result![1]):Text("test error"),],))
            ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Grape(),
            TextButton(onPressed:(){ Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResultScreen(_result)));}, child: Text("닫기"))
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
            children: <Widget>[Container(margin:EdgeInsets.only(left: 15,top:10),
                child:Row(children: [Icon(Icons.restaurant),Text("추가한 식단"),],))],
          ),
          Expanded(child: Container1()),

        ],
      ),

    );

  }

}