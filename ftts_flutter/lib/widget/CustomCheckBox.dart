import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';

class CheckBoxListView extends StatefulWidget {
  @override
  _CheckBoxListViewState createState() => _CheckBoxListViewState();
}

class _CheckBoxListViewState extends State<CheckBoxListView> {
  List<VBarChartModel> barChartData = [
    const VBarChartModel(
      index: 0,
      colors: [Color(0xFF3617CE), Colors.teal],
      jumlah: 83,
      tooltip: "83%",
      // label: '칼로리'
    ),
  ];

  // 아침
  final List<String> morningPillNames = ["아침1", "아침2"];
  final List<String> morningPillCnts = ["1정", "2정"];
  List<bool> _morningChecked = [false, false];

  // 점심
  final List<String> lunchPillNames = ["점심1", "점심2"];
  final List<String> lunchPillCnts = ["1정", "2정"];
  List<bool> _lunchChecked = [false, false];

  // 저녁
  final List<String> dinnerPillNames = ["저녁1", "저녁2"];
  final List<String> dinnerPillCnts = ["1정", "2정"];
  List<bool> _dinnerChecked = [false, false];

  int total = 0;
  int sum = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.9,
            margin: EdgeInsets.all(0),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    width: screenWidth * 0.90,
                    child: VerticalBarchart(
                        background: Colors.transparent,
                        labelColor: Colors.black,
                        tooltipColor: Colors.black,
                        data: barChartData,
                        showBackdrop: true,
                        barStyle: BarStyle.DEFAULT,
                        barSize: 20,
                        maxX: 100,
                        backdropColor: Color(0xffd6d0f5)))),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 5),
            child: Column(
              children: [
                Morning(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: morningPillNames.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: screenWidth * 0.7,
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _morningChecked[i]
                                          ? Text(
                                              morningPillNames[i],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                              morningPillNames[i],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Text(
                                        morningPillCnts[i],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    setState(() {
                                      _morningChecked[i] = !_morningChecked[i];
                                    });
                                  },
                                  isChecked: _morningChecked[i] ? true : false,
                                  borderColor: Color.fromARGB(255, 54, 23, 206),
                                  checkedColor:
                                      Color.fromARGB(255, 54, 23, 206),
                                  uncheckedColor: Colors.white,
                                  checkedWidget:
                                      Icon(Icons.done, color: Colors.white),
                                  uncheckedWidget: Icon(Icons.done,
                                      color: Color.fromARGB(255, 54, 23, 206)),
                                  animationDuration: Duration(seconds: 0),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                Lunch(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lunchPillNames.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: screenWidth * 0.7,
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _lunchChecked[i]
                                          ? Text(
                                              lunchPillNames[i],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                              lunchPillNames[i],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Text(
                                        lunchPillCnts[i],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    setState(() {
                                      _lunchChecked[i] = !_lunchChecked[i];
                                    });
                                  },
                                  isChecked: _lunchChecked[i] ? true : false,
                                  borderColor: Color.fromARGB(255, 54, 23, 206),
                                  checkedColor:
                                      Color.fromARGB(255, 54, 23, 206),
                                  uncheckedColor: Colors.white,
                                  checkedWidget:
                                      Icon(Icons.done, color: Colors.white),
                                  uncheckedWidget: Icon(Icons.done,
                                      color: Color.fromARGB(255, 54, 23, 206)),
                                  animationDuration: Duration(seconds: 0),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                Dinner(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dinnerPillNames.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: screenWidth * 0.7,
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _dinnerChecked[i]
                                          ? Text(
                                              dinnerPillNames[i],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                              dinnerPillNames[i],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Text(
                                        dinnerPillCnts[i],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    setState(() {
                                      _dinnerChecked[i] = !_dinnerChecked[i];
                                    });
                                  },
                                  isChecked: _dinnerChecked[i] ? true : false,
                                  borderColor: Color.fromARGB(255, 54, 23, 206),
                                  checkedColor:
                                      Color.fromARGB(255, 54, 23, 206),
                                  uncheckedColor: Colors.white,
                                  checkedWidget:
                                      Icon(Icons.done, color: Colors.white),
                                  uncheckedWidget: Icon(Icons.done,
                                      color: Color.fromARGB(255, 54, 23, 206)),
                                  animationDuration: Duration(seconds: 0),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget Morning() {
  return Container(
      child: Row(
    children: [
      Icon(
        Icons.wb_twighlight,
        color: Colors.yellow,
      ),
      Container(
        width: 5,
      ),
      Text(
        "아침",
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      ),
    ],
  ));
}

Widget Lunch() {
  return Container(
      child: Row(
    children: [
      Icon(
        Icons.wb_sunny,
        color: Colors.orange,
      ),
      Container(
        width: 5,
      ),
      Text(
        "점심",
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      ),
    ],
  ));
}

Widget Dinner() {
  return Container(
      child: Row(
    children: [
      Icon(
        Icons.mode_night,
        color: Color.fromARGB(255, 255, 196, 0),
      ),
      Container(
        width: 5,
      ),
      Text(
        "저녁",
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      ),
    ],
  ));
}
