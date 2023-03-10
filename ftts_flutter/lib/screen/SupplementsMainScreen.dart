import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ftts_flutter/provider/supplementProvider.dart';
import 'package:ftts_flutter/screen/SupplementsHandaddScreen.dart';
import 'package:image_picker/image_picker.dart';
import '../model/ConnectServer.dart';
import 'MenuScreen.dart';
import 'SupplementsGraphScreen.dart';
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
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Container(
                                        width: 300,
                                        height: 300,
                                        child: Image.network(
                                          data['image'],
                                          fit: BoxFit.fill,
                                        )))),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 10, top: 10, right: 10),
                              child: Text(
                                utf8.decode(data['name'].codeUnits),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 10, top: 5, right: 10),
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
                                        _launchUrl(Uri.parse(data['link']));
                                      },
                                      child: Text("???????????? ??????"))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
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
          //????????? resize ??????, height, width ??????, Quality ??????
          );

      if (_image != null) {
        String? result;
        Map<String, dynamic>? sup_nut;

        showDialog(
            context: context,
            builder: (context) {
              return Scaffold(
                body: Container(
                  color: const Color(0xFFF2F5FA),
                  child: Column(
                    children: const <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        '????????? ?????? ?????? ??????????????? ?????????!',
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
                        ),
                      ),
                      CircularProgressIndicator()
                    ],
                  ),
                ),
              );
            });
        //classfication ?????? ???????????? -> ?????? ?????? ??? ?????? ????????? ????????? ???????????? ????????????.
        result = await connectServer.Supplementsuploading(_image!);

        //supplementList??? result?????? ????????? ????????????.

        if (Provider.of<supplementProvider>(context, listen: false)
                    .supplementList
                    .indexOf(result) ==
                -1 &&
            result != null) {
          //supplementList??? result?????? ????????? list??? result??? ????????????.

          _supplementProduct.addName(result.toString());
          //???????????? ?????? ??????????????? ????????????.

          try {
            sup_nut = await connectServer.SupplementsNutinfo(result!);
            //??????????????? supplementnutInfo??? ?????????.
            _supplementProduct.updatenutInfo(result, sup_nut!);
          } catch (e) {
            //????????????????????? ?????? ???????????? ??????.
            _supplementProduct.addNameText(result, '??????', '1???');
            print(_supplementProduct.supplemetsLunchInfo);
            print('???????????? ?????? ??????');
          }
          //??? ??????
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          //???????????? ?????? ????????? ??????????????? ????????? ?????? ?????? ????????? ????????????
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(''),
                  content: Text(result! + '???????????? ?????????????????????!'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text('??????'))
                  ],
                );
              });
        }
      } else {
        print("_image is null");
      }
    }

    Widget selectbutton() {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 190,
              height: 35,
              child: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF3617CE),
                  ),
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('???????????? ????????????')),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
                width: 190,
                height: 35,
                child: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF3617CE),
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    icon: Icon(Icons.image),
                    label: Text('???????????? ????????????'))),
            SizedBox(
              height: 8,
            ),
            Container(
                width: 190,
                height: 35,
                child: OutlinedButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF3617CE),
                      side: BorderSide(color: Color(0xFF3617CE), width: 2),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SupplementsHandaddScreen()));
                    },
                    icon: Icon(Icons.search_rounded),
                    label: Text('???????????? ????????????'))),
            Row(
              children: <Widget>[
                Container(
                  width: 200,
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('??????'),
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
          "A.?????????",
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
              Navigator.pop(context);
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
                  "????????? ?????????",
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
                                      SupplementsGrapeScreen()));
                        },
                        child: Text("?????? ??????"))),
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
                    title: const Text('????????? ????????????'),
                    content: const Text('?????? ????????? ????????????'),
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
                    "????????? ??????",
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
}
