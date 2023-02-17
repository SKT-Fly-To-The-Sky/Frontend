import 'package:flutter/material.dart';

class SupplementsHandaddScreen extends StatelessWidget {

  const SupplementsHandaddScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        //AppBar 설정(UI 적용 완료)
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        //appbar 투명색
        centerTitle: true,
        elevation: 1.0,
        // 그림자 농도 0
        title: const Text(
          "A.영양제",
          style: TextStyle(
              fontFamily: 'NotoSansKR', color: Colors.black, fontSize: 18),
        ),
        actions: [
          IconButton(
            //닫기 버튼 (뒤로가기와 기능적으로 같다)
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body:SingleChildScrollView(),
    );
  }
}