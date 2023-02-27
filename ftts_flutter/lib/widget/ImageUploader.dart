import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ftts_flutter/provider/dateProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../screen/ResultScreen.dart';
import '../model/ConnectServer.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import '../utils/nutInfo.dart';
import 'package:dio/dio.dart';

class ImageUploader extends StatefulWidget {
  String timeDiv;
  String imgDate;
  ImageUploader(
    //아침 점심 저녁 간식
    this.timeDiv,
    //날짜
    this.imgDate, {
    Key? key,
  }) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader>
    with AutomaticKeepAliveClientMixin {
  XFile? _image;
  final picker = ImagePicker();
  final connectServer = ConnectServer();
  List<String>? _foodNames;
  List<dynamic>? _result = [
    ["불고기", 1.0]
  ];
  File? image;

  Map<String, dynamic>? _nut = nut_info;
  List<int> timedivNut = [0, 0, 0, 0]; // kcal, carbo, protein, fat
  Map<String, dynamic>? nut = nut_info;
  late Future<Image> timeDivImage;
  File? imageFile;
  Response? imgresponse, foodresponse, timedivresp;
  String? imgUrl, timeDivUrl;
  String? foodNamesUrl;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getTimeDivImage();
  }

  bool serverConnect = false;
  Future<void> _getTimeDivImage() async {
    setState(() {
      serverConnect = true;
    });
    imgUrl =
        'http://jeongsuri.iptime.org:10019/dodo/intakes/images?time_div=${widget.timeDiv}&date=${widget.imgDate}';
    timeDivUrl =
        'http://jeongsuri.iptime.org:10019/dodo/intakes/nutrients/time-div?time_div=${widget.timeDiv}&date=${widget.imgDate}';
    try {
      imgresponse = await Dio()
          .get(imgUrl!, options: Options(responseType: ResponseType.bytes));
      timedivresp = await Dio().get(timeDivUrl!);
      print(timedivresp!.data['kcal'].toInt());
      timedivNut[0] = timedivresp!.data['kcal'].toInt();
      timedivNut[1] = timedivresp!.data['carbo'].toInt();
      timedivNut[2] = timedivresp!.data['protein'].toInt();
      timedivNut[3] = timedivresp!.data['fat'].toInt();
      // _nut['kcal'] = timedivNut[0];
      // _nut['carbo'] = timedivNut[1];
      // _nut['protein'] = timedivNut[2];
      // _nut['fat'] = timedivNut[3];
    } catch (e) {
      imgresponse = null;
      print(e);
    }
  }

  Future<void> _getfoodNames(String selectDay, String time) async {
    List<String> Result = [];

    try {
      var response = await Dio().get(
          'http://jeongsuri.iptime.org:10019/dodo/intakes/foods/names',
          queryParameters: {"time_div": time, "date": selectDay});
      if (response.statusCode == 200) {
        _foodNames = [];
        for (int i = 0; i < response.data['object_num']; i++) {
          print(response);
          Result.add(response.data['object'][i]);
        }
        _foodNames = Result;
        _foodNames = _foodNames!.toSet().toList();
        print(_foodNames);
        // return _result;
      }
    } catch (e) {
      print(e);
    }
  }

  // 이미지 업로더 위젯
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var timedivprovider = context.watch<timeDivProvider>().providerTimediv;
    // Provider.of<timeDivProvider>(context, listen: false).providerTimediv;
    var dateprovider = DateFormat('yyyy-MM-dd')
        .format(context.watch<dateProvider>().providerDate);
    if (serverConnect!) {
      _getTimeDivImage();
      _getfoodNames(dateprovider, timedivprovider);
    }

