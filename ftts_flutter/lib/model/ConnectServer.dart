import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ConnectServer {
  XFile? file;
  final String Url = 'http://jeongsuri.iptime.org:10019/';
  final dio = Dio();

  String data="";

  Future<String> uploading(XFile file) async {
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
  //image list를 불러오는 기능

  // Future<String> getImagepath() async{
  //   var response=await dio.get('${Url}api/picture/list');
  //   //받아온 데이터 json 변환
  //
  //   if(response.statusCode==200){
  //   var responseData=(response.data).map<GetImage>((json)=>GetImage.fromJson(json: json)).toList();
  //   String Name=await responseData[0].image_name;
  //   //image name으로 get요청
  //   String imagePath='${Url}api/picture/images/$Name';
  //   print("imagePath");
  //   print(imagePath);
  //
  //   return imagePath;
  //   }else{
  //     return "fail";
  //   }
  //   //이미지가 저장된 경로 접속하면 저장한 이미지를 띄울 수 있다
  // }
}
//get 할 때 사용되는 class
// class GetImage{
//   final String fileName;
//
//   GetImage({required this.fileName});
//   GetImage.fromJson({required Map<String,dynamic>json}):fileName=json['fileName'];
//   Map<String,dynamic>toJson(){return{'fileName':fileName};}
// }
