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
    List<Color> setColor(double a) {
      if (a > 100) {
        return [Colors.deepOrange, Colors.red];
      } else if (a > 60) {
        return [Colors.green, Colors.teal];
      } else {
        return [Colors.limeAccent, Colors.yellow];
      }
    }

    List<dynamic> recommedInfo = [
      ['칼로리', 'kcal', 2600, 'kcal'],
      ['탄수화물', 'carbo', 130, 'mg'],
      ['단백질', 'protein', 65, 'mg'],
      ['지방', 'fat', 65, 'mg'],
      ['설탕', 'sugar', 100, 'mg'],
      ['콜레스테롤', 'chole', 300, 'mg'],
      ['식이섬유', 'fiber', 30, '㎍'],
      ['칼슘', 'calcium', 2500, '㎍'],
      ['철', 'iron', 45, '㎍'],
      ['마그네슘', 'magne', 360, 'mg'],
      ['칼륨', 'potass', 3500, '㎍'],
      ['나트륨', 'sodium', 2300, 'mg'],
      ['아연', 'zinc', 75, '㎍'],
      ['구리', 'copper', 10000, 'mg']
    ];

    List<VBarChartModel> bardata = [];
    for (int i = 0; i < recommedInfo.length; i++) {
      bardata.add(VBarChartModel(
          index: i,
          colors: setColor(
              (_nutinfo![recommedInfo[i][1]] / recommedInfo[i][2]) * 100),
          jumlah: (_nutinfo![recommedInfo[i][1]] / recommedInfo[i][2]) * 100,
          tooltip: ((_nutinfo![recommedInfo[i][1]] / recommedInfo[i][2]) * 100)
                  .ceil()
                  .toString() +
              recommedInfo[i][3],
          //+단위
          label: recommedInfo[i][0]));
    }

    Widget Graph() {
      return Container(
        padding: EdgeInsets.only(right: 15),
        child: VerticalBarchart(
          background: Colors.transparent,
          data: bardata,
          barSize: 12,
          labelSizeFactor: 0.27,
          maxX: 100,
          tooltipSize: 35,
          showBackdrop: true,
          showLegend: true,
          barStyle: BarStyle.DEFAULT,
          legend: [
            Vlegend(isSquare: false, color: Colors.green, text: "적정"),
            Vlegend(isSquare: false, color: Colors.red, text: "과잉"),
            Vlegend(isSquare: false, color: Colors.yellow, text: "부족"),
          ],
        ),
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
                    child: (_image != null) && (_result != '불고기')
                        //음식 추정 실패시 김치전 사진이 나오도록
                        ? Expanded(
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                                width: 200,
                                height: 100,
                                child: Image.file(File(_image!.path),
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
                            for (var res in _result!) Text(res as String)
                      ],
                    ))
              ],
            ),
            Graph(),
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
