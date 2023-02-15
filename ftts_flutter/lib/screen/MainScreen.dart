import 'package:table_calendar/table_calendar.dart';
import 'MenuScreen.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'HomeScreen.dart';
import '../utils.dart';
import '../widget/ImageUploader.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // DatePicker 위젯
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final List<DoughnutChartData> doughnutChartData = [
      DoughnutChartData('섭취한 칼로리', 1700, Color(0xFF3617CE)),
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
            style: TextStyle(color: Colors.black, fontSize: 18),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
                // Navigator.pop(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          TableCalendar(
            locale: 'ko-KR',
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: const Color(0xFF3617CE),
                shape: BoxShape.circle,
              ),
              todayDecoration: const BoxDecoration(
                color: const Color(0xFFaea2eb),
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle: const TextStyle(fontSize: 17.0)),
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
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Weekly',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
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
            height: 400,
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
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "300kcal",
                      style: TextStyle(
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
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "-",
                      style: TextStyle(
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
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "-",
                      style: TextStyle(
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
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "-",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
              views: [
                ImageUploader(),
                ImageUploader(),
                ImageUploader(),
                ImageUploader(),
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
