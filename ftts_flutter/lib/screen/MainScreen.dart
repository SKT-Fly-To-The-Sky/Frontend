import 'package:table_calendar/table_calendar.dart';
import 'MenuScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ResultScreen.dart';
import '../model/ConnectServer.dart';
import '../utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final picker = ImagePicker();
  final connectServer = ConnectServer();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    if (image != null) {
      String imagepath = "";
      imagepath = await connectServer.uploading(image);
      if (imagepath != "fail") {
        setState(() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResultScreen(imagepath)));
        });
      }
      //Connect Server로 이동하여 연결
      else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ResultScreen("fail")));
      }
    } else {
      print("_image is null");
    }
  }

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6F9),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1.0, // 그림자 농도 0
        title: const Text(
          "A.식단",
          style: TextStyle(
              fontFamily: 'NotoSansKR', color: Colors.black, fontSize: 18),
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
      body: Column(
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // 카메라 촬영 버튼 동작
                  FloatingActionButton(
                    child: Icon(Icons.add_a_photo),
                    tooltip: 'pick Image',
                    onPressed: () {
                      //카메라에서 이미지 가져오기
                      getImage(ImageSource.camera);
                    },
                  ),
                  // 갤러리에서 이미지를 가져오는 버튼
                  FloatingActionButton(
                    child: Icon(Icons.wallpaper),
                    tooltip: 'pick Image',
                    onPressed: () {
                      //갤러리에서 이미지 가져오기
                      getImage(ImageSource.gallery);
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
