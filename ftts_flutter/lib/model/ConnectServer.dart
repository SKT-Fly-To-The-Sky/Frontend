import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ConnectServer {
  XFile? file;
  final String Url = 'http://jeongsuri.iptime.org:11003/';
  final dio = Dio();

  var data=new List<String>.filled(2, 'fail', growable: false);

  //Future<String> uploading(XFile file) async {
    //데이터 변환
  Future<List<String>> uploading(XFile file) async {
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

    // //post image
    // var response =
    //     await dio.post('${Url}api/picture/upload-images', data: formData);
    // var responseData = response.data?['fileName'];
    // String imagePath = '${Url}api/picture/images/$responseData';
    //
    // return imagePath;
    try{
      //post image
      var response =
      await dio.post('${Url}api/picture/classification', data: formData);
      var responseImage = response.data?['fileName'];
      //classfication 내용 추가 (수정 필요)
      var responseClass = response.data?['class'];
      String imagePath = '${Url}api/picture/images/$responseImage';
      //String classfication = '${Url}api/picture/images/$responseClass';
      data[0]=imagePath;
      //data[1]=classfication;
    }
    catch(e){
      data[0]='fail';
      data[1]='fail';
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
