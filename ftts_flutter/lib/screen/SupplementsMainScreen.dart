import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ftts_flutter/provider/supplementProvider.dart';
import 'package:ftts_flutter/screen/SupplementsHandaddScreen.dart';
import 'package:image_picker/image_picker.dart';
import '../model/ConnectServer.dart';
import 'HomeScreen.dart';
import 'MenuScreen.dart';
import 'SupplementsGraphScreen.dart';
import '../widget/SupplementsGraph.dart';
import '../widget/CustomCheckBox.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

class JsonListView extends StatefulWidget {
  @override
  _JsonListViewState createState() => _JsonListViewState();
}

class _JsonListViewState extends State<JsonListView> {
  List<dynamic> _jsonData = [];

  @override
  void initState() {
    super.initState();
    _fetchJsonData();
  }

  Future<void> _fetchJsonData() async {
    final response = await http.get(Uri.parse(
        'http://jeongsuri.iptime.org:10019/dodo/supplements/recommand'));

    if (response.statusCode == 200) {
      setState(() {
        // _jsonData = json.decode(utf8.decode(response.body.runes.toList()));
        _jsonData = json.decode(response.body);
      });
    }
    // print("fdsafsd");
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _launchUrl(url) async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Container(
      margin: EdgeInsets.only(right: 20),
      height: 350,
      // width: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _jsonData.length,
          itemBuilder: (context, i) {
            final data = _jsonData[i];

            print(Uri.parse(data['link']));
            return Container(
              width: 300,
              padding: const EdgeInsets.only(
                  left: 15, right: 10, top: 10, bottom: 15),
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.0,
                        color: Color.fromARGB(255, 216, 216, 216),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            // child: Image.memory(Uint8List.fromList(base64.decode(data['image']))),
                            child: Image.network(data['image'])),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                          child: Text(
                            utf8.decode(data['name'].codeUnits),
                            style: const TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 5, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image(
                                image: AssetImage('assets/11th_logo.png'),
                                width: 30,
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Color(0xFF3617CE),
                                  ),
                                  onPressed: () {
                                    // _launchUrl(utf8.decode(data['link'].codeUnits));
                                    _launchUrl(Uri.parse(data['link']));
                                  },
                                  child: Text("쇼핑하러 가기"))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class SupplementsMainScreen extends StatefulWidget {
  @override
  _SupplementsMainScreen createState() => _SupplementsMainScreen();
}

class _SupplementsMainScreen extends State<SupplementsMainScreen> {
  final picker = ImagePicker();
  final connectServer = ConnectServer();
  bool _btnChecked = false;

  late supplementProvider _supplementProduct;

  @override
  Widget build(BuildContext context) {
    _supplementProduct = Provider.of<supplementProvider>(context);

    double screenWidth = MediaQuery.of(context).size.width;

    Future getImage(ImageSource imageSource) async {
      // Timeline.startSync('interesting function');
      var _image = await picker.pickImage(
          source: imageSource, maxHeight: 448, maxWidth: 448, imageQuality: 100
          //이미지 resize 부분, height, width 설정, Quality 설정
          );

      if (_image != null) {
        String? result;
        Map<String, dynamic>? sup_nut;

        //classfication 결과 받아오기 -> 서버 연결 중 에러 발생시 'fail'를 반환한다.

        result = await connectServer.Supplementsuploading(_image!);
        print("result: " + result);
        _supplementProduct.addName(result.toString());
        print(Provider.of<supplementProvider>(context).supplementList);
        sup_nut = await connectServer.SupplementsNutinfo(result!);
        _supplementProduct.updatenutInfo(sup_nut);
        print(Provider.of<supplementProvider>(context).supplementnutInfo);

        //추가 후 창 닫기
        Navigator.pop(context, 'Cancel');
      } else {
        print("_image is null");
      }
    }

    Widget selectbutton() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3617CE),
                ),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt),
                label: Text('카메라로 추가하기')),
            TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF3617CE),
                ),
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
            child: Row(
              children: [
                Text(
                  "영양제 섭취율",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(
                    margin: EdgeInsets.only(left: 150),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Color(0xFF3617CE),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SupplementsGrapeScreen('fail')));
                        },
                        child: Text("상세 보기"))),
              ],
            ),
          ),
          CheckBoxListView(),
          Container(
            child: Center(
              child: IconButton(
                icon: Icon(Icons.add),
                iconSize: 30,
                color: Color(0xFF3617CE),
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
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20, top: 15, bottom: 5, right: 20),
              child: Row(
                children: [
                  Icon(Icons.medication_liquid_sharp),
                  Container(
                    width: 5,
                  ),
                  Text(
                    "영양제 추천",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              )),
          Center(child: JsonListView())
        ],
      )),
    );
  }

//   Widget RecommendItem() {
//     final List<String> text = [
//       "Doctor's Best 비타민 D3 5000IU",
//       "Solgar 비타민 D3 콜레칼시페롤 25mcg 1000IU",
//       "Osteo Bi-Flex 트리플 스트렝스 보충제 비타민 D"
//     ];
//     final List<Image> images = [
//       Image(
//         image: AssetImage('assets/pill_1.jpg'),
//         width: 150,
//       ),
//       Image(image: AssetImage('assets/pill_2.jpg'), width: 150),
//       Image(image: AssetImage('assets/pill_3.jpg'), width: 150),
//     ];
//     final List<Uri> urls = [
//       Uri.parse(
//           "https://www.11st.co.kr/products/pa/3612205141?&trTypeCd=MAS90&trCtgrNo=585021"),
//       Uri.parse(
//           "https://www.11st.co.kr/products/pa/3602719350?&trTypeCd=MAG3&trCtgrNo=585021"),
//       Uri.parse(
//           "https://www.11st.co.kr/products/pa/3612139599?&trTypeCd=MAG3&trCtgrNo=585021"),
//     ];
//
//     Future<void> _launchUrl(url) async {
//       if (!await launchUrl(url)) {
//         throw Exception('Could not launch $url');
//       }
//     }
//
//     return Container(
//       margin: EdgeInsets.only(right: 20),
//       height: 350,
//       // width: 300,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: images.length,
//           itemBuilder: (context, i) {
//             return Container(
//               width: 300,
//               padding: const EdgeInsets.only(
//                   left: 15, right: 10, top: 10, bottom: 15),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 300,
//                     height: 300,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 0.0,
//                         color: Color.fromARGB(255, 216, 216, 216),
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Center(
//                           child: images[i],
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(
//                               left: 10, top: 10, right: 10),
//                           child: Text(
//                             text[i],
//                             style: const TextStyle(
//                               fontSize: 18,
//                               // fontWeight: FontWeight.bold
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(
//                               left: 10, top: 5, right: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Image(
//                                 image: AssetImage('assets/11th_logo.png'),
//                                 width: 30,
//                               ),
//                               TextButton(
//                                   style: TextButton.styleFrom(
//                                     primary: Color(0xFF3617CE),
//                                   ),
//                                   onPressed: () {
//                                     _launchUrl(urls[i]);
//                                   },
//                                   child: Text("쇼핑하러 가기"))
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
}
