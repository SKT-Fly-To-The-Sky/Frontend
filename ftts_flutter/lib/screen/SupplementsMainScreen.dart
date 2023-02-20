import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ftts_flutter/screen/SupplementsHandaddScreen.dart';
import 'package:image_picker/image_picker.dart';
import '../model/ConnectServer.dart';
import 'HomeScreen.dart';
import 'MenuScreen.dart';
import 'SupplementsGraphScreen.dart';


class SupplementsMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SupplementsMainScreen();
}

class _SupplementsMainScreen extends State<SupplementsMainScreen> {
  final picker = ImagePicker();
  final connectServer = ConnectServer();
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {getImage(ImageSource.camera);},
                icon: Icon(Icons.camera_alt),
                label: Text('카메라로 추가하기')),
            ElevatedButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: () {getImage(ImageSource.gallery);},
                icon: Icon(Icons.image),
                label: Text('갤러리로 추가히기')),
            OutlinedButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFF3617CE),
                  side: BorderSide(color: Color(0xFF3617CE), width: 2),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplementsHandaddScreen()));
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
        elevation: 1.0,
        // 그림자 농도 0
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
        child: Row(
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
      ),
    );
  }
}
