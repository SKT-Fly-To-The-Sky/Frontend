import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widget/CustomCalendar.dart';
import '../widget/DailyGraph.dart';
import '../widget/ImageUploader.dart';
import 'HomeScreen.dart';
import 'MenuScreen.dart';
import '../widget/DetailGraph.dart';
import '../widget/CustomCalendar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF4F6F9),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          // 그림자 농도 0
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
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
              CustomCalendar(),
              Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 15, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ), // width: 200,
              height: 300,
              child: ContainedTabBarView(
                tabs: [
                  Text(
                    'Daily',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Detail',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
                views: [
                  DailyGraph(),
                  DetailGraph(),
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
                      style: TextStyle(fontSize: 17.0),
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
                height: 360,
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
                          "752kcal",
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
                    StaticUploader(),
                    ImageUploader(),
                    UploaderBtn(),
                    UploaderBtn(),
              ],
            ),
          ),
        ])));
  }
}
