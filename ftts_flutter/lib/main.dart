import 'package:flutter/material.dart';
import 'screen/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fly To The Sky',
      theme: ThemeData(),
      home: HomeScreen(),
    );
  }
}
