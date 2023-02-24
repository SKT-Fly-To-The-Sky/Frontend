import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:vertical_barchart/vertical-barchart.dart';
import 'package:vertical_barchart/vertical-barchartmodel.dart';
import 'package:provider/provider.dart';
import '../provider/supplementProvider.dart';

class CheckBoxListView extends StatefulWidget {
  @override
  _CheckBoxListViewState createState() => _CheckBoxListViewState();
}

class _CheckBoxListViewState extends State<CheckBoxListView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var provide = Provider.of<supplementProvider>(context, listen: false);

    List<String> morningSupNames = provide.supplementList;
    List<bool> morningSupChecked = provide.supplementChecked;
    List<String> morningSupCnts = provide.supplementCnts;

    List<String> lunchSupNames = provide.lunchSupList;
    List<bool> lunchSupChecked = provide.lunchSupChecked;
    List<String> lunchSupCnts = provide.lunchSupCnts;

    List<String> dinnerSupNames = provide.dinnerSupList;
    List<bool> dinnerSupChecked = provide.dinnerSupChecked;
    List<String> dinnerSupCnts = provide.dinnerSupCnts;

    // int sum = morningSupChecked.where((e) => e == true).length;
    // int total = morningSupNames.length;

    int sum = morningSupChecked.where((e) => e == true).length +
        lunchSupChecked.where((e) => e == true).length +
        dinnerSupChecked.where((e) => e == true).length;
    int total =
        morningSupNames.length + lunchSupNames.length + dinnerSupNames.length;
    double percent = sum / total * 100;

    List<VBarChartModel> barChartData = [
      VBarChartModel(
        index: 0,
        colors: [Color(0xFF3617CE), Colors.teal],
        jumlah: percent.ceil().toDouble(),
        tooltip: "${percent.ceil()}%",
      ),
    ];
    return Container(
      child: Column(
        children: [
          Container(
            width: screenWidth,
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
                        tooltipSize: 50,
                        labelSizeFactor: 0.3,
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
                  itemCount: morningSupNames.length,
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
                                      morningSupChecked[i]
                                          ? Text(
                                              morningSupNames[i],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                              morningSupNames[i],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Text(
                                        morningSupCnts[i],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    setState(() {
                                      morningSupChecked[i] =
                                          !morningSupChecked[i];
                                    });
                                  },
                                  isChecked:
                                      morningSupChecked[i] ? true : false,
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
                  itemCount: lunchSupNames.length,
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
                                      morningSupChecked[i]
                                          ? Text(
                                              lunchSupNames[i],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                              lunchSupNames[i],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Text(
                                        lunchSupCnts[i],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    setState(() {
                                      lunchSupChecked[i] = !lunchSupChecked[i];
                                    });
                                  },
                                  isChecked: lunchSupChecked[i] ? true : false,
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
                  itemCount: dinnerSupNames.length,
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
                                      dinnerSupChecked[i]
                                          ? Text(
                                              dinnerSupNames[i],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                              dinnerSupNames[i],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Text(
                                        dinnerSupCnts[i],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    setState(() {
                                      dinnerSupChecked[i] =
                                          !dinnerSupChecked[i];
                                    });
                                  },
                                  isChecked: dinnerSupChecked[i] ? true : false,
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
