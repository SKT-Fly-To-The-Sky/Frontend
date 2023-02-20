import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftts_flutter/screen/SupplementsHandaddScreen.dart';
import 'package:image_picker/image_picker.dart';
import '../model/ConnectServer.dart';
import 'HomeScreen.dart';
import 'MenuScreen.dart';
import 'SupplementsGraphScreen.dart';
import '../widget/SupplementsGraph.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class SupplementsMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SupplementsMainScreen();
}

class _SupplementsMainScreen extends State<SupplementsMainScreen> {
  final picker = ImagePicker();
  final connectServer = ConnectServer();

  bool _isCheckd = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Future getImage(ImageSource imageSource) async {
      // Timeline.startSync('interesting function');
      var _image = await picker.pickImage(
          source: imageSource, maxHeight: 448, maxWidth: 448, imageQuality: 100
          //이미지 resize 부분, height, width 설정, Quality 설정
          );

      if (_image != null) {
        String? result;
        //classfication 결과 받아오기 -> 서버 연결 중 에러 발생시 'fail'를 반환한다.
        result = await connectServer.Supplementsuploading(_image!);

        setState(() {
          //ListView에 result 값 추가하기
        });
      } else {
        print("_image is null");
      }
    }

    Widget selectbutton() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3617CE),
                ),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt),
                label: Text('카메라로 추가하기')),
            ElevatedButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('갤러리로 추가히기')),
            OutlinedButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFF3617CE),
                  side: BorderSide(color: Color(0xFF3617CE), width: 2),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SupplementsHandaddScreen()));
                },
                icon: Icon(Icons.search_rounded),
                label: Text('검색으로 추가하기')),
            Row(
              children: <Widget>[
                Container(
                  width: 200,
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('닫기'),
                )
              ],
            )
          ],
        ),
      );
    }

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
          "A.영양제",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MenuScreen()));
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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: Text(
              "영양제 섭취율",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SupplementsGraph(),
          // Container(
          //   margin: EdgeInsets.only(left: 20, top: 15, bottom: 15),
          //   child: Row(
          //     children: [
          //       Text(
          //         "구미진님의 섭취 루틴",
          //         style: TextStyle(fontSize: 17.0),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            // width: screenWidth * 0.9,
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 5),
            child: Column(
              children: [
                Container(
                    child: Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.yellow,
                    ),
                    Container(
                      width: 5,
                    ),
                    Text(
                      "아침",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
                Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _isCheckd
                                      ? const Text(
                                          "닥터 써니디 연질캡슐",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        )
                                      : const Text(
                                          "닥터 써니디 연질캡슐",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                  Text(
                                    "1정",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              )),
                          Container(
                            child: RoundCheckBox(
                              onTap: (selected) {
                                setState(() {
                                  if (_isCheckd == false) {
                                    _isCheckd = true;
                                  } else {
                                    _isCheckd = true;
                                  }
                                });
                              },
                              checkedWidget:
                                  Icon(Icons.done, color: Colors.white),
                              checkedColor: Color(0xFF3617CE),
                              uncheckedWidget: Icon(
                                Icons.done,
                                color: Colors.grey,
                              ),
                              animationDuration: Duration(
                                seconds: 1,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3617CE),
                  ),
                  onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('영양제 추가하기'),
                          content: const Text('추가 방법을 고르시오'),
                          actions: <Widget>[
                            selectbutton(),
                          ],
                        ),
                      ),
                  child: Text("영양제 추가")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3617CE),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SupplementsGrapeScreen('fail')));
                  },
                  child: Text("상세 보기"))
            ],
          ),
        ],
      )),
    );
  }
}
