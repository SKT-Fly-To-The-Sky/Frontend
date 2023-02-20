import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ConnectServer {
  XFile? file;
  // final String Url = 'http://jeongsuri.iptime.org:10019/';
  final String Url='http://jeongsuri.iptime.org:10019/';
  final dio = Dio();

  String data="";
  List<String> foodName=[];



  Future<List<String>?> uploading(XFile file) async {
    //데이터 변환
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
      )
    });

    //log 설정
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false));

    //서버 연결 timeout 설정, connect, receive가 각각 5초안에 연결되지 않으면 fail(총 10초 소요)

    try{
      DateTime date = DateTime.now();
      final DateFormat formatter=DateFormat('yyyy-MM-dd');
      String onlydate=formatter.format(date);
      var sendImage = await dio.post('${Url}dodo/intakes/images', queryParameters:{'time_div':'launch','date':onlydate},data:formData);
      if (sendImage.data['message']=='image data saved successfully'){
        var classficationResult=await dio.get('${Url}classification',queryParameters: {'userid':'dodo','time_div':'launch','date':onlydate});
        if(classficationResult.statusCode==200){
          //값
          for (int i=0; i<int.parse(classficationResult.data['object_num'].toString());i++){
            foodName?.add(classficationResult.data['object'][i]['name'].toString());
            //영양소 값 합산
          }
        }
      }
    }
    catch(e){
      return ['김치전'];
    }
    return foodName;
  }

  Future<Map<String, dynamic>> GetNutInfo(List<String> name) async{
    DateTime date = DateTime.now();
    final DateFormat formatter=DateFormat('yyyy-MM-dd');
    String onlyDate=formatter.format(date);

    double kcal=0;
    double protein=0;
    double fat=0;
    double carbo=0;
    double sugar=0;
    double chole=0;
    double fiber=0;
    double calcium=0;
    double iron=0;
    double magne=0;
    double potass=0;
    double sodium=0;
    double zinc=0;
    double copper=0;
    double vitA=0;
    double vitB1=0;
    double vitB2=0;
    double vitB3=0;
    double vitB5=0;
    double vitB6=0;
    double vitB7=0;
    double vitB9=0;
    double vitB12=0;
    double vitC=0;
    double vitD=0;
    double vitE=0;
    double vitK=0;
    double omega=0;


      for (int i = 0; i < name.length; i++) {
        var foodsInfo = await dio.get(
            '${Url}foods/info', queryParameters: {"food_name": name[i]});

        print('value');
        print(foodsInfo.data['kcal'].toString());
        var toint=foodsInfo.data['kcal'].toString();
        print(double.parse(toint));

        kcal = kcal + double.parse(foodsInfo.data["kcal"].toString());
        protein = protein + double.parse(foodsInfo.data['protein'].toString());
        fat = fat + double.parse(foodsInfo.data['fat'].toString());
        carbo = carbo + double.parse(foodsInfo.data['carbo'].toString());
        sugar = sugar + double.parse(foodsInfo.data['sugar'].toString());
        chole = chole + double.parse(foodsInfo.data['chole'].toString());
        fiber = fiber + double.parse(foodsInfo.data['fiber'].toString());
        calcium = calcium + double.parse(foodsInfo.data['calcium'].toString());
        iron = iron + double.parse(foodsInfo.data['iron'].toString());
        magne = magne + double.parse(foodsInfo.data['magne'].toString());
        potass = potass + double.parse(foodsInfo.data['potass'].toString());
        sodium = sodium + double.parse(foodsInfo.data['sodium'].toString());
        zinc = zinc + double.parse(foodsInfo.data['zinc'].toString());
        copper = copper + double.parse(foodsInfo.data['copper'].toString());
        vitA = vitA + double.parse(foodsInfo.data['vitA'].toString());
        vitB1 = vitB1 + double.parse(foodsInfo.data['vitB1'].toString());
        vitB2 = vitB2 + double.parse(foodsInfo.data['vitB2'].toString());
        vitB3 = vitB3 + double.parse(foodsInfo.data['vitB3'].toString());
        vitB5 = vitB5 + double.parse(foodsInfo.data['vitB5'].toString());
        vitB6 = vitB6 + double.parse(foodsInfo.data['vitB6'].toString());
        vitB7 = vitB7 + double.parse(foodsInfo.data['vitB7'].toString());
        vitB9 = vitB9 + double.parse(foodsInfo.data['vitB9'].toString());
        vitB12 = vitB12 + double.parse(foodsInfo.data['vitB12'].toString());
        vitC = vitC + double.parse(foodsInfo.data['vitC'].toString());
        vitD = vitD + double.parse(foodsInfo.data['vitD'].toString());
        vitE = vitE + double.parse(foodsInfo.data['vitE'].toString());
        vitK = vitK + double.parse(foodsInfo.data['vitK'].toString());
        omega = omega + double.parse(foodsInfo.data['omega'].toString());

      }

    Map<String,dynamic> nut_info;
    nut_info={
      'time_div':'launch',
      'date':onlyDate,
      'time':"time",
      'kcal':kcal,
      'protein':protein,
      "fat": fat,
      "carbo": carbo,
      "sugar": sugar,
      "chole": chole,
      "fiber": fiber,
      "calcium": calcium,
      "iron": iron,
      "magne": magne,
      "potass": potass,
      "sodium": sodium,
      "zinc": zinc,
      "copper": copper,
      "vitA": vitA,
      "vitB1": vitB1,
      "vitB2": vitB2,
      "vitB3": vitB3,
      "vitB5": vitB5,
      "vitB6": vitB6,
      "vitB7": vitB7,
      "vitB9": vitB9,
      "vitB12": vitB12,
      "vitC": vitC,
      "vitD": vitD,
      "vitE": vitE,
      "vitK": vitK,
      "omega": omega,
      //영양소 추가
    };

    //식사 정보 전달
    dio.post('${Url}dodo/intakes/nutrients',
        options: Options(headers:{ HttpHeaders.contentTypeHeader:"application/json"}),data:jsonEncode(nut_info));

    return nut_info;
  }

  //약 이미지 전달
  Future<String> Supplementsuploading(XFile file) async{
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
      )
    });

    //log 설정
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false));

    //서버 연결 timeout 설정, connect, receive가 각각 5초안에 연결되지 않으면 fail(총 10초 소요)
    dio.options.connectTimeout=5000;
    dio.options.receiveTimeout=5000;

    try{

      //post image
      var response =
      await dio.post('${Url}api/picture/classification', data: formData);

      print("[SERVER] LOG response :"+response.toString());

      //현재 name 값이 null이면 error 발생. 'fail' 반환
      print("--------------------------------------");
      var testresult=response.data['name'];
      print("[SERVER] LOG name :"+testresult.toString());

      print("*****************************");
      String result=testresult;
      print("[SERVER] LOG result :"+result);

      // String result='${Url}api/picture/images/$responseClass';
      data=result;
    }
    catch(e){
      data='fail';
    }
    return data;
  }

}

class Result {
  final int object_num;
  final List<Object> object;

  Result({required this.object_num, required this.object});

  factory Result.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['object'] as List;
    List<Object> objectList = list.map((i) => Object.fromJson(i)).toList();


    return Result(
        object_num: parsedJson['object_num'],
        object: objectList

    );
  }
}

class Object {
  final String objectName;

  Object({ required this.objectName});

  factory Object.fromJson(Map<String, dynamic> parsedJson){
    return Object(
        objectName:parsedJson['name']
    );
  }
  Map<String,dynamic> toJson()=>{
    'name': objectName
  };
}
