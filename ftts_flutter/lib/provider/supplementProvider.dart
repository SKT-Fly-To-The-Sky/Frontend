import 'package:flutter/cupertino.dart';

class supplementProvider with ChangeNotifier {

  List<String> supplementList = ["약이름 아침","약이름 점심","약이름 저녁"];

  List<dynamic> supplemetsMorningInfo=[['약이름 아침',false,'1정']];
  List<dynamic> supplemetsLunchInfo=[['약이름 점심',false,'1정']];
  List<dynamic> supplemetsDinnerInfo=[['약이름 저녁',false,'1정']];

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

  addName(String input) {
    // 여기에 인자로 timeDiv(아침,점심,저녁)을 추가로 더 받아야 함
    supplementList.add(input);
    // supplementChecked.add(false);
    // supplementCnts.add("1정");
    notifyListeners();
  }

  addNameText(String input,String Time,String num){
    switch(Time){
      case '아침':
        supplemetsMorningInfo.add([input,false,num]);
        break;
      case '점심':
        supplemetsLunchInfo.add([input,false,num]);
        break;
      case '저녁':
        supplemetsDinnerInfo.add([input,false,num]);
        break;
    }
    notifyListeners();
  }

  changeCheck(int i,String Time){
    switch(Time){
      case '아침':
        supplemetsMorningInfo[i][1]=!supplemetsMorningInfo[i][1];
        break;
      case '점심':
        supplemetsLunchInfo[i][1]=!supplemetsLunchInfo[i][1];
        break;
      case '저녁':
        supplemetsDinnerInfo[i][1]=!supplemetsDinnerInfo[i][1];
        break;

    }
    notifyListeners();
  }

  updatenutInfo(String name,Map<String, dynamic> result) {
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

    switch(result['Time']){
      case '아침':
        supplemetsMorningInfo.add([name,false,"1정"]);
        break;
      case '점심':
        supplemetsLunchInfo.add([name,false,"1정"]);
        break;
      case '저녁':
        supplemetsDinnerInfo.add([name,false,"1정"]);
        break;
    }
    notifyListeners();
  }
}
