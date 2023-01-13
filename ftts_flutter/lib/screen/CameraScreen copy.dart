import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'ResultScreen.dart';
import '../model/ConnectServer.dart';

//main을 켜면 가장 먼저 나오는 화면으로 이미지 촬영을 위한 버튼과 갤러리 접근 버튼이 있다.
class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  _CameraExampleState createState() => _CameraExampleState();

}

class _CameraExampleState extends State<CameraExample> {
  //port
  final picker = ImagePicker();
  final connectServer=ConnectServer();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  // 이미지 resize도 함께 해준다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource,
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 50,
    );

    // image에 값이 있다면 server와 connect
    if(image!=null){
      connectServer.uploading(image!);

      setState(() {
      });
    }
    else{print("_image is null");}
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    //UI
    return Scaffold(
        backgroundColor: const Color(0xfff4f3f9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 카메라 촬영 버튼 동작
                FloatingActionButton(
                  child: Icon(Icons.add_a_photo),
                  tooltip: 'pick Image',
                  onPressed: () {
                    //카메라에서 이미지 가져오기
                    getImage(ImageSource.camera);
                  },
                ),

                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  child: Icon(Icons.wallpaper),
                  tooltip: 'pick Image',
                  onPressed: () {
                    //갤러리에서 이미지 가져오기
                    getImage(ImageSource.gallery);
                  },
                // ),Container(
                //     color: const Color(0xffd0cece),
                //     width: MediaQuery.of(context).size.width,
                //     height: MediaQuery.of(context).size.width,
                //     child: Center(
                //         child: Image.network('image 파일 링크를 입력하면 출력할 수 있다.')
                //     )
                 )
              ],
            )
          ],
        )
    );
  }
}