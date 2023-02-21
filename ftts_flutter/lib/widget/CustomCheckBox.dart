import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ftts_flutter/screen/SupplementsHandaddScreen.dart';
import 'package:image_picker/image_picker.dart';
import '../model/ConnectServer.dart';
import '../widget/SupplementsGraph.dart';
import '../widget/CustomCheckBox.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCheckBox extends StatefulWidget {
  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isChecked = false;
  Color _textColor = Colors.black;

  final List<String> pillNames = ["닥터 써니디 연질캡슐", "리스트뷰 테스트"];
  final List<String> pillCnts = ["1정", "2정"];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: pillNames.length,
          itemBuilder: (context, i) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10, top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                          width: screenWidth * 0.7,
                          margin: const EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _isChecked
                                  ? Text(
                                      pillNames[i],
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  : Text(
                                      pillNames[i],
                                      style: TextStyle(fontSize: 18),
                                    ),
                              Text(
                                pillCnts[i],
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          )),
                      Container(
                        child: RoundCheckBox(
                          onTap: (selected) {
                            setState(() {
                              _isChecked = !_isChecked;
                            });
                          },
                          isChecked: _isChecked ? true : false,
                          borderColor: Color.fromARGB(255, 54, 23, 206),
                          checkedColor: Color.fromARGB(255, 54, 23, 206),
                          uncheckedColor: Colors.white,
                          checkedWidget: Icon(Icons.done, color: Colors.white),
                          uncheckedWidget: Icon(Icons.done,
                              color: Color.fromARGB(255, 54, 23, 206)),
                          animationDuration: Duration(seconds: 0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
