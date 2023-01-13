import 'package:flutter/cupertino.dart';
import 'MenuScreen.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'ResultScreen.dart';
import '../model/ConnectServer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //File? _image;
  final picker = ImagePicker();
  final connectServer=ConnectServer();


  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    // setState(() {
    //   _image = File(image!.path); // 가져온 이미지를 _image에 저장
    // });
    if (image != null) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ResultScreen(_image)),
      //   //이미지 주소가 있다면 ResultPage로 _image 이동=>출력
      // );
       connectServer.uploading(image!);
       //Connect Server로 이동하여 연결

        setState(() {});
    }
    else{print("_image is null");}
    }
    //int flag = 0;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1.0, // 그림자 농도 0
          title: const Text(
            "A.식단",
            style: TextStyle(
                fontFamily: 'NotoSansKR', color: Colors.black, fontSize: 18),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenuScreen()));
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 카메라 촬영 버튼 동작
                FloatingActionButton(
                  child: Icon(Icons.add_a_photo),
                  tooltip: 'pick Image',
                  onPressed: () {
                    //카메라에서 이미지 가져오기
                    getImage(ImageSource.camera);
                  },
                ),

                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  child: Icon(Icons.wallpaper),
                  tooltip: 'pick Image',
                  onPressed: () {
                    //갤러리에서 이미지 가져오기
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
            )
          ],
        ));
  }
}
