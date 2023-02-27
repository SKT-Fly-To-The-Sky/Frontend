import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:ftts_flutter/model/ConnectServer.dart';
import '../widget/CustomCalendar.dart';
import '../widget/DailyGraph.dart';
import '../widget/ImageUploader.dart';
import 'MenuScreen.dart';
import 'package:intl/intl.dart';
import '../widget/DetailGraph.dart';
import 'package:provider/provider.dart';
import '../provider/dateProvider.dart';
import 'package:dio/dio.dart';
import '../widget/StaticUploader.dart';

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
  String? date;
  String? url;
  String? timeDiv;
  Response? response;
  List<String> foodTimeDiv = ['morning', 'lunch', 'dinner', 'snack'];
  List<String> foodTimeDivName = ['아침', '점심', '저녁', '간식'];
  final connectServer = ConnectServer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    date = DateFormat('yyyy-MM-dd')
        .format(context.watch<dateProvider>().providerDate);

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
                  date == '2023-02-28' ? DetailGraph() : StaticDetailGraph(),
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
            height: 320,
            child: ContainedTabBarView(
              onChange: (index) {
                setState(() {});
              },
              tabs: [
                for (int i = 0; i < foodTimeDiv.length; i++)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   height: 3,
                      // ),
                      Text(
                        foodTimeDivName[i],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //   _timeDivInfo![foodTimeDiv[i][0]] != null
                      //       ? (_timeDivInfo![foodTimeDiv[i][0]] == 0)
                      //           ? "-"
                      //           : "${_timeDivInfo![foodTimeDiv[i][0]]}kcal"
                      //       : "-",
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ],
                  ),
              ],
              views: [
                StaticUploader(date!, 0),
                (date == '2023-02-28')
                    ? ImageUploader("lunch", date!)
                    : StaticUploader(date!, 1),
                (date == '2023-02-28')
                    ? ImageUploader("dinner", date!)
                    : StaticUploader(date!, 2),
                ImageUploader("snack", date!),
              ],
            ),
          )
        ],
      ),
    );
  }
}
