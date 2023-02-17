import 'package:flutter/material.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';

class SupplementsGrapeScreen extends StatelessWidget {
  final String? _result;

  const SupplementsGrapeScreen(this._result, {super.key});

  @override
  Widget build(BuildContext context) {
    List<VBarChartModel> bardata = [
      const VBarChartModel(
          index: 0,
          colors: [Colors.green, Colors.teal],
          jumlah: 83,
          tooltip: "83%",
          label: '비타민A'),
      const VBarChartModel(
          index: 1,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          tooltip: "152%",
          label: '비타민D(D2+D3)'),
      const VBarChartModel(
          index: 2,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          tooltip: "114%",
          label: '비타민 E'),
      const VBarChartModel(
          index: 3,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 89,
          tooltip: "89%",
          label: '비타민K'),
      const VBarChartModel(
          index: 4,
          colors: [Colors.green, Colors.teal],
          jumlah: 87,
          tooltip: "87%",
          label: '팥토텐산'),
      const VBarChartModel(
          index: 5,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 56,
          tooltip: "56%",
          label: '비타민 B6'),
      const VBarChartModel(
          index: 6,
          colors: [Colors.green, Colors.teal],
          jumlah: 65,
          tooltip: "65%",
          label: '비오틴'),
      const VBarChartModel(
          index: 7,
          colors: [Colors.green, Colors.teal],
          jumlah: 89,
          tooltip: "89%",
          label: '엽산(DFE)'),
      const VBarChartModel(
          index: 8,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          label: '비타민 B12'),
      const VBarChartModel(
          index: 9,
          colors: [Colors.deepOrange, Colors.red],
          jumlah: 100,
          label: '비타민 C'),
      const VBarChartModel(
          index: 10,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 36,
          tooltip: "36%",
          label: '칼슘'),
      const VBarChartModel(
          index: 11,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 19,
          tooltip: "19%",
          label: '마그네슘'),
      const VBarChartModel(
          index: 12,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 73,
          tooltip: "73%",
          label: '인'),
      const VBarChartModel(
          index: 13,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 15,
          tooltip: "15%",
          label: '칼륨'),
      const VBarChartModel(
          index: 14,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 0,
          tooltip: "0%",
          label: '철'),
      const VBarChartModel(
          index: 15,
          colors: [Colors.limeAccent, Colors.yellow],
          jumlah: 67,
          tooltip: "67%",
          label: '아연'),
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

    Widget Specialities() {
      return Container(
          margin: EdgeInsets.only(left: 0, top: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(0xFFE6E9FD),
          ),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  "비타민D 가 부족해요!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                    width: 200,
                                    height: 130,
                                    child: Image(
                                      image: AssetImage('assets/salad.jpg'),
                                      fit: BoxFit.fill,
                                    ))))),
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 130,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  child: Text(
                                    "영양제 이름",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  child: Text("최저가",
                                      style: TextStyle(
                                        fontSize: 12,
                                      )),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    "14,240원",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.red),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text("11번가에서 구입하기")))
                              ]),
                        )),
                  ],
                ),
              )
            ],
          ));
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
              Specialities(),
            ],
          ));
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
          Expanded(child: Container2())
        ],
      ),
    );
  }
}
