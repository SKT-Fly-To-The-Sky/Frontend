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
  Map<String, dynamic>? oneday_info = {
    "userid": "dodo",
    "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
    "kcal": 0,
    "protein": 0,
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
    "vitA": 0,
    "vitB1": 0,
    "vitB2": 0,
    "vitB3": 0,
    "vitB5": 0,
    "vitB6": 0,
    "vitB7": 0,
    "vitB9": 0,
    "vitB12": 0,
    "vitC": 0,
    "vitD": 0,
    "vitE": 0,
    "vitK": 0,
    "omega": 0
  };

  changeOneDayInfo(Map<String, dynamic>? m) {
    oneday_info = m;
    notifyListeners();
  }
}
