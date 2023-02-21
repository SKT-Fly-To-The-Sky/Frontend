import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import 'dart:io';
import 'ResultScreen.dart';

class GraphScreen extends StatelessWidget {
  final XFile? _image;
  final List<String>? _result;
  final Map<String, dynamic>? _nutinfo;

  const GraphScreen(this._image, this._result, this._nutinfo, {super.key});

  @override
  Widget build(BuildContext context) {

    List<Color> setColor(double a){
      if (a>100){
        return [Colors.deepOrange, Colors.red];
      }else if(a>60){
        return [Colors.green, Colors.teal];
      }
      else {return [Colors.limeAccent, Colors.yellow];}
    }

    List<VBarChartModel> bardata = [
      VBarChartModel(
          index: 0,
          colors: setColor((_nutinfo!['kcal'] / 2600)/3 * 100),
          jumlah: (_nutinfo!['kcal'] / 2600)/3 * 100,
          tooltip: ((_nutinfo!['kcal'] / 2600)/3 * 100).toInt().toString() + "%",
          label: '칼로리'),
      VBarChartModel(
          index: 1,
          colors: setColor((_nutinfo!['carbo'] / 130)/3 * 100),
          jumlah: (_nutinfo!['carbo'] / 130)/3 * 100,
          tooltip: ((_nutinfo!['carbo'] / 130)/3 * 100).toInt().toString() + "%",
          label: '탄수화물'),
      VBarChartModel(
          index: 2,
          colors: setColor((_nutinfo!['protein'] / 65)/3 * 100),
          jumlah: (_nutinfo!['protein'] / 65)/3 * 100,
          tooltip: ((_nutinfo!['protein'] / 65)/3 * 100).toInt().toString() + "%",
          label: '단백질'),
      VBarChartModel(
          index: 3,
          colors: setColor((_nutinfo!['fat'] / 65)/3 * 100),
          jumlah: (_nutinfo!['fat'] / 65)/3 * 100,
          tooltip: ((_nutinfo!['fat'] / 65) * 100)/3.toInt().toString() + "%",
          label: '지방'),
      VBarChartModel(
          index: 4,
          colors: setColor((_nutinfo!['sugar'] / 100)/3 * 100),
          jumlah: (_nutinfo!['sugar'] / 100)/3 * 100,
          tooltip: ((_nutinfo!['sugar'] /100)/3 * 100).toInt().toString() + "%",
          label: '설탕'),
      VBarChartModel(
          index: 5,
          colors: setColor((_nutinfo!['chole'] / 300)/3 * 100),
          jumlah: (_nutinfo!['chole'] / 300)/3 * 100,
          tooltip: ((_nutinfo!['chole'] / 300)/3 * 100).toInt().toString() + "%",
          label: '콜레스테롤'),
      VBarChartModel(
          index: 6,
          colors: setColor((_nutinfo!['fiber'] / 30)/3 * 100),
          jumlah: (_nutinfo!['fiber'] / 30)/3 * 100,
          tooltip: ((_nutinfo!['fiber'] / 30)/3 * 100).toInt().toString() + "%",
          label: '식이섬유'),
      VBarChartModel(
          index: 7,
          colors: setColor((_nutinfo!['calcium'] / 2500)/3 * 100),
          jumlah: (_nutinfo!['calcium'] / 2500)/3 * 100,
          tooltip: ((_nutinfo!['calcium'] / 2500)/3 * 100).toInt().toString() + "%",
          label: '칼슘'),
      VBarChartModel(
          index: 8,
          colors: setColor((_nutinfo!['iron'] / 45)/3 * 100),
          jumlah: (_nutinfo!['iron'] / 45)/3 * 100,
          tooltip: ((_nutinfo!['iron'] / 45)/3 * 100).toInt().toString() + "%",
          label: '철'),
      VBarChartModel(
          index: 9,
          colors: setColor((_nutinfo!['magne'] / 360)/3 * 100),
          jumlah: (_nutinfo!['magne'] / 360)/3 * 100,
          tooltip: ((_nutinfo!['magne'] / 360)/3 * 100).toInt().toString() + "%",
          label: '마그네슘'),
      VBarChartModel(
          index: 10,
          colors: setColor((_nutinfo!['potass'] / 3500)/3 * 100),
          jumlah: (_nutinfo!['potass'] / 3500)/3 * 100,
          tooltip: ((_nutinfo!['potass'] / 3500)/3 * 100).toInt().toString() + "%",
          label: '칼륨'),
      VBarChartModel(
          index: 11,
          colors: setColor((_nutinfo!['sodium'] / 2300)/3 * 100),
          jumlah: (_nutinfo!['sodium'] / 2300)/3 * 100,
          tooltip: ((_nutinfo!['sodium'] / 2300)/3 * 100).toInt().toString() + "%",
          label: '나트륨'),
      VBarChartModel(
          index: 12,
          colors: setColor((_nutinfo!['zinc'] / 35)/3 * 100),
          jumlah: (_nutinfo!['zinc'] / 35)/3 * 100,
          tooltip: ((_nutinfo!['zinc'] / 35)/3 * 100).toInt().toString() + "%",
          label: '아연'),
      VBarChartModel(
          index: 13,
          colors: setColor((_nutinfo!['copper'] / 10000)/3 * 100),
          jumlah: (_nutinfo!['copper'] / 10000)/3 * 100,
          tooltip: ((_nutinfo!['copper'] / 10000)/3 * 100).toInt().toString() + "%",
          label: '구리'),
      VBarChartModel(
          index: 14,
          colors: setColor((_nutinfo!['vitA'] / 3000)/3 * 100),
          jumlah: (_nutinfo!['vitA'] / 3000)/3 * 100,
          tooltip: ((_nutinfo!['vitA'] / 3000)/3 * 100).toInt().toString() + "%",
          label: '비타민 A'),
      VBarChartModel(
          index: 15,
          colors: setColor((_nutinfo!['vitB1'] / 1.2)/3 * 100),
          jumlah: (_nutinfo!['vitB1'] / 1.2)/3 * 100,
          tooltip: ((_nutinfo!['vitB1'] / 1.2)/3 * 100).toInt().toString() + "%",
          label: '비타민 B1'),
      VBarChartModel(
          index: 16,
          colors: setColor((_nutinfo!['vitB2'] / 1.5)/3 * 100),
          jumlah: (_nutinfo!['vitB2'] / 1.5)/3 * 100,
          tooltip: ((_nutinfo!['vitB2'] / 1.5)/3 * 100).toInt().toString() + "%",
          label: '비타민 B2'),
      VBarChartModel(
          index: 17,
          colors: setColor((_nutinfo!['vitB3'] / 16)/3 * 100),
          jumlah: (_nutinfo!['vitB3'] / 16)/3 * 100,
          tooltip: ((_nutinfo!['vitB3'] / 16)/3 * 100).toInt().toString() + "%",
          label: '비타민 B3'),
      VBarChartModel(
          index: 18,
          colors: setColor((_nutinfo!['vitB5'] / 5)/3 * 100),
          jumlah: (_nutinfo!['vitB5'] / 5)/3 * 100,
          tooltip: ((_nutinfo!['vitB5'] / 16)/3 * 100).toInt().toString() + "%",
          label: '비타민 B5'),
      VBarChartModel(
          index: 19,
          colors: setColor((_nutinfo!['vitB6'] / 100)/3 * 100),
          jumlah: (_nutinfo!['vitB6'] / 100)/3 * 100,
          tooltip: ((_nutinfo!['vitB6'] / 100)/3 * 100).toInt().toString() + "%",
          label: '비타민 B6'),
      VBarChartModel(
          index: 20,
          colors: setColor((_nutinfo!['vitB7'] / 30)/3 * 100),
          jumlah: (_nutinfo!['vitB7'] / 30)/3 * 100,
          tooltip: ((_nutinfo!['vitB7'] / 30)/3 * 100).toInt().toString() + "%",
          label: '비타민 B7'),
      VBarChartModel(
          index: 21,
          colors: setColor((_nutinfo!['vitB9'] / 1000)/3 * 100),
          jumlah: (_nutinfo!['vitB9'] / 1000)/3 * 100,
          tooltip: ((_nutinfo!['vitB9'] / 1000)/3 * 100).toInt().toString() + "%",
          label: '비타민 B9'),
      VBarChartModel(
          index: 22,
          colors: setColor((_nutinfo!['vitB12'] / 2.4)/3 * 100),
          jumlah: (_nutinfo!['vitB12'] / 2.4)/3 * 100,
          tooltip: ((_nutinfo!['vitB12'] / 2.4)/3 * 100).toInt().toString() + "%",
          label: '비타민 B12'),
      VBarChartModel(
          index: 23,
          colors: setColor((_nutinfo!['vitC'] / 2000)/3 * 100),
          jumlah: (_nutinfo!['vitC'] / 2000)/3 * 100,
          tooltip: ((_nutinfo!['vitC'] / 2000)/3 * 100).toInt().toString() + "%",
          label: '비타민 C'),
      VBarChartModel(
          index: 24,
          colors: setColor((_nutinfo!['vitD'] / 100)/3 * 100),
          jumlah: (_nutinfo!['vitD'] / 100)/3 * 100,
          tooltip: ((_nutinfo!['vitD'] / 100)/3 * 100).toInt().toString() + "%",
          label: '비타민 D'),
      VBarChartModel(
          index: 25,
          colors: setColor((_nutinfo!['vitE'] / 540)/3 * 100),
          jumlah: (_nutinfo!['vitE'] / 540)/3 * 100,
          tooltip: ((_nutinfo!['vitE'] / 540)/3 * 100).toInt().toString() + "%",
          label: '비타민 E'),
      VBarChartModel(
          index: 26,
          colors: setColor((_nutinfo!['vitK'] / 75)/3 * 100),
          jumlah: (_nutinfo!['vitK'] / 75)/3 * 100,
          tooltip: ((_nutinfo!['vitK'] / 75)/3 * 100).toInt().toString() + "%",
          label: '비타민 K'),
      VBarChartModel(
          index: 27,
          colors: setColor((_nutinfo!['omega'] / 210)/3 * 100),
          jumlah: (_nutinfo!['omega'] / 210)/3 * 100,
          tooltip: ((_nutinfo!['omega'] / 210)/3 * 100).toInt().toString() + "%",
          label: '오메가'),
    ];

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
                Flexible(
                    flex: 1,
                    child: (_result != 'fail')
                        //음식 추정 실패시 김치전 사진이 나오도록
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                                width: 200,
                                height: 100,
                                child: Image.file(File(_image!.path),
                                    fit: BoxFit.fill)),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: 200,
                              height: 100,
                              child: Image(
                                  image: AssetImage('assets/kimchi.jpg'),
                                  fit: BoxFit.fill),
                            ),
                          )),
                Flexible(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
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
            SingleChildScrollView(scrollDirection: Axis.vertical,child:Graph()),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ResultScreen(_image!, _result!, _nutinfo!)));
                },
                child: Text("닫기", style: TextStyle(fontSize: 10)))
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
                        Container(
                          width: 5,
                        ),
                        Text("추가한 식단"),
                      ],
                    ))
              ],
            ),
            Container1(),
          ],
        ));
  }
}
