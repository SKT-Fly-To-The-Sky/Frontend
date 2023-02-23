import 'package:flutter/material.dart';
import 'package:ftts_flutter/model/ConnectServer.dart';
import 'package:ftts_flutter/screen/SupplementsMainScreen.dart';
import 'package:provider/provider.dart';
import '../model/ConnectServer.dart';
import '../provider/supplementProvider.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class SupplementsHandaddScreen extends StatelessWidget {
  var inputData = '';
  final connectServer = ConnectServer();

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: SerchDelegate());
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.all(10),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF3617CE),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: <Widget>[
                        //border 넣기, 라운드넣기, text 넣?기?
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 6,
                            child: Text(
                              '검색',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF3617CE)),
                            )),
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.search,
                              color: Color(0xFF3617CE),
                            )),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SerchDelegate extends SearchDelegate {
  List<String> searchResults = [
    '약이름1',
    '약이름2',
    '약이름3',
    '비타민D',
    '비타민A',
    '루테인',
    'Macrolife Naturals, Miracle Reds, Superfood, Goji, Pomegranate,  Acai,  Mangosteen, 0.3 oz (9.5 g)',
  ];
  final connectServer = ConnectServer();
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text("영양제 추가하기"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(query + '를 추가하겠습니까?'),
                          ],
                        ),
                        actions: <Widget>[
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    print("textbutton");
                                    var provide =
                                        Provider.of<supplementProvider>(context,
                                            listen: false);
                                    print(provide.supplementList);
                                    if (provide.supplementList
                                            .indexOf(query!) ==
                                        -1) {
                                      provide.addName(query!.toString());

                                      print(provide.supplementList);
                                      Map<String, dynamic>? result;
                                      try {
                                        result = await connectServer
                                            .SupplementsNutinfo(
                                                query!.toString());
                                        provide.updatenutInfo(result);
                                        print(
                                            "supplementnutInfo------------------");
                                        print(provide.supplementnutInfo);
                                      } catch (e) {
                                        print('영양성분 찾기 실패');
                                      }
                                    }
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SupplementsMainScreen()),
                                        (route) => true);
                                  },
                                  child: Text('네')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('아니오'))
                            ],
                          )
                        ],
                      ));
            },
          );
        });
  }
}
