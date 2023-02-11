import 'package:flutter/material.dart';
import 'screen/HomeScreen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fly To The Sky',
      theme: ThemeData(fontFamily: 'NotoSansKR'),
      home: HomeScreen(),
    );
  }
}
