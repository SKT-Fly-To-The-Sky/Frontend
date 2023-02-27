import 'dart:convert';
import 'dart:io';
import '../utils/nutInfo.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ConnectServer {
  XFile? file;

  final String Url = 'http://jeongsuri.iptime.org:10019/';
  final dio = Dio();

  String data = "";
  List<String> foodName = [];
  List<double> foodSize = [];

  Future<List<dynamic>?> uploading(
      XFile file, String selectDay, String time) async {
    List<dynamic> foodCls = [];
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
    dio.options.connectTimeout = 100000;
    dio.options.receiveTimeout = 100000;
    try {
      var sendImage = await dio.post('${Url}dodo/intakes/images',
          queryParameters: {'time_div': time, 'date': selectDay},
          data: formData);
      if (sendImage.data['message'] == 'image data saved successfully') {
        var classficationResult = await dio.get('${Url}classification',
            queryParameters: {
              'userid': 'dodo',
              'time_div': time,
              'date': selectDay
            });

        if (classficationResult.statusCode == 200) {
          //값
          for (int i = 0;
              i < int.parse(classficationResult.data['object_num'].toString());
              i++) {
            if (classficationResult.data['object'][i]['name'].toString() !=
                null) {
              foodCls?.add([
                classficationResult.data['object'][i]['name'].toString(),
                classficationResult.data['object'][i]['volumes']
              ]);
              foodName.add(
                  classficationResult.data['object'][i]['name'].toString());
              print(foodName);

              print(foodCls);
            }
            try {
              dio.post('${Url}dodo/intakes/foods/names',
                  options:
                      Options(headers: {'Content-Type': 'application/json'}),
                  queryParameters: {'time_div': time, 'date': selectDay},
                  data: json.encode(foodName));
            } catch (e) {
              print("이름 전달 실패");
            }

            //영양소 값 합산
          }
          if (foodCls == null) {
            foodCls.add(['불고기', 1.0]);
          }
        }
      }
      return foodCls;
    } catch (e) {
      return [
        ['불고기', 1.0]
      ];
    }
  }

  Future<Map<String, dynamic>> foodNutinfo(
      List<dynamic> foodCls, String selectDay, String time) async {
    print(foodCls);
    print("foodCls testing----------------------------");
    print(foodCls[0][0]);
    try {
      for (int i = 0; i < foodCls.length; i++) {
        var foodsInfo = await dio.get('${Url}foods/info',
            queryParameters: {"food_name": foodCls[i][0]});

        nut_info['kcal'] = kcal +
            (double.parse(foodsInfo.data["kcal"].toString())) * foodCls[i][1];
        nut_info['protein'] = protein +
            (double.parse(foodsInfo.data['protein'].toString()) *
                foodCls[i][1]);
        nut_info['fat'] = fat +
            (double.parse(foodsInfo.data['fat'].toString()) * foodCls[i][1]);
        nut_info['carbo'] = carbo +
            (double.parse(foodsInfo.data['carbo'].toString()) * foodCls[i][1]);
        nut_info['sugar'] = sugar +
            (double.parse(foodsInfo.data['sugar'].toString()) * foodCls[i][1]);
        nut_info['chole'] = chole +
            (double.parse(foodsInfo.data['chole'].toString()) * foodCls[i][1]);
        nut_info['fiber'] = fiber +
            (double.parse(foodsInfo.data['fiber'].toString()) * foodCls[i][1]);
        nut_info['calcium'] = calcium +
            (double.parse(foodsInfo.data['calcium'].toString()) *
                foodCls[i][1]);
        nut_info['iron'] = iron +
            (double.parse(foodsInfo.data['iron'].toString()) * foodCls[i][1]);
        nut_info['magne'] = magne +
            (double.parse(foodsInfo.data['magne'].toString()) * foodCls[i][1]);
        nut_info['potass'] = potass +
            (double.parse(foodsInfo.data['potass'].toString()) * foodCls[i][1]);
        nut_info['sodium'] = sodium +
            (double.parse(foodsInfo.data['sodium'].toString()) * foodCls[i][1]);
        nut_info['zinc'] = zinc +
            (double.parse(foodsInfo.data['zinc'].toString()) * foodCls[i][1]);
        nut_info['copper'] = copper +
            (double.parse(foodsInfo.data['copper'].toString()) * foodCls[i][1]);
      }

      print("nut_info");
      print(nut_info);

      var post_info = {
        "time_div": time,
        "date": selectDay,
        "time": "",
        "protein": nut_info['protein'],
        "fat": nut_info['fat'],
        "carbo": nut_info['carbo'],
        "sugar": nut_info['sugar'],
        "chole": nut_info['chole'],
        "fiber": nut_info['fiber'],
        "calcium": nut_info['calcium'],
        "iron": nut_info['iron'],
        "magne": nut_info['magne'],
        "potass": nut_info['potass'],
        "sodium": nut_info['sodium'],
        "zinc": nut_info['zinc'],
        "copper": nut_info['copper'],
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
        "omega": 0,
        "kcal": nut_info['kcal']
      };

      print(post_info);
      dio.post('${Url}dodo/intakes/nutrients',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: json.encode(post_info));
      return nut_info;
    } catch (e) {
      return nut_info;
    }
  }

  Future<List<String>> foodNames(String selectDay, String time) async {
    List<String> Result = [];

    var response = await dio.get('${Url}dodo/intakes/foods/names',
        queryParameters: {"time_div": time, "date": selectDay});
    if (response.statusCode == 200) {
      for (int i = 0; response.data['object_num']; i++) {
        Result.add(response.data['object'][i]);
      }
      return Result;
    }
    return ["불고기"];
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
    //서버 연결 timeout 설정, connect, receive가 각각 10초안에 연결되지 않으면 fail(총 10초 소요)
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    try {
      //post image
      var response =
          await dio.post('${Url}supplements/classification', data: formData);

      data = response.data['object'][0]['name'].toString();
      print("supplement testing");
      print(data);
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
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;
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

  Future<Map<String, dynamic>> getOneDayInfo(String day) async {
    print('Day fppd info');

    //log 설정
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false));
    //서버 연결 timeout 설정, connect, receive가 각각 5초안에 연결되지 않으면 fail(총 10초 소요)
    dio.options.connectTimeout = 100000;
    dio.options.receiveTimeout = 100000;

    try {
      var supinfo = await dio.get(
          'http://jeongsuri.iptime.org:10019/dodo/intakes/nutrients/day',
          queryParameters: {"date": day});
      Map<String, dynamic> _onedayInfo;
      _onedayInfo = {
        "userid": supinfo.data['userid'].toString(),
        "date": supinfo.data['date'].toString(),
        "kcal": double.parse(supinfo.data['kcal'].toString()),
        "protein": double.parse(supinfo.data['protein'].toString()),
        "fat": double.parse(supinfo.data['fat'].toString()),
        "carbo": double.parse(supinfo.data['carbo'].toString()),
        "sugar": double.parse(supinfo.data['sugar'].toString()),
        "chole": double.parse(supinfo.data['chole'].toString()),
        "fiber": double.parse(supinfo.data['fiber'].toString()),
        "calcium": double.parse(supinfo.data['calcium'].toString()),
        "magne": double.parse(supinfo.data['magne'].toString()),
        "iron": double.parse(supinfo.data['iron'].toString()),
        "potass": double.parse(supinfo.data['potass'].toString()),
        "sodium": double.parse(supinfo.data['sodium'].toString()),
        "zinc": double.parse(supinfo.data['zinc'].toString()),
        "copper": double.parse(supinfo.data['copper'].toString()),
      };
      print("_onedayInfo data: " + _onedayInfo['kcal'].toString());
      return _onedayInfo;
    } catch (e) {
      print("catch");
      Map<String, dynamic> _onedayInfo;
      _onedayInfo = {
        "userid": "dodo",
        "date": day,
        "kcal": 0.0,
        "protein": 0.0,
        "fat": 0.0,
        "carbo": 0.0,
        "sugar": 0.0,
        "chole": 0.0,
        "fiber": 0.0,
        "calcium": 0.0,
        "magne": 0.0,
        "iron": 0.0,
        "potass": 0.0,
        "sodium": 0.0,
        "zinc": 0.0,
        "copper": 0.0,
      };
      print("_onedayInfo data: " + _onedayInfo['kcal'].toString());
      print("catech end--------------------");
      return _onedayInfo;
    }
  }

  Future<List<dynamic>> foodRecommand(String day) async {
    var foodrecommand = [];

    try {
      var recommanddata = await dio.get('${Url}dodo/foods/recommand',
          queryParameters: {'time_div': day});
      for (int i = 0; i < 3; i++) {
        foodrecommand.add([
          recommanddata.data["name"].toString(),
          recommanddata.data["image"].toString()
        ]);
      }
      return foodrecommand;
    } catch (e) {
      return [
        [
          "라면",
          "https://dl.dropbox.com/s/kdbdhuo47cdfhi7/%EB%9D%BC%EB%A9%B4.jpeg?dl=0"
        ],
        [
          '된장찌게',
          'https://dl.dropbox.com/s/pl7kcss1101ujmx/%EB%90%9C%EC%9E%A5%EC%B0%8C%EA%B0%9C.jpeg?dl=0'
        ],
        [
          '토스트',
          "https://dl.dropbox.com/s/17q0vm86y4njnjc/%ED%86%A0%EC%8A%A4%ED%8A%B8.jpeg?dl=0"
        ]
      ];
    }
  }
}
