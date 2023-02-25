import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class dateProvider with ChangeNotifier {
  DateTime providerDate = DateTime.now();

  changeDate(DateTime d) {
    providerDate = d;
    print("change providerDate");
    notifyListeners();
  }
}

class graphProvider with ChangeNotifier {
  Map<String, dynamic> oneday_info = {
    'time_div': 'morning',
    'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    'time': "time",
    'kcal': 0,
    'protein': 0,
    "fat": 0,
    "carbo": 0,
    "sugar": 0,
    "chole": 0,
    "fiber": 0,
    "calcium": 0,
    "iron": 0,
    "magne": 0,
    "potass": 0,
    "sodium": 0,
    "zinc": 0,
    "copper": 0,
  };

  changeGraph(Map<String, dynamic> m) {
    oneday_info = m;
    print(oneday_info);
    notifyListeners();
  }
//   DateTime date = DateTime.now();
//   final DateFormat formatter = DateFormat('yyyy-MM-dd');
//   String onlydate = formatter.format(date);

//   double _kcal = 0;
//   double _protein = 0;
//   double _fat = 0;
//   double _carbo = 0;
//   double _sugar = 0;
//   double _chole = 0;
//   double _fiber = 0;
//   double _calcium = 0;
//   double _iron = 0;
//   double _magne = 0;
//   double _potass = 0;
//   double _sodium = 0;
//   double _zinc = 0;
//   double _copper = 0;

//   Map<String, dynamic> oneday_info = {
//     'time_div': 'morning',
//     'date': onlydate,
//     'time': "time",
//     'kcal': kcal,
//     'protein': protein,
//     "fat": fat,
//     "carbo": carbo,
//     "sugar": sugar,
//     "chole": chole,
//     "fiber": fiber,
//     "calcium": calcium,
//     "iron": iron,
//     "magne": magne,
//     "potass": potass,
//     "sodium": sodium,
//     "zinc": zinc,
//     "copper": copper,
//   };
}
