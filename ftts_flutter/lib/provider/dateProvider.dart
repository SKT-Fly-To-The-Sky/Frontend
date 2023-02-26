import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class dateProvider with ChangeNotifier {
  DateTime providerDate = DateTime.now();

  changeDate(DateTime d) {
    providerDate = d;
    notifyListeners();
  }
}

class graphProvider with ChangeNotifier {
  Map<String, dynamic> oneday_info = {
    "userid": "dodo",
    "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
    "kcal": 0.0,
    "protein": 0.0,
    "fat": 0.0,
    "carbo": 0.0,
    "sugar": 0.0,
    "chole": 0.0,
    "fiber": 0.0,
    "calcium": 0.0,
    "iron": 0.0,
    "magne": 0.0,
    "potass": 0.0,
    "sodium": 0.0,
    "zinc": 0.0,
    "copper": 0.0,
  };

  changeOneDayInfo(Map<String, dynamic> m) {
    oneday_info['date']=m['date'];
    oneday_info["kcal"]=m["kcal"];
    oneday_info['protein']=m['protein'];
    oneday_info["fat"]=m["fat"];
    oneday_info['carbo']=m['carbo'];
    oneday_info["sugar"]=m["sugar"];
    oneday_info['chole']=m['chole'];
    oneday_info["fiber"]=m["fiber"];
    oneday_info['date']=m['date'];
    oneday_info["calcium"]=m["calcium"];
    oneday_info['iron']=m['iron'];
    oneday_info["magne"]=m["magne"];
    oneday_info['potass']=m['potass'];
    oneday_info["sodium"]=m["sodium"];
    oneday_info['zinc']=m['zinc'];
    oneday_info["zinc"]=m["zinc"];

    print(oneday_info);
    notifyListeners();
  }
}
