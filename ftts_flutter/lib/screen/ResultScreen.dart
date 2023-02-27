import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:vertical_barchart/vertical-legend.dart';
import 'dart:io';
import '../utils/TMapPlugin.dart';
import 'GraphScreen.dart';
import '../widget/DailyGraph.dart';
import 'package:url_launcher/url_launcher.dart';

class JsonListView extends StatefulWidget {
  final String timeDiv;
  JsonListView(this.timeDiv,{Key?key,}):super(key:key);

  @override
  _JsonListViewState createState() => _JsonListViewState();
}

class _JsonListViewState extends State<JsonListView> {

  List<dynamic> _jsonData = [];
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    foodRecommand(widget.timeDiv);
  }

  Future<void> foodRecommand(String day) async {
    var foodrecommand = [];
    var recommanddata = await dio.get(
        'http://jeongsuri.iptime.org:10019/dodo/foods/recommand',
        queryParameters: {'time_div': day});

    if (recommanddata.statusCode == 200) {
      setState(() {
        for (int i = 0; i < 3; i++) {
          foodrecommand.add([
            recommanddata.data[i]["name"].toString(),
            recommanddata.data[i]["image"].toString()
          ]);
        }
        _jsonData = foodrecommand;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(url) async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Container(
      margin: EdgeInsets.only(right: 20),
      height: 350,
      // width: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _jsonData.length,
          itemBuilder: (context, i) {
            final data = _jsonData[i];
            return Container(
              width: 300,
              padding: const EdgeInsets.only(
                  left: 15, right: 10, top: 10, bottom: 15),
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.0,
                        color: Color.fromARGB(255, 216, 216, 216),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                      width: 300,
                                      height: 300,
                                      child: Image.network(
                                        data[1],
                                        fit: BoxFit.fill,
                                      ))),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 10, right: 10),
                                child: Text(
                                  "다음 식사는 " + data[0] + " 어때요?",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 5, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image(
                                      image: AssetImage('assets/Tmap_logo.png'),
                                      width: 30,
                                    ),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Color(0xFF3617CE),
                                        ),
                                        onPressed: () {
                                          TMapPlugin.exeTMap(data[0]);
                                        },
                                        child: Text("근처 식당 경로찾기"))
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final XFile? _image;
  final List<dynamic>? _result;
  final Map<String, dynamic>? _nutinfo;
  final String timeDiv;

  ResultScreen(this._image, this._result, this._nutinfo,this.timeDiv, {super.key});

  @override
  Widget build(BuildContext context) {
    print("&+*******************************");
    print(_result);
    //그래프 색상 설정 함수. 100프로 이상이면 red, 100이하 80이상이면 green, 80이하면 yellow
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
      ['지방', 'fat', 65, 'mg']
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

    Widget Graph() {
      return Container(
          padding: EdgeInsets.only(right: 15),
          child: VerticalBarchart(
            background: Colors.transparent,
            data: bardata,
            barSize: 11,
            labelSizeFactor: 0.24,
            maxX: 100,
            tooltipSize: 45,
            showBackdrop: true,
            showLegend: true,
            barStyle: BarStyle.DEFAULT,
            legend: [
              Vlegend(isSquare: false, color: Colors.green, text: "적정"),
              Vlegend(isSquare: false, color: Colors.red, text: "과잉"),
              Vlegend(isSquare: false, color: Colors.yellow, text: "부족"),
            ],
          ));
    }

    Widget CircleGraph() {
      return Container(
          height: 180,
          width: 180,
          child: SfCircularChart(series: <CircularSeries>[
            // Renders doughnut chart
            DoughnutSeries<DoughnutChartData, String>(
                dataSource: doughnutChartData,
                pointColorMapper: (DoughnutChartData data, _) => data.color,
                xValueMapper: (DoughnutChartData data, _) => data.x,
                yValueMapper: (DoughnutChartData data, _) => data.y,
                dataLabelMapper: (DoughnutChartData data, _) => data.x,
                dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelIntersectAction: LabelIntersectAction.shift),
                radius: '100%'
                // cornerStyle: CornerStyle.bothCurve
                )
          ]));
    }

    Widget CircleGraph2() {
      return Container(
          height: 180,
          width: 180,
          child: SfCircularChart(series: <CircularSeries>[
            // Renders doughnut chart
            DoughnutSeries<DoughnutChartData, String>(
                dataSource: doughnutChartData2,
                pointColorMapper: (DoughnutChartData data, _) => data.color,
                xValueMapper: (DoughnutChartData data, _) => data.x,
                yValueMapper: (DoughnutChartData data, _) => data.y,
                dataLabelMapper: (DoughnutChartData data, _) => data.x,
                dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelIntersectAction: LabelIntersectAction.shift),
                radius: '100%'
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
        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    //child: (_image!='fail')?Expanded(child:Image.network(_result![0])):
                    child: (_image != null) && (_result![0][0] != '불고기')
                        ? Expanded(
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: 200,
                              height: 100,
                              child: Image.file(File(_image!.path!),
                                  fit: BoxFit.fill),
                            ),
                          ))
                        : Expanded(
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: 200,
                              height: 100,
                              child: Image(
                                  image: AssetImage('assets/firegogi.jpg'),
                                  fit: BoxFit.fill),
                            ),
                          ))),
                Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        for (int i = 0; i < _result!.length; i++)
                          Text(_result![i][0])
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
                              GraphScreen(_image, _result, _nutinfo)));
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
            ],
          ));
    }

    return //this._image != null ?
        Scaffold(
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
            body: SingleChildScrollView(
              child: Column(
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
                  Container2(),
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, top: 15, bottom: 5, right: 20),
                      child: Row(
                        children: [
                          Icon(Icons.room_service_outlined),
                          Container(
                            width: 5,
                          ),
                          Text(
                            "음식 메뉴 추천",
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ],
                      )),
                  Center(child: JsonListView(timeDiv))
                ],
              ),
            ));
  }
}
