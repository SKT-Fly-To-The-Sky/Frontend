import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

var imagePath;

class ConnectServer{
  XFile? file;

  Future uploading(XFile file) async{
    final String Url = 'http://210.109.63.74:11003/';

    //데이터 변환
    FormData formData =FormData.fromMap({
      'file':await MultipartFile.fromFile(
        file.path,
      )
    });

    final dio=Dio();

    //log 설정
    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false));

    //post image
    dio.post(Url+'api/picture/upload-images',data: formData);
    //image name 받아오기
    var response=await dio.get(Url+'api/picture/list');
    //받아온 데이터 json 변환
    var responseData=(response.data).map<GetImage>((json)=>GetImage.fromJson(json: json)).toList();
    String Name=responseData[0].image_name;
    //image name으로 get요청
    imagePath=Url+'api/picture/images/'+Name;
    print(imagePath);
    //이미지가 저장된 경로 접속하면 저장한 이미지를 띄울 수 있다.
  }
}


class GetImage{
  final String image_name;

  GetImage({required this.image_name});
  GetImage.fromJson({required Map<String,dynamic>json}):image_name=json['image_name'];
  Map<String,dynamic>toJson(){return{'image_name':image_name};}
}
