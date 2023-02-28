import 'package:flutter/material.dart';
import 'package:ftts_flutter/screen/MainScreen.dart';
import 'package:ftts_flutter/screen/SupplementsMainScreen.dart';
import '../model/ConnectServer.dart';
import 'MenuScreen.dart';

var layoutSize;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int flag = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    layoutSize = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: Color(0xFFFFFDFF),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: Image.asset('assets/adot_menu.png'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenuScreen()));
            },
          ),
          actions: [
            IconButton(
              icon: Image.asset('assets/adot_share.png'),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('assets/adot_notification.png'),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                '식사 시간이 지났네!\n점심은 맛있게 먹었어?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
                child: Center(
                  child: Image(
                    image: AssetImage('assets/adot_home.gif'),
                    fit: BoxFit.fitHeight,
                  ),
                )),
            SubMenu(),
          ],
        ));
  }

  Widget MainText(String text) {
    return Center(
        child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
    ));
  }

  Widget SubMenu() {
    return Center(
        child: Column(
      children: [
        SubMenuItem(),
        SizedBox(
          height: 10,
        ),
        Mic_Key_Button()
      ],
    ));
  }

  Widget SubMenuItem() {
    //final List<String> text = ["식단 기록하기", "영양제 챙겨먹기", "운동하러 가기"];
    final List<String> text = ["식단 기록하기", "영양제 챙겨먹기"];
    final List<Icon> icons = [
      Icon(Icons.restaurant, color: Colors.yellow[800]),
      Icon(Icons.medication_outlined, color: Colors.blue),
      //Icon(Icons.fitness_center, color: Colors.grey[700]),
    ];
    final List<Widget> navigations = [
      MainScreen(),
      SupplementsMainScreen(),
      //HomeScreen(),
    ];

    return Container(
      height: layoutSize.size.height * 0.09,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: icons.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, top: 18, bottom: 7),
              child: OutlinedButton.icon(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(20, 0, 0, 0)),
                  foregroundColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(255, 11, 13, 35)),
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(255, 245, 246, 250)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => navigations[i])));
                },
                label: Text(
                  text[i],
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
                icon: icons[i],
              ),
            );
          }),
    );
  }

  List<bool> _selections = [false, false];
  List<Icon> mic_key_Icon = [
    Icon(
      Icons.mic_outlined,
      color: Colors.white,
    ),
    Icon(
      Icons.keyboard_outlined,
      color: Colors.white,
    )
  ];
  List<Alignment> container_align = [
    Alignment.centerLeft,
    Alignment.centerRight
  ];
  List<double> container_size = [40, 70];

  Widget Mic_Key_Button() {
    return Container(
      // color: Color.fromARGB(255, 250, 250, 250),
      height: layoutSize.size.height * 0.09,
      child: Row(
        children: [
          Expanded(child: Container()),
          Container(
            child: Stack(
              children: [
                mic_key_btn_bg(container_size[0], container_size[1]),
                mic_key_btn(container_align[flag], mic_key_Icon[flag]),
              ],
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 100.0,
                          spreadRadius: -20.0)
                    ]),
                child: IconButton(
                    iconSize: 50,
                    onPressed: () {},
                    icon: Image.asset("assets/adot_refresh.png"))),
          ),
        ],
      ),
    );
  }

  Widget mic_key_btn_bg(double mic_size, double keyboard_size) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(50), boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 100.0,
              spreadRadius: -20.0)
        ]),
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(50),
          borderColor: Colors.white,
          children: <Widget>[
            Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Icon(
                  Icons.mic_outlined,
                  size: 30,
                  color: Custom_Utils().Colors_SKT_Blue(),
                ),
              ),
              width: mic_size,
            ),
            Container(
              color: Colors.white,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(Icons.keyboard_outlined,
                    size: 30, color: Custom_Utils().Colors_SKT_Blue()),
              ),
              width: keyboard_size,
            ),
          ],
          onPressed: (int index) {
            setState(() {
              double buffer = container_size[0];
              container_size[0] = container_size[1];
              container_size[1] = buffer;
              print(index);
              if (index == 0) {
                flag = 0;
              } else {
                flag = 1;
              }
              // _selections[index] = !_selections[index];
            });
          },
          isSelected: _selections,
        ),
      ),
    );
  }

  Widget mic_key_btn(Alignment align, Icon icon) {
    return Center(
      child: Container(
        alignment: align,
        width: 120,
        height: 60,
        child: Container(
            alignment: Alignment.center,
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Custom_Utils().Colors_SKT_Blue(),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0)
                ]),
            child: IconButton(
              onPressed: () {},
              icon: icon,
              iconSize: 30,
            )),
      ),
    );
  }
}

class Custom_Utils {
  Color Colors_SKT_Blue() {
    return Color.fromARGB(255, 11, 13, 235);
  }

  Color Colors_SKT_Background() {
    return Color.fromARGB(255, 244, 245, 249);
  }
}