    Future getImage(ImageSource imageSource) async {
      _image = await picker.pickImage(
          source: imageSource,
          maxHeight: 448,
          maxWidth: 448,
          imageQuality: 100);
      print("_image");
      print(_image);

      setState(() {
        if (_image != null) image = File(_image!.path);
      });

      if (_image != null) {
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                color: const Color(0xFFF2F5FA),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      '딸기는 과일 중에 비타민C가 가장 많이 포함되어 있어요!',
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
              );
            });

        List<dynamic>? result, foodNames;

        String onlydate = '2023-02-28';

        // classification 결과 반환 - foodCls: [음식이름, volume]
        result =
            await connectServer.uploading(_image!, onlydate!, widget.timeDiv!);
        // 음식 이미지 하나에 대한 영양 정보 합산 결과 반환 -
        nut = await connectServer.foodNutinfo(
            result!, onlydate!, widget.timeDiv!);
        // print("nut");
        // print(nut);
        // _nut = nut;
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ResultScreen(_image!, result!, nut!, widget.timeDiv!)));
        Future<bool> _getFutureBool() {
          return Future.delayed(Duration(milliseconds: 100000))
              .then((onValue) => true);
        }

        _getFutureBool();
        //영양소 받아오기
        setState(() {
          _result = result;
          _nut = nut;
          //ResultScreen에 이미지, classfication 결과, 영양소 정보 전달
        });
      } else {
        print("_image is null");
      }
    }

    return //_image == null
        (imgresponse == null && image == null)
            ? Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                            heroTag: 'camera',
                            backgroundColor: Color(0xFF3617CE),
                            child: Icon(Icons.add_a_photo),
                            tooltip: 'pick Image',
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                          ),
                          FloatingActionButton(
                            heroTag: 'gallery',
                            backgroundColor: Color(0xFF3617CE),
                            child: Icon(Icons.wallpaper),
                            tooltip: 'pick Image',
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                          ),
                        ])
                  ]))
            : ShowImage();
  }

  Widget ShowImage() {
    final Image _morningImage =
        Image(image: AssetImage('assets/diet_morning.jpg'));
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0),
                width: 210,
                height: 140,
                child: image == null
                    ? Image.network(
                        imgUrl!,
                        fit: BoxFit.fill,
                      )
                    : _result![0][0] != '불고기'
                        ? Image.file(File(image!.path))
                        : Image(
                            image: AssetImage('assets/firegogi.jpg'),
                            fit: BoxFit.fill)),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
                        child: RoundedBackgroundText(
                          '탄',
                          style: const TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          backgroundColor: Color(0xffffb3ba),
                        )),
                    Text(
                      '${timedivNut[1].toString()} g',
                      style: TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
                        child: RoundedBackgroundText(
                          '단',
                          style: const TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          backgroundColor: Color(0xffffffba),
                        )),
                    Text(
                      '${timedivNut[2].toString()} g',
                      style: TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
                        child: RoundedBackgroundText(
                          '지',
                          style: const TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          backgroundColor: Color(0xffbae1ff),
                        )),
                    Text(
                      '${timedivNut[3].toString()} g',
                      style: TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.restaurant_menu_outlined),
                      Text(
                        " 음식 메뉴",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      left: 170,
                    ),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Color(0xFF3617CE),
                        ),
                        onPressed: () {
                          print("nut info");
                          print(_nut);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(_image!,
                                      _result!, _nut!, widget.timeDiv)));
                        },
                        child: Text(
                          "상세 보기",
                          style: TextStyle(fontSize: 14),
                        ))),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 0.0, right: 3.0, bottom: 5.0),
                child: (_foodNames != null) // && _result!.isEmpty)
                    ? Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        children: [
                          for (int i = 0; i < _result!.length; i++)
                            FoodMenu(_foodNames![i])
                        ],
                      )
                    : Container())
          ],
        ),
      ],
    ));
  }
}

Widget FoodMenu(String text) {
  return Container(
      margin: EdgeInsets.fromLTRB(15.0, 0.0, 5.0, 10.0),
      child: RoundedBackgroundText(
        text,
        style: const TextStyle(fontFamily: 'NotoSansKR', fontSize: 16),
        backgroundColor: Colors.grey[100],
      ));
}
