import 'dart:convert';
import 'dart:io';
import '../utils/nutInfo.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ConnectServer {
  XFile? file;

  // final String Url = 'http://jeongsuri.iptime.org:10019/';
  final String Url = 'http://jeongsuri.iptime.org:10019/';
  final dio = Dio();

  String data = "";
  List<String> foodName = [];

  Future<List<String>?> uploading(XFile file, String selectDay) async {
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
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    try {
      var sendImage = await dio.post('${Url}dodo/intakes/images',
          queryParameters: {'time_div': 'morning', 'date': selectDay},
          data: formData);
      if (sendImage.data['message'] == 'image data saved successfully') {
        var classficationResult = await dio.get('${Url}classification',
            queryParameters: {
              'userid': 'dodo',
              'time_div': 'morning',
              'date': selectDay
            });

        if (classficationResult.statusCode == 200) {
          //값
          for (int i = 0;
              i < int.parse(classficationResult.data['object_num'].toString());
              i++) {
            foodName
                ?.add(classficationResult.data['object'][i]['name'].toString());
            //영양소 값 합산
          }
        }
      }
      return foodName;
    } catch (e) {
      return ['불고기'];
    }
  }

  Future<Map<String, dynamic>> foodNutinfo(
      List<String> name, String selectDay) async {
    try {
      for (int i = 0; i < name.length; i++) {
        var foodsInfo = await dio
            .get('${Url}foods/info', queryParameters: {"food_name": name[i]});

        nut_info['kcal'] =
            kcal + double.parse(foodsInfo.data["kcal"].toString());
        nut_info['protein'] =
            protein + double.parse(foodsInfo.data['protein'].toString());
        nut_info['fat'] = fat + double.parse(foodsInfo.data['fat'].toString());
        nut_info['carbo'] =
            carbo + double.parse(foodsInfo.data['carbo'].toString());
        nut_info['sugar'] =
            sugar + double.parse(foodsInfo.data['sugar'].toString());
        nut_info['chole'] =
            chole + double.parse(foodsInfo.data['chole'].toString());
        nut_info['fiber'] =
            fiber + double.parse(foodsInfo.data['fiber'].toString());
        nut_info['calcium'] =
            calcium + double.parse(foodsInfo.data['calcium'].toString());
        nut_info['iron'] =
            iron + double.parse(foodsInfo.data['iron'].toString());
        nut_info['magne'] =
            magne + double.parse(foodsInfo.data['magne'].toString());
        nut_info['potass'] =
            potass + double.parse(foodsInfo.data['potass'].toString());
        nut_info['sodium'] =
            sodium + double.parse(foodsInfo.data['sodium'].toString());
        nut_info['zinc'] =
            zinc + double.parse(foodsInfo.data['zinc'].toString());
        nut_info['copper'] =
            copper + double.parse(foodsInfo.data['copper'].toString());
      }

      print("nut_info");
      print(nut_info);

      Map<String, dynamic> post_info = {
        "time_div": 'morning',
        "date": selectDay,
        "time": " "
      };
      post_info.addAll(nut_info);

      dio.post('${Url}dodo/intakes/nutrients',
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}),
          data: jsonEncode(post_info));
      return nut_info;
    } catch (e) {
      return nut_info;
    }
  }

  //약 이미지 전달
  Future<String> Supplementsuploading(XFile file) async {
    print('supplementsuploading');
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
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    try {
      //post image
      var response =
          await dio.post('${Url}supplements/classification', data: formData);
      data = response.data['name'].toString();
    } catch (e) {
      data = '비타민D';
    }
    return data;
  }

  //1안
  Future<String> SupplementTime(String name) async {
    //log 설정
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false));
    //서버 연결 timeout 설정, connect, receive가 각각 5초안에 연결되지 않으면 fail(총 10초 소요)
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    String Time = '';
    try {
      var supinfo = await dio
          .get('${Url}supplements/info', queryParameters: {"sup_name": name});
      Time = supinfo.data['add_eat_time'];
      return Time;
    } catch (e) {
      return '아침';
    }
  }

  Future<Map<String, dynamic>> SupplementsNutinfo(String name) async {
    print('SupplementsNutinfo');

    //log 설정
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false));
    //서버 연결 timeout 설정, connect, receive가 각각 5초안에 연결되지 않으면 fail(총 10초 소요)
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;

    try {
      var supinfo = await dio
          .get('${Url}supplements/info', queryParameters: {"sup_name": name});
      Map<String, dynamic> supnut_info;
      supnut_info = {
        "vitA": double.parse(supinfo.data['vitA'].toString()),
        "vitB1": double.parse(supinfo.data['vitB1'].toString()),
        "vitB2": double.parse(supinfo.data['vitB2'].toString()),
        "vitB3": double.parse(supinfo.data['vitB3'].toString()),
        "vitB5": double.parse(supinfo.data['vitB5'].toString()),
        "vitB6": double.parse(supinfo.data['vitB6'].toString()),
        "vitB7": double.parse(supinfo.data['vitB7'].toString()),
        "vitB9": double.parse(supinfo.data['vitB9'].toString()),
        "vitB12": double.parse(supinfo.data['vitB12'].toString()),
        "vitC": double.parse(supinfo.data['vitC'].toString()),
        "vitD": double.parse(supinfo.data['vitD'].toString()),
        "vitE": double.parse(supinfo.data['vitE'].toString()),
        "vitK": double.parse(supinfo.data['vitK'].toString()),
        "omega": double.parse(supinfo.data['omega'].toString()),
        "Time": supinfo.data['add_eat_time'].toString()
      };
      print("nut_info data: " + nut_info['kcal'].toString());
      return supnut_info;
    } catch (e) {
      Map<String, dynamic> nut_info;
      nut_info = {
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
        "Time": '아침'
      };
      print("nut_info data: " + nut_info['kcal'].toString());
      return nut_info;
    }
  }
}
