import "package:flutter/material.dart";
import "package:ftts_flutter/model/ConnectServer.dart";
import "package:ftts_flutter/screen/SupplementsMainScreen.dart";
import "package:provider/provider.dart";
import "../provider/supplementProvider.dart";

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
              fontFamily: "NotoSansKR", color: Colors.black, fontSize: 18),
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
                      children: const <Widget>[
                        //border 넣기, 라운드넣기, text 넣?기?
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 6,
                            child: Text(
                              "검색",
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
    "힐링팩토리 블루마린 오메가3",
    "헬스프랜드 캐나다 칼슘 마그네슘 비타민D 아연",
    "헬스프랜드 캐나다 슈퍼징코플러스",
    "헬스프랜드 미국 프리미엄 rTG 오메가3 ",
    "프로메가 트리플 오메가3",
    "판토모나-판토텐산 비오틴 복합 관리 64종",
    "파마젠 RTG오메가3 1300mg",
    "트루엔 알티지오메가3",
    "캐나다 코랄칼슘/아연/마그네슘/비타민D",
    "종근당 칼슘 마그네슘 비타민D 아연",
    "인테로 종합 멀티비타민",
    "인테로 오메가3 영양제 1200mg",
    "인테로 비타민E",
    "인테로 비타민D 2000IU ",
    "인테로 비타민B",
    "인테로 메타 멀티비타민",
    "인테로 멀티비타민 포키즈 츄어블",
    "인테로 루테인 메타 비타민A",
    "익스트림 초임계 알티지 오메가3+",
    "엔젯오리진 비타프레쉬 비타민 C&D 3000",
    "얼라이브 원스데일리 포 맨",
    "쏜리서치 칼슘 마그네슘 말레이트",
    "쏜리서치 기초영양소종합비타민 투퍼데이",
    "쏜리서치 B 콤플렉스",
    "순수식품 해조 칼슘 마그네슘 비타민D 아연",
    "셀티바 이팩스 알티지 오메가3",
    "메디타민 어골칼슘 칼마디+",
    "마이프로틴 칼슘 마그네슘",
    "마이프로틴 아연",
    "락티브 초임계 rTG 알티지 오메가3 600mg",
    "대웅제약 세노메가 맘스 식물성오메가3",
    "닥터린 초임계 추출 식물성 알티지 오메가3",
    "닥터 써니디 연질캡슐 2000IU",
    "고려은단 퓨어 알티지 DHA 오메가3",
    "Zahler, Iron Complex, Advanced Iron Complex, Gentle & Non-Constipating Iron Formula",
    "YumEarth, Organic Vitamin C Drops, Citrus Grove, 3.3 oz (93.5 g)",
    "Vibrant Health, Green Vibrance +25 Billion Probiotics, Version 19.1, 32.97 oz (934.58 g)",
    "Thorne, Stress B-Complex",
    "Thorne, Methyl-Guard Plus",
    "Thorne, Magnesium CitraMate",
    "Thorne, B-Complex #12",
    "Sundown Naturals, Calcium, Magnesium & Zinc",
    "Sports Research, Omega-3 Fish Oil, Triple Strength",
    "Solgar, Zinc, 50 mg",
    "Solgar, Zinc Picolinate",
    "Solgar, Sublingual Methylcobalamin (Vitamin B12), 1,000 mcg",
    "Solgar, Omega 3, EPA & DHA, Triple Strength, 950 mg",
    "Solgar, Naturally Sourced Vitamin E, 268 mg (400 IU)",
    "Solgar, Magnesium with Vitamin B6",
    "Solaray, Copper, 2 mg",
    "SmartyPants, Toddler Formula, Multi and Omega 3s, Grape, Orange, and Blueberry",
    "rTG 알티지오메가3 1000 5중기능성 엔쵸비오일",
    "NOW Foods, Zinc, 50 mg",
    "NOW Foods, Vitamin A, 25,000 IU",
    "NOW Foods, Ultra Omega 3-D, 600 EPA / 300 DHA",
    "NOW Foods, Omega-3, 180 EPA / 120 DHA",
    "NOW Foods, Magnesium Caps, 400 mg",
    "NOW Foods, Iron, 18 mg",
    "NOW Foods, High Potency Vitamin D-3, 10,000 IU",
    "NOW Foods, Folic Acid, 800 mcg",
    "NOW Foods, EVE, Superior Women\"s Multi",
    "NOW Foods, Calcium & Magnesium with Vitamin D-3 and Zinc",
    "NOW Foods, B-12, 1,000 mcg",
    "NOW Foods, ADAM, Superior Men\"s Multi",
    "NaturesPlus, Water-Dispersible Vitamin A, 10,000 IU (3,000 mcg)",
    "NaturesPlus, Hema-Plex",
    "Nature\'s Way, Zinc Lozenges, Wild Berry Flavored",
    "Nature\'s Way, Alive! Women\'s Premium Gummies, Multivitamin, Grape, Cherry & Blueberry Acai",
    "Nature\'s Way, Alive! Once Daily, Women\'s Ultra Potency Complete Multivitamin",
    "Nature\'s Way, Alive! Men\'s 50+ Ultra Potency Complete Multivitamin",
    "Nature\'s Way, Alive! Hair, Skin & Nails with Collagen & Biotin, Strawberry",
    "Nature\'s Bounty, Zinc, 50 mg",
    "Nature\'s Bounty, Super B-Complex with Folic Acid Plus Vitamin C",
    "Natural Factors, Zinc Citrate, 50 mg",
    "Natural Factors, Zinc Chelate, 25 mg",
    "Natural Factors, WomenSense, RxOmega-3",
    "Natural Factors, Vitamin C, Time Release, 1,000 mg",
    "Natural Factors, Vitamin C, Plus Bioflavonoids & Rosehips, 1,000 mg",
    "Natural Factors, Vitamin A, 3000 mcg (10,000 IU)",
    "Natural Factors, Magnesium Citrate, 150 mg",
    "Natrol, Biotin, Maximum Strength, 10,000 mcg",
    "Mason Natural, Folic Acid, 800 mcg",
    "Macrolife Naturals, Miracle Reds, Superfood, Goji, Pomegranate,  Acai,  Mangosteen, 0.3 oz (9.5 g)",
    "Life Extension, Glutathione, Cysteine & C",
    "Life Extension, AMPK Metabolic Activator",
    "Lake Avenue Nutrition, Vitamin D3, 125 mcg (5,000 IU)",
    "KAL, Magnesium Taurate +, 200 mg",
    "Jarrow Formulas, B-Right",
    "GNM 칼슘 마그네슘 아연 비타민D",
    "GNM 어린이 칼슘 마그네슘 아연 비타민D",
    "GNM 마그네슘05",
    "GNM 루테인 오메가3 비타민A 비타민E",
    "GNM rTG 알티지오메가3 비타민E",
    "Garden of Life, MyKind Organics, B-Complex",
    "Doctor\'s Best, Vitamin D3, 125 mcg (5,000 IU)",
    "Doctor\'s Best, High Absorption Magnesium, 100 mg",
    "Doctor\'s Best, Glucosamine Chondroitin MSM with OptiMSM",
    "Doctor\'s Best, Fully Active B Complex with Quatrefolic",
    "ChildLife, Essentials, Multi Vitamin & Mineral, Natural Orange/Mango, 8 fl oz (237 ml)",
    "ChildLife, Essentials, Liquid Calcium with Magnesium, Natural Orange, 16 fl oz (473 ml)",
    "California Gold Nutrition, Vitamin D3, 50 mcg (2,000 IU)",
    "California Gold Nutrition, Premium Krill Oil with Superba2, 1,000 mg",
    "California Gold Nutrition, Omega-3 Premium Fish Oil",
    "California Gold Nutrition, Men Multi Vitamin Gummies, No Gelatin, No Gluten, Mixed Berry and Fruit Flavor",
    "California Gold Nutrition, Immune 4, Immune System Support,",
    "California Gold Nutrition, Gold C, USP Grade Vitamin C, 1,000 mg",
    "California Gold Nutrition, Gold C Powder, Vitamin C, 1,000 mg, 8.81 oz (250 g)",
    "California Gold Nutrition, Baby\"s DHA, Omega-3s with Vitamin D3, 1,050 mg, 2 fl oz (59 ml)",
    "Azo, Urinary Tract Health, Cranberry",
    "21st Century, Zoo Friends with Extra C, Orange",
    "21st Century, Zinc Citrate, 50 mg",
    "21st Century, Vitamin E, 180 mg (400 IU)",
    "21st Century, Vitamin C, 500 mg",
    "21st Century, Vitamin A, 3,000 mcg (10,000 IU)",
    "21st Century, Sentry Senior, Multivitamin & Multimineral Supplement, Men 50+",
    "21st Century, One Daily, Women\"s",
    "21st Century, Niacin, 100 mg",
    "21st Century, Magnesium, 250 mg",
    "21st Century, Healthy Eyes, Lutein and Antioxidants",
    "21st Century, Fish Oil, 1000 mg",
    "21st Century, Calcium Magnesium Zinc + D3",
    "21st Century, Biotin, 5,000 mcg",
    "21st Century, B-Complex Plus Vitamin C",
    "21st Century, B-50 Complex, Prolonged Release",
    "21st Century, Advanced Formula Hair, Skin & Nails",
    "[튼튼]종합비타민미네랄- 멀티비타민미네랄 총 15종 함유",
    "[종근당건강] 프로메가 알티지 오메가3 비타민D",
    "[일양약품] 일양약품 액티브 마그네슘 플러스 비타민D ",
    "[일양약품] 리얼메디 종합비타민 21종",
    "[센트룸] 멀티비타민 우먼",
    "[센트룸] 멀티비타민 실버 우먼",
    "[센트룸] 멀티비타민 실버 맨",
    "[센트룸] 멀티비타민 맨",
    "[듀오랩] 데일리 멀티비타민",
    "[뉴트리디데이] 순도높은 rTG 오메가3 골드",
    "[JW중외제약] 루테인지아잔틴 오메가3",
    " 뉴트맘스올인원 임산부 종합 비타민 영양제"
  ];
  List<String> imageLink=[];

  final connectServer = ConnectServer();

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = "";
              }
            },
            icon: const Icon(Icons.clear))
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
                            Text("$query를 추가하겠습니까?"),
                          ],
                        ),
                        actions: <Widget>[
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    var provide =
                                        Provider.of<supplementProvider>(context,
                                            listen: false);
                                    if (provide.supplementList
                                            .indexOf(query!) ==
                                        -1) {
                                      print("중복X");
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              color: const Color(0xFFF2F5FA),
                                              child: Column(
                                                children: const <Widget>[
                                                  SizedBox(
                                                    height: 60,
                                                  ),
                                                  Text(
                                                    "철분은 식사 전에 섭취하는게 좋아요!",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "NotoSansKR",
                                                        color: Colors.black,
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Expanded(
                                                    child: Image(
                                                      image: AssetImage(
                                                          "assets/adot_loading.gif"),
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                  CircularProgressIndicator()
                                                ],
                                              ),
                                            );
                                          });

                                      provide.addName(query!.toString());
                                      print(provide.supplementList);

                                      Map<String, dynamic>? result;

                                      try {
                                        result = await connectServer.SupplementsNutinfo(query!.toString());

                                        //영양정보 추가, 아침점심저녁 list에 아이템 추가
                                        provide.updatenutInfo(query.toString(), result);

                                        print("supplementnutInfo------------------");
                                        print(provide.supplementnutInfo);

                                      } catch (e) {
                                        //예외처리로 default로 점심에 추가
                                        provide.addNameText(
                                            query.toString(), "점심", "1정");
                                        print(provide.supplemetsLunchInfo);
                                        print("영양성분 찾기 실패");
                                      }
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SupplementsMainScreen()));
                                    }
                                    //Navigator.pop(context);
                                    else {
                                      print("중복");
                                      //약이름이 이미 있다면 팝업창으로 중복된 약이 이미 있음을 알려주기
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(""),
                                              content:
                                                  Text(query + "영양제가 중복되었습니다!"),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("닫기"))
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: Text("네")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("아니오"))
                            ],
                          )
                        ],
                      ));
            },
          );
        });
  }
}
