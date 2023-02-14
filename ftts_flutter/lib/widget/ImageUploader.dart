import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screen/ResultScreen.dart';
import '../model/ConnectServer.dart';
import 'dart:math' as math;

class ImageUploader extends StatefulWidget {
  const ImageUploader({Key? key}) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  XFile? _image;
  final picker = ImagePicker();
  // List<File> _imgList = [];
  File? image0, _image1, _image2, _image3;
  final connectServer = ConnectServer();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    Timeline.startSync('interesting function');
    _image = await picker.pickImage(
        source: imageSource, maxHeight: 448, maxWidth: 448, imageQuality: 100
      //이미지 resize 부분, height, width 설정, Quality 설정
    );


    if (_image != null) {
      String result;
      //classfication 결과 받아오기
      result = await connectServer.uploading(_image!);

      Timeline.finishSync();

      setState(() {
        //ResultScreen에 이미지와 classfication 결과 전달
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ResultScreen(_image,result)));
      });
    } else {
      print("_image is null");
    }
  }

  // 이미지 회전시키기
  double radians = 90 * math.pi / 180;

  // 이미지 업로더 위젯
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _image == null
                ? <Widget>[
                    // 카메라 촬영 버튼 동작
                    FloatingActionButton(
                      heroTag: 'camera',
                      backgroundColor: Color(0xFF3617CE),
                      child: Icon(Icons.add_a_photo),
                      tooltip: 'pick Image',
                      onPressed: () {
                        //카메라에서 이미지 가져오기
                        getImage(ImageSource.camera);
                      },
                    ),
                    // 갤러리에서 이미지를 가져오는 버튼
                    FloatingActionButton(
                      heroTag: 'gallery',
                      backgroundColor: Color(0xFF3617CE),
                      child: Icon(Icons.wallpaper),
                      tooltip: 'pick Image',
                      onPressed: () {
                        //갤러리에서 이미지 가져오기
                        getImage(ImageSource.gallery);
                      },
                    ),
                  ]
                : <Widget>[
                    SingleChildScrollView(
                      child: Column(children: [
                        Transform.rotate(
                          angle: radians,
                          child: Image.file(
                            File(_image!.path),
                            width: screenWidth * 0.8,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Text("음식 메뉴"),
                            ),
                            Container(
                              child: Text("칼로리"),
                            ),
                            Container(
                              child: Text("영양 성분"),
                            )
                          ],
                        )
                      ]),
                    )
                  ])
      ],
    ));
  }
}
