import 'package:flutter/material.dart';
import 'MainScreen.dart';

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
                child: Image(image: AssetImage('assets/adot_menu.jpg')),
              ),
              // height: 120,
              // decoration: BoxDecoration(
              //   color: Color.fromARGB(255, 236, 218, 255),
              //   borderRadius: BorderRadius.circular(10),
              // ),
              // child: Center(
              //   child: Text("구미진님의 에이닷"),
              // ),
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
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const MainScreen())));
                      },
                      icon: const Icon(Icons.restaurant)),
                  Text("식단")
                ],
              ),
            ),
          ],
        ));
  }
}
