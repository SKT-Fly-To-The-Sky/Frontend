import 'package:flutter/material.dart';
import 'package:ftts_flutter/provider/dateProvider.dart';
import 'package:ftts_flutter/provider/supplementProvider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'screen/HomeScreen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => supplementProvider()),
        ChangeNotifierProvider(create: (context) => dateProvider()),
        ChangeNotifierProvider(create: (context) => graphProvider())
      ], child: MyApp())));
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
