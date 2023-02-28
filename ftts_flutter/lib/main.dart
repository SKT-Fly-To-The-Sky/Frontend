import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ftts_flutter/provider/dateProvider.dart';
import 'package:ftts_flutter/provider/supplementProvider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'model/ConnectServer.dart';
import 'screen/SplashScreen.dart';
import 'screen/HomeScreen.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => supplementProvider()),
        ChangeNotifierProvider(create: (context) => dateProvider()),
        ChangeNotifierProvider(create: (context) => graphProvider()),
        ChangeNotifierProvider(create: (context) => timeDivProvider())
      ], child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final connectServer = ConnectServer();
    //여기서 db 지우기 실행
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fly To The Sky',
        theme: ThemeData(fontFamily: 'NotoSansKR'),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/homeScreen': (BuildContext context) => HomeScreen()
        }
        // HomeScreen(),
        );
  }
}
