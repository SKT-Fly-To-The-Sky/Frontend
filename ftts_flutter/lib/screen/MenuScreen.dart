import 'package:flutter/material.dart';
import '../utils/TMapPlugin.dart';
import 'MainScreen.dart';
import 'SupplementsMainScreen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "메뉴",
            style: TextStyle(
                fontFamily: 'NotoSansKR', color: Colors.black, fontSize: 18),
          ),
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Center(
                child: Image(image: AssetImage('assets/adot_profile.jpg')),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                '건강하닷',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const MainScreen())));
                      },
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      icon: Icon(Icons.restaurant),
                      label: Text("식단")),
                  Container(
                    width: 100,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => SupplementsMainScreen())));
                      },
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      icon: Icon(Icons.medication),
                      label: Text("영양제")),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        TMapPlugin.exeTMap("김치찌개");
                      },
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black),
                      icon: Icon(Icons.map),
                      label: Text("지도")),
                ],
              ),
            ),
          ],
        ));
  }
}
