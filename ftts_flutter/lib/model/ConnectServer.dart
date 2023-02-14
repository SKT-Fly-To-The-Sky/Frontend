import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ConnectServer {
  XFile? file;
  final String Url = 'http://jeongsuri.iptime.org:11003/';
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
    dio.options.connectTimeout = 3000;
    dio.options.receiveTimeout= 3000;
    try{
      //post image
      var response =
      await dio.post('${Url}api/picture/classification', data: formData);

      print("response");
      print(response);
      //현재 정보값 이름을 몰라서 비워둔 부분. 이후 추가 예정
      var responseClass=response.data>[''];
      String result='${Url}api/picture/images/$responseClass';
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
