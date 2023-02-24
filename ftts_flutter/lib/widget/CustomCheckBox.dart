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

// 아침
final List<String> morningPillNames = ["아이즈업 컴포트"];
final List<String> morningPillCnts = ["1정"];
List<bool> _morningChecked = [false];

// 점심
final List<String> lunchPillNames = ["Thorne 비타민 B-Complex"];
final List<String> lunchPillCnts = ["1정"];
List<bool> _lunchChecked = [false];

// 저녁
final List<String> dinnerPillNames = ["Thorne 칼슘-마그네슘"];
final List<String> dinnerPillCnts = ["1정"];
List<bool> _dinnerChecked = [false];

class _CheckBoxListViewState extends State<CheckBoxListView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var provide = Provider.of<supplementProvider>(context, listen: false);
    List<String> providerPillNames = provide.supplementList;
    List<bool> providerPillChecked = provide.supplementChecked;
    List<String> providerPillCnts = provide.supplementPillCnts;

    int sum = providerPillChecked.where((e) => e == true).length;
    int total = providerPillNames.length;
    double percent = sum / total * 100;
    print(sum);
    print(total);
    print(percent);
    // int sum = _morningChecked.where((e) => e == true).length +
    //     _lunchChecked.where((e) => e == true).length +
    //     _dinnerChecked.where((e) => e == true).length;
    // int total = morningPillNames.length +
    //     lunchPillNames.length +
    //     dinnerPillNames.length;

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
                  itemCount: providerPillNames.length,
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
                                      providerPillChecked[i]
                                          ? Text(
                                              providerPillNames[i],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                              providerPillNames[i],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Text(
                                        providerPillCnts[i],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    setState(() {
                                      providerPillChecked[i] =
                                          !providerPillChecked[i];
                                      // _morningChecked[i] = !_morningChecked[i];
                                    });
                                  },
                                  isChecked:
                                      providerPillChecked[i] ? true : false,
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
                Dinner(),
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
