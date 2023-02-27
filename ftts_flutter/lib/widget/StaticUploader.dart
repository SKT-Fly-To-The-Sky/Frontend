
import 'package:flutter/material.dart';
import 'package:rounded_background_text/rounded_background_text.dart';



Map<String, dynamic> data = {
  '2023-02-25': [
    //[음식메뉴], url,         칼로리,탄, 단, 지
    //index: 0, 1,                  2, 3, 4, 5,
    [
      ['옥수수스프', '빵'],
      'assets/diet_day1_morning.jpg',
      803,
      103.9,
      15.9,
      33.6
    ], //morning
    [
      ['짜장면'],
      'assets/diet_day1_lunch.jpg',
      529,
      86.2,
      16.2,
      13.3
    ], //lunch
    [
      ['삼겹살구이', '냉면'],
      'assets/diet_day1_dinner.jpg',
      968,
      66.7,
      35.98,
      69.5
    ], //dinner
  ],
  '2023-02-26': [
    [
      ['연어샐러드'],
      'assets/diet_day2_morning.jpg',
      190,
      12,
      13,
      10
    ], //morning
    [
      ['떡볶이', '순대'],
      'assets/diet_day2_lunch.jpg',
      842,
      123.4,
      27,
      26.6
    ], //lunch
    [
      ['장어덮밥'],
      'assets/diet_day2_dinner.jpg',
      716.5,
      97.3,
      30,
      22.976
    ], //dinner
  ],
  '2023-02-27': [
    [
      ['베이글샌드위치'],
      'assets/diet_day3_morning.jpg',
      340,
      52,
      13,
      9
    ], //morning
    [
      ['마르게리타피자'],
      'assets/diet_day3_lunch.jpg',
      825,
      74,
      41,
      42
    ], //lunch
    [
      ['연어초밥'],
      'assets/diet_day3_dinner.jpg',
      447.3,
      71,
      18.8,
      9.7
    ], //dinner
  ],
};

class StaticUploader extends StatelessWidget {
  String staticDate;
  int staticTimeDiv;
  StaticUploader(this.staticDate, this.staticTimeDiv, {super.key});
  List<List>? todayList;

  @override
  Widget build(BuildContext context) {
    return data[staticDate] != null
        ? Container(
            child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
                      width: 210,
                      height: 140,
                      child: Image(
                          image: AssetImage(data[staticDate][staticTimeDiv][1]),
                          fit: BoxFit.fill)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
                              child: RoundedBackgroundText(
                                '탄',
                                style: const TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                backgroundColor: Color(0xffffb3ba),
                              )),
                          Text(
                            '${data[staticDate][staticTimeDiv][3]} g',
                            style: TextStyle(
                                fontFamily: 'NotoSansKR', fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
                              child: RoundedBackgroundText(
                                '단',
                                style: const TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                backgroundColor: Color(0xffffffba),
                              )),
                          Text(
                            '${data[staticDate][staticTimeDiv][4]} g',
                            style: TextStyle(
                                fontFamily: 'NotoSansKR', fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
                              child: RoundedBackgroundText(
                                '지',
                                style: const TextStyle(
                                    fontFamily: 'NotoSansKR',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                backgroundColor: Color(0xffbae1ff),
                              )),
                          Text(
                            '${data[staticDate][staticTimeDiv][5]} g',
                            style: TextStyle(
                                fontFamily: 'NotoSansKR', fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10.0, right: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.restaurant_menu_outlined),
                            Text(
                              " 음식 메뉴",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //     margin: EdgeInsets.only(
                      //       left: 170,
                      //     ),
                      //     child: TextButton(
                      //         style: TextButton.styleFrom(
                      //           primary: Color(0xFF3617CE),
                      //         ),
                      //         onPressed: () {
                      //           // Navigator.push(
                      //           //     context,
                      //           //     MaterialPageRoute(
                      //           //         builder: (context) =>
                      //           //             ResultScreen(_image!, _result!, _nut!)));
                      //         },
                      //         child: Text(
                      //           "상세 보기",
                      //           style: TextStyle(fontSize: 14),
                      //         ))),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 0.0, right: 3.0, bottom: 5.0, top: 5.0),
                      child: (data![staticDate][staticTimeDiv][0] != null)
                          ? Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              children: [
                                for (int i = 0;
                                    i <
                                        data![staticDate][staticTimeDiv][0]!
                                            .length;
                                    i++)
                                  FoodMenu(
                                      data[staticDate][staticTimeDiv][0][i])
                              ],
                            )
                          : Container())
                ],
              ),
            ],
          ))
        : Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: 'camera',
                    backgroundColor: Color(0xFF3617CE),
                    child: Icon(Icons.add_a_photo),
                    tooltip: 'pick Image',
                    onPressed: () {},
                  ),
                  FloatingActionButton(
                    heroTag: 'gallery',
                    backgroundColor: Color(0xFF3617CE),
                    child: Icon(Icons.wallpaper),
                    tooltip: 'pick Image',
                    onPressed: () {},
                  ),
                ])
          ]));
  }
}

Widget FoodMenu(String text) {
  return Container(
      margin: EdgeInsets.fromLTRB(15.0, 0.0, 5.0, 10.0),
      child: RoundedBackgroundText(
        text,
        style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
        backgroundColor: Colors.grey[100],
      ));
}

class UploaderBtn extends StatelessWidget {
  const UploaderBtn({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        FloatingActionButton(
          heroTag: 'camera',
          backgroundColor: Color(0xFF3617CE),
          child: Icon(Icons.add_a_photo),
          tooltip: 'pick Image',
          onPressed: () {
            // getImage(ImageSource.camera);
          },
        ),
        FloatingActionButton(
          heroTag: 'gallery',
          backgroundColor: Color(0xFF3617CE),
          child: Icon(Icons.wallpaper),
          tooltip: 'pick Image',
          onPressed: () {
            // getImage(ImageSource.gallery);
          },
        ),
      ])
    ]));
  }
}
