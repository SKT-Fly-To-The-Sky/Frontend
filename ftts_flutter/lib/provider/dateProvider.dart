import 'package:flutter/material.dart';

class dateProvider with ChangeNotifier {
  DateTime providerDate = DateTime.now();

  changeDate(DateTime d) {
    providerDate = d;
    print("change providerDate");
    notifyListeners();
  }
}
