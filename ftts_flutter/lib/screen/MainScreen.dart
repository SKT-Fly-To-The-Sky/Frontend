import 'package:table_calendar/table_calendar.dart';
import 'MenuScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'ResultScreen.dart';
import '../model/ConnectServer.dart';
import '../utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final picker = ImagePicker();
  final connectServer = ConnectServer();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    if (image != null) {
      String imagepath = "";
      imagepath = await connectServer.uploading(image);
      if (imagepath != "fail") {
        setState(() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResultScreen(imagepath)));
        });
      }
      //Connect Server로 이동하여 연결
      else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ResultScreen("fail")));
      }
    } else {
      print("_image is null");
    }
  }

  // DatePicker 위젯
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final List<DoughnutChartData> doughnutChartData = [
      DoughnutChartData('섭취한 칼로리', 1700, Color(0xFF334CFF)),
      DoughnutChartData('남은 칼로리', 400, Color(0xFFe8e8e8)),
    ];

    List<StackedBarChartData> stackedBarChartData = [
      StackedBarChartData('지방', 65, 35, Color(0xFF6ec0ff)),
      StackedBarChartData('단백질', 45, 55, Color(0xFF6eff8d)),
      StackedBarChartData('탄수화물', 70, 30, Color(0xFFff6775)),
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF4F6F9),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1.0, // 그림자 농도 0
          title: const Text(
            "A.식단",
            style: TextStyle(
                fontFamily: 'NotoSansKR', color: Colors.black, fontSize: 18),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenuScreen()));
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          Container(
              // padding: const EdgeInsets.all(8.0),
              // width: screenWidth * 0.9,
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 15, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              // width: 200,
              height: 300,
              child: ContainedTabBarView(
                tabs: [
                  Text(
                    'Daily',
                    style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Weekly',
                    style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
                views: [
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(0),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                            width: screenWidth * 0.45,
                            margin: EdgeInsets.all(0),
                            child: SfCircularChart(
                                annotations: <CircularChartAnnotation>[
                                  CircularChartAnnotation(
                                      widget: Container(
                                    child: const Text(
                                      "남은 칼로리\n1700kcal",
                                      style: TextStyle(
                                          fontFamily: 'NotoSansKR',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ))
                                ],
                                series: <CircularSeries>[
                                  // Renders doughnut chart
                                  DoughnutSeries<DoughnutChartData, String>(
                                      dataSource: doughnutChartData,
                                      pointColorMapper:
                                          (DoughnutChartData data, _) =>
                                              data.color,
                                      xValueMapper:
                                          (DoughnutChartData data, _) => data.x,
                                      yValueMapper:
                                          (DoughnutChartData data, _) => data.y,
                                      innerRadius: '70%'
                                      // cornerStyle: CornerStyle.bothCurve
                                      )
                                ])),
                        Container(
                          width: screenWidth * 0.45,
                          child: Container(
                            child: SfCartesianChart(
                              plotAreaBorderColor: Colors.transparent,
                              primaryXAxis: CategoryAxis(
                                  // isVisible: false,
                                  borderColor: Colors.transparent,
                                  axisLine: AxisLine(color: Colors.transparent),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'NotoSansKR',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                  majorGridLines: MajorGridLines(
                                      color: Colors.transparent)),
                              primaryYAxis: CategoryAxis(
                                isVisible: false,
                              ),
                              palette: <Color>[
                                Color(0xFFe8e8e8),
                              ],
                              series: <ChartSeries>[
                                StackedBar100Series<StackedBarChartData,
                                        String>(
                                    dataSource: stackedBarChartData,
                                    pointColorMapper:
                                        (StackedBarChartData data, _) =>
                                            data.color,
                                    xValueMapper:
                                        (StackedBarChartData data, _) => data.x,
                                    yValueMapper:
                                        (StackedBarChartData data, _) =>
                                            data.y1,
                                    width: 0.4,
                                    spacing: 0.2),
                                StackedBar100Series<StackedBarChartData,
                                        String>(
                                    dataSource: stackedBarChartData,
                                    xValueMapper:
                                        (StackedBarChartData data, _) => data.x,
                                    yValueMapper:
                                        (StackedBarChartData data, _) =>
                                            data.y2,
                                    width: 0.4,
                                    spacing: 0.2)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(Icons.rice_bowl_sharp),
                Container(
                  width: 5,
                ),
                Text(
                  "하루 섭취량",
                )
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 300,
            child: ContainedTabBarView(
              onChange: (index) => print(index),
              tabs: [
                Column(
                  children: [
                    Container(
                      height: 3,
                    ),
                    Text(
                      '아침',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "300kcal",
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 3,
                    ),
                    Text(
                      '점심',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "-",
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 3,
                    ),
                    Text(
                      '저녁',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "-",
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 3,
                    ),
                    Text(
                      '간식',
                      style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "-",
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
              views: [
                Container(color: Colors.white),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // 카메라 촬영 버튼 동작
                          FloatingActionButton(
                            backgroundColor: Color(0xFF334CFF),
                            child: Icon(Icons.add_a_photo),
                            tooltip: 'pick Image',
                            onPressed: () {
                              //카메라에서 이미지 가져오기
                              getImage(ImageSource.camera);
                            },
                          ),
                          // 갤러리에서 이미지를 가져오는 버튼
                          FloatingActionButton(
                            backgroundColor: Color(0xFF334CFF),
                            child: Icon(Icons.wallpaper),
                            tooltip: 'pick Image',
                            onPressed: () {
                              //갤러리에서 이미지 가져오기
                              getImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(color: Colors.white),
                Container(color: Colors.white)
              ],
            ),
          ),
        ])));
  }
}

class DoughnutChartData {
  DoughnutChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class StackedBarChartData {
  final String x;
  final num y1;
  final num y2;
  final Color color;
  StackedBarChartData(this.x, this.y1, this.y2, this.color);
}
