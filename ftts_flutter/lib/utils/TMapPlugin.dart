import 'package:flutter/services.dart';

class TMapPlugin {
  static const MethodChannel _channel = const MethodChannel('com.example.ftts_flutter/android');

  static Future<void> exeTMap(String food) async {
    try {
      var res = await _channel.invokeMethod('exeTMap', food);
      // print(res);
    } on PlatformException catch (e) {
      print("Failed to initialize TMap: ${e.message}");
    }
  }
}