import 'dart:io';
import 'package:flutter/material.dart';

import 'camera_ex.dart';

class ResultPage extends StatelessWidget{
  final File? _image;
  const ResultPage(this._image, {super.key});

  @override
  Widget build(BuildContext context) {
    //이미지를 보여주는 위젯으로 image를 받으면 A.식단 결과 페이지가 나타난다
    Widget showImage() {
      return Container(
          color: const Color(0xffd0cece),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Center(
              child: _image == null
                  ? const Text('No image selected.')
                  : Image.file(File(_image!.path))));

    }
    return Scaffold(
        backgroundColor: const Color(0xffD6D6D6),
        appBar: AppBar(
          //AppBar 설정(UI 적용 완료)
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white, //appbar 투명색
          centerTitle: true,
          elevation: 0.0,// 그림자 농도 0
          title: const Text(
            "A.식단",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              //닫기 버튼
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>CameraExample())
                );
              },
            )
          ],
        ),

        body: Column(
          //image 출력 view
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25.0),
              showImage(),
              const SizedBox(
                height: 50.0,
              ),
            ]
        )
    );
  }

}