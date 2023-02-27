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

class _ImageUploaderState extends State<ImageUploader> with AutomaticKeepAliveClientMixin {
  XFile? _image;
  final picker = ImagePicker();
  final connectServer = ConnectServer();

  List<dynamic>? _result = [
    ["불고기", 1.0]
  ];
  File? image;

  Map<String, dynamic>? _nut = nut_info;
  late Future<Image> timeDivImage;
  File? imageFile;
  Response? imgresponse, foodresponse;
  String? imgUrl;
  String? foodNamesUrl;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getTimeDivImage();
  }

  Future<void> _getTimeDivImage() async {
    imgUrl = 'http://jeongsuri.iptime.org:10019/dodo/intakes/images?time_div=${widget.timeDiv}&date=${widget.imgDate}';
    foodNamesUrl = 'http://jeongsuri.iptime.org:10019/classification?userid=dodo&time_div=${widget.timeDiv}&date=${widget.imgDate}';

    try {
      print(widget.timeDiv);
      imgresponse = await Dio().get(imgUrl!, options: Options(responseType: ResponseType.bytes));
      foodresponse = await Dio().get(foodNamesUrl!);

      if (foodresponse!.data['object_num'] > 0) {
        _result = [];
        for (Map m in foodresponse!.data['object']) {
          _result!.add(m['name']);
        }
        _result = _result!.toSet().toList();
        print("_result --------");
        print(_result);
      }
      print("response 이미지 불러오기 성공");
    } catch (e) {
      imgresponse == null;
      print("response 이미지 불러오기 실패");
      print(e);
    }
  }

  // 이미지 업로더 위젯
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    _getTimeDivImage();
    // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
    Future getImage(ImageSource imageSource) async {
      // Timeline.startSync('interesting function');
      _image = await picker.pickImage(
          source: imageSource, maxHeight: 448, maxWidth: 448, imageQuality: 100
          //이미지 resize 부분, height, width 설정, Quality 설정
          );
      print("_image");
      print(_image);

      setState(() {
        image=File(_image!.path);
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

        //List<String>? result;
        List<dynamic>? result;
        Map<String, dynamic>? nut;
        //classfication 결과 받아오기 -> 서버 연결 중 에러 발생시 'fail'를 반환한다.
        //음식 이름 받아오기
        var date = Provider.of<dateProvider>(context, listen: false).providerDate;
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        String onlydate = formatter.format(date);

        // classification 결과 반환 - 음식 메뉴 이름
        result = await connectServer.uploading(_image!, onlydate!,widget.timeDiv!);
        // 음식 이미지 하나에 대한 영양 정보 합산 결과 반환 -
        nut = await connectServer.foodNutinfo(result!, onlydate!,widget.timeDiv!);
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultScreen(_image!, result!, nut!,widget.timeDiv!)));
        Future<bool> _getFutureBool() {

          return Future.delayed(Duration(milliseconds: 100000)) .then((onValue) => true);

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
      (imgresponse == null&&image==null)
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
                    : Image.file(File(image!.path))),

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
                      '${_nut!['carbo'].toInt()}',
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
                      '${_nut!['protein'].toInt()}',
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
                      '${_nut!['fat'].toInt()}',
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
                                  builder: (context) =>
                                      ResultScreen(_image!, _result!, _nut!,widget.timeDiv)));
                        },
                        child: Text(
                          "상세 보기",
                          style: TextStyle(fontSize: 14),
                        ))),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 0.0, right: 3.0, bottom: 5.0),
                child: (_result != null)
                    ? Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        children: [
                          for (int i = 0; i < _result!.length; i++)
                            FoodMenu(_result![i][0])
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
