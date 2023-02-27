import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screen/ResultScreen.dart';
import '../model/ConnectServer.dart';
import 'dart:developer';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'dart:math' as math;
import 'ImageUploader.dart';

// data = {'2023-02-25':
//   {'morning':[[음식메뉴], url, 칼로리, 탄, 단, 지]},
//   {'lunch':[[음식메뉴], url, 칼로리, 탄, 단, 지]},
//   {'dinner':[[음식메뉴], url, 칼로리, 탄, 단, 지]},
// }

Map<String, dynamic>? data;

class StaticUploader extends StatelessWidget {
  String staticDate, staticTimeDiv;
  StaticUploader(this.staticDate, this.staticTimeDiv, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    image: AssetImage(data![staticDate][staticTimeDiv][1]),
                    fit: BoxFit.fill)),
            Column(
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
                      '${data![staticDate][staticTimeDiv][3]}',
                      style: TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
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
                      '${data![staticDate][staticTimeDiv][4]}',
                      style: TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
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
                      '${data![staticDate][staticTimeDiv][5]}',
                      style: TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        Column(
          children: [
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
                Container(
                    margin: EdgeInsets.only(
                      left: 170,
                    ),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Color(0xFF3617CE),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             ResultScreen(_image!, _result!, _nut!)));
                        },
                        child: Text(
                          "상세 보기",
                          style: TextStyle(fontSize: 14),
                        ))),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 0.0, right: 3.0, bottom: 5.0),
                child: (data![staticDate][staticTimeDiv][0] != null)
                    ? Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        children: [
                          for (int i = 0;
                              i < data![staticDate][staticTimeDiv][0]!.length;
                              i++)
                            FoodMenu(data![staticDate][staticTimeDiv][0][i])
                        ],
                      )
                    : Container())
          ],
        ),
      ],
    ));
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
