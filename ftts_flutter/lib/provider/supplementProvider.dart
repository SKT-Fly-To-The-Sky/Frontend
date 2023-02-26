import 'package:flutter/cupertino.dart';

class supplementProvider with ChangeNotifier {

  List<String> supplementList = ["힐링팩토리 블루마린 오메가3","헬스프랜드 캐나다 칼슘 마그네슘 비타민D 아연","헬스프랜드 캐나다 슈퍼징코플러스"];

  List<dynamic> supplemetsMorningInfo=[["힐링팩토리 블루마린 오메가3",false,'1정']];
  List<dynamic> supplemetsLunchInfo=[["헬스프랜드 캐나다 칼슘 마그네슘 비타민D 아연",false,'1정']];
  List<dynamic> supplemetsDinnerInfo=[["헬스프랜드 캐나다 슈퍼징코플러스",false,'1정']];

  Map<String, dynamic> supplementnutInfo = {
    "vitA": 0.0,
    "vitB1": 0.0,
    "vitB2": 0.0,
    "vitB3": 15.0,
    "vitB5": 0.0,
    "vitB6": 0.0,
    "vitB7": 0.0,
    "vitB9": 200.0,
    "vitB12": 3.0,
    "vitC": 0.0,
    "vitD": 40.5,
    "vitE": 0.0,
    "vitK": 0.0,
    "omega": 1200.0,
  };

  addName(String input) {
    supplementList.add(input);

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
    print(supplementnutInfo['omega']);
    print(result['omega']);
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
    print(supplementnutInfo['omega']);
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
