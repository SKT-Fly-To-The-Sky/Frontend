import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widget/CustomCalendar.dart';
import '../widget/DailyGraph.dart';
import '../widget/ImageUploader.dart';
import 'MenuScreen.dart';
import 'package:intl/intl.dart';
import '../widget/DetailGraph.dart';
import 'package:provider/provider.dart';
import '../provider/dateProvider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF4F6F9),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
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
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [CustomCalendar(), DailyFoodWidget()])));
  }
}

class DailyFoodWidget extends StatefulWidget {
  @override
  _DailyFoodWidgetState createState() => _DailyFoodWidgetState();
}

class _DailyFoodWidgetState extends State<DailyFoodWidget> {
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('yyyy-MM-dd')
        .format(context.watch<dateProvider>().providerDate);

    List<String> foodTimeDiv = ['아침', '점심', '저녁', '간식'];
    Map<String, String> foodEng = {
      '아침': 'morning',
      '점심': 'lunch',
      '저녁': 'dinner',
      '간식': 'snack'
    };
    Map<String, double> foodKcal = {
      'morning': 752,
      'lunch': 0,
      'dinner': 0,
      'snack': 0
    };

    return Container(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 15, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
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
                  "하루 섭취량 ${date}",
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
            height: 380,
            child: ContainedTabBarView(
              onChange: (index) => print(index),
              tabs: [
                for (int i = 0; i < foodTimeDiv.length; i++)
                  Column(
                    children: [
                      Container(
                        height: 3,
                      ),
                      Text(
                        foodTimeDiv[i],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (foodKcal[foodEng[foodTimeDiv[i]]] == 0)
                            ? "-"
                            : "${foodKcal[foodEng[foodTimeDiv[i]]]!.toInt()}kcal",
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
          )
        ],
      ),
    );
  }
}
