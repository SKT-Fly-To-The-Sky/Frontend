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


    List<dynamic> morningData=provide.supplemetsMorningInfo;
    List<dynamic> lunchData=provide.supplemetsLunchInfo;
    List<dynamic> dinnerData=provide.supplemetsDinnerInfo;

    print("ALLSupNames");
    print(morningSupNames);
    print("morningSupNames");
    print(morningData);
    print("lunchSupNames");
    print(lunchData);
    print("dinnerSupNames");
    print(dinnerData);

    int newsum=morningData.where((e)=>e[1]==true).fold(0,(sum,_)=>sum+1).toInt()+
        lunchData.where((e)=>e[1]==true).fold(0,(sum,_)=>sum+1).toInt()+
        dinnerData.where((e)=>e[1]==true).fold(0,(sum,_)=>sum+1).toInt();

    double newpercent=newsum/morningSupNames.length*100;

    List<VBarChartModel> barChartData = [
      VBarChartModel(
        index: 0,
        colors: [Color(0xFF3617CE), Colors.teal],
        jumlah: newpercent.ceil().toDouble(),
        tooltip: "${newpercent.ceil()}%",
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
                  itemCount: //morningSupNames.length,
                  morningData.length,
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
                                      morningData[i][1]
                                          ? Text(
                                        morningData[i][0],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                        morningData[i][0],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Text(
                                        morningData[i][2],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    setState(() {
                                      provide.changeCheck(i, '아침');
                                      // morningData[i][1]=!morningData[i][1];
                                    });
                                  },
                                  isChecked:
                                      morningData[i][1]?true:false,
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
                  itemCount: //lunchSupNames.length,
                  lunchData.length,
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
                                    lunchData[i][1]
                                          ? Text(
                                      lunchData[i][0],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                              // lunchSupNames[i],
                                      lunchData[i][0],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Text(
                                        lunchData[i][2],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    setState(() {
                                      provide.changeCheck(i, '점심');

                                    });
                                  },
                                  isChecked: lunchData[i][1]?true:false,
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
                  itemCount: dinnerData.length,
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
                                      dinnerData[i][1]
                                      //dinnerSupChecked[i]
                                          ? Text(
                                              dinnerData[i][0],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            )
                                          : Text(
                                              dinnerData[i][0],
                                              //dinnerSupNames[i],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      Text(
                                        dinnerData[i][2],
                                        //dinnerSupCnts[i],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: RoundCheckBox(
                                  onTap: (selected) {
                                    setState(() {
                                      provide.changeCheck(i, '저녁');
                                    });
                                  },
                                  isChecked: //dinnerSupChecked[i]
                                  dinnerData[i][1]
                                      ? true : false,
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
