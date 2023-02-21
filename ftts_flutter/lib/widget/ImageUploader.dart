import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screen/ResultScreen.dart';
import '../model/ConnectServer.dart';
import 'dart:developer';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'dart:math' as math;

class ImageUploader extends StatefulWidget {
  const ImageUploader({Key? key}) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

XFile? _image;

class _ImageUploaderState extends State<ImageUploader> {
  // XFile? _image;
  final picker = ImagePicker();
  final connectServer = ConnectServer();

  // 이미지 회전시키기
  double radians = 90 * math.pi / 180;

  // 이미지 업로더 위젯
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
    Future getImage(ImageSource imageSource) async {
      // Timeline.startSync('interesting function');
      _image = await picker.pickImage(
          source: imageSource, maxHeight: 448, maxWidth: 448, imageQuality: 50
          //이미지 resize 부분, height, width 설정, Quality 설정
          );

      if (_image != null) {
        List<String>? result;
        Map<String, dynamic>? nut;
        //classfication 결과 받아오기 -> 서버 연결 중 에러 발생시 'fail'를 반환한다.
        //음식 이름 받아오기
        result = await connectServer.uploading(_image!);


        nut= await connectServer.GetNutInfo(result!);


        //영양소 받아오기
        setState(() {
          //ResultScreen에 이미지, classfication 결과, 영양소 정보 전달

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultScreen(_image!, result!, nut!))
          );
        });
      } else {
        print("_image is null");
      }
    }

    return _image == null
        ? Container(
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
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                  ),
                  FloatingActionButton(
                    heroTag: 'gallery',
                    backgroundColor: Color(0xFF3617CE),
                    child: Icon(Icons.wallpaper),
                    tooltip: 'pick Image',
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                  ),
                ])
          ]))
        : ShowImage();
  }

  Widget ShowImage() {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 200,
              child: Transform.rotate(
                angle: radians,
                child: Image.file(
                  File(_image!.path),
                ),
              ),
            ),
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
                      '365 kcal',
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
                      '365 kcal',
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
                      '365 kcal',
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
            Container(
              margin: EdgeInsets.only(left: 7.0, bottom: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.restaurant_menu_outlined),
                  Text(
                    " 음식 메뉴",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.0, bottom: 7.0),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                      child: RoundedBackgroundText(
                        '닭강정훈',
                        style: const TextStyle(
                            fontFamily: 'NotoSansKR', fontSize: 16),
                        backgroundColor: Colors.grey[100],
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                      child: RoundedBackgroundText(
                        '참이슬아',
                        style: const TextStyle(
                            fontFamily: 'NotoSansKR', fontSize: 16),
                        backgroundColor: Colors.grey[100],
                      )),
                ],
              ),
            )
          ],
        ),
      ],
    ));
  }
}

class StaticUploader extends StatelessWidget {
  const StaticUploader({super.key});

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
