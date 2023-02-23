import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';

import '../provider/supplementProvider.dart';

class SupplementsGrapeScreen extends StatelessWidget {

  const SupplementsGrapeScreen({super.key});

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

    List<dynamic> recommedInfo=[
      ['비타민A','vitA',3000,'㎍'],['비타민B1','vitB1',1.2,'mg'],['비타민B2','vitB2',1.5,'mg'],['비타민B3','vitB3',16,'mg'],
      ['비타민B5','vitB5',5,'mg'],['비타민B6','vitB6',100,'mg'],['비타민B7','vitB7',30,'㎍'],['비타민B9','vitB9', 1000,'㎍'],
      ['비타민B12','vitB12', 2.4,'㎍'],['비타민C','vitC',2000,'mg'],['비타민D','vitD', 100,'㎍'],['비타민E','vitE', 540,'mg'],
      ['비타민K','vitK', 75,'㎍'],['오메가','omega',210,'mg']
    ];

    List<VBarChartModel> bardata = [];

    for (int i=0;i<recommedInfo.length;i++){
      bardata.add(VBarChartModel(
          index: i,
          colors: setColor((_nutinfo[recommedInfo[i][1]]/recommedInfo[i][2])*100),
          jumlah: (_nutinfo[recommedInfo[i][1]]/recommedInfo[i][2])*100,
          tooltip: ((_nutinfo[recommedInfo[i][1]]/recommedInfo[i][2])*100).ceil().toString()+recommedInfo[i][3],//+단위
          label: recommedInfo[i][0]
      ));
    }

    Widget Grape() {
      return Container(
        height: 510,
        padding: EdgeInsets.only(right: 15),
        child: VerticalBarchart(
          background: Colors.transparent,
          data: bardata,
          barSize: 13,
          maxX: 100,
          labelSizeFactor: 0.28,
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
