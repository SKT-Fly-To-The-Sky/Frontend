import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screen/ResultScreen.dart';
import '../model/ConnectServer.dart';
import 'dart:developer';
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
                  builder: (context) => ResultScreen(_image, result, nut))
          );
        });
      } else {
        print("_image is null");
      }
    }

    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _image == null
                ? <Widget>[
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
                  ]
                : <Widget>[
                    SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.rotate(
                              angle: radians,
                              child: Image.file(
                                File(_image!.path),
                                width: screenWidth * 0.8,
                                height: screenWidth * 0.8 * 0.75,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Text("음식 메뉴"),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: Text("총 칼로리"),
                                          ),
                                          Container(
                                            child: Text("566kcal"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: Text("탄수화물"),
                                          ),
                                          Container(
                                            child: Text("17mg"),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: Text("단백질"),
                                          ),
                                          Container(
                                            child: Text("12mg"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ]),
                    )
                  ])
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
