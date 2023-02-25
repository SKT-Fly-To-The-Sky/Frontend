import 'package:flutter/material.dart';
import 'package:ftts_flutter/model/ConnectServer.dart';
import 'package:ftts_flutter/screen/SupplementsMainScreen.dart';
import 'package:provider/provider.dart';
import '../provider/supplementProvider.dart';

class SupplementsHandaddScreen extends StatelessWidget {

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

                                    var provide = Provider.of<supplementProvider>(context, listen: false);
                                    if (provide.supplementList.indexOf(query!) == -1) {
                                      print("중복X");
                                      showDialog(context: context, builder: (context){
                                        return Container(
                                          color: const Color(0xFFF2F5FA),
                                          child:Column(children: <Widget>[
                                            SizedBox(height: 60,),
                                            Text(
                                              '철분은 식사 전에 섭취하는게 좋아요!',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'NotoSansKR',
                                                  color: Colors.black,
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                              child: Image(
                                                image: AssetImage('assets/adot_loading.gif'),
                                                fit: BoxFit.fitWidth,
                                              ),),
                                            CircularProgressIndicator()
                                          ],),
                                        );
                                      }
                                      );

                                      provide.addName(query!.toString());
                                      print(provide.supplementList);

                                      Map<String, dynamic>? result;

                                      try {

                                        result = await connectServer.SupplementsNutinfo(query!.toString());

                                        //영양정보 추가, 아침점심저녁 list에 아이템 추가
                                        provide.updatenutInfo(query.toString(),result);
                                        print("supplementnutInfo------------------");
                                        print(provide.supplementnutInfo);

                                      }
                                      catch (e) {
                                        //예외처리로 default로 점심에 추가
                                        provide.addNameText(query.toString(), "점심", "1정");
                                        print(provide.supplemetsLunchInfo);
                                        print('영양성분 찾기 실패');
                                      }
                                      Navigator.of(context).popUntil((route) => route.isFirst);
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SupplementsMainScreen()));
                                    }
                                    //Navigator.pop(context);
                                   else{
                                     print("중복");
                                      //약이름이 이미 있다면 팝업창으로 중복된 약이 이미 있음을 알려주기
                                     showDialog(context: context, builder: (context){
                                       return AlertDialog(
                                         title: Text(''),
                                         content: Text(query + '영양제가 중복되었습니다!'),
                                         actions: <Widget>[
                                           TextButton(
                                               onPressed: () {
                                                 Navigator.pop(context);
                                                 Navigator.pop(context);
                                               },
                                               child: Text('닫기'))
                                         ],
                                       );
                                     });
                                    }
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
