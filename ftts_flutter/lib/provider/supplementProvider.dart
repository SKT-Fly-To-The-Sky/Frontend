import 'package:flutter/cupertino.dart';

class supplementProvider with ChangeNotifier {
  List<String> supplementList = ["프로바이더 테스트"];
  List<bool> supplementChecked = [false];
  List<String> supplementCnts = ["1정"];

  List<String> lunchSupList = ["점심약"];
  List<bool> lunchSupChecked = [false];
  List<String> lunchSupCnts = ["1정"];

  List<String> dinnerSupList = ["저녁약"];
  List<bool> dinnerSupChecked = [false];
  List<String> dinnerSupCnts = ["1정"];

  Map<String, dynamic> supplementnutInfo = {
    'kcal': 0.0,
    'protein': 0.0,
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
    "vitA": 0.0,
    "vitB1": 0.0,
    "vitB2": 0.0,
    "vitB3": 0.0,
    "vitB5": 0.0,
    "vitB6": 0.0,
    "vitB7": 0.0,
    "vitB9": 0.0,
    "vitB12": 0.0,
    "vitC": 0.0,
    "vitD": 0.0,
    "vitE": 0.0,
    "vitK": 0.0,
    "omega": 0.0,
  };

  List<String> get _supplementsList => supplementList;
  Map<String, dynamic> get _supplementsnutInfo => supplementnutInfo;

  addName(String input) {
    // 여기에 인자로 timeDiv(아침,점심,저녁)을 추가로 더 받아야 함
    supplementList.add(input);
    supplementChecked.add(false);
    supplementCnts.add("1정");
    notifyListeners();
  }

  updatenutInfo(Map<String, dynamic> result) {
    supplementnutInfo['vitA'] += result['vitA'];
    supplementnutInfo['vitB1'] += result['vitB1'];
    supplementnutInfo['vitB2'] += result['vitB2'];
    supplementnutInfo['vitB3'] += result['vitB3'];
    supplementnutInfo['vitB5'] += result['vitB5'];
    supplementnutInfo['vitB6'] += result['vitB6'];
    supplementnutInfo['vitB7'] += result['vitB7'];
    supplementnutInfo['vitB9'] += result['vitB9'];
    supplementnutInfo['vitB12'] += result['vitB12'];
    supplementnutInfo['vitC'] += result['vitC'];
    supplementnutInfo['vitD'] += result['vitD'];
    supplementnutInfo['vitE'] += result['vitE'];
    supplementnutInfo['vitF'] += result['vitF'];
    supplementnutInfo['omega'] += result['omega'];
    notifyListeners();
  }
}
