import 'package:flutter/material.dart';
import 'package:ftts_flutter/provider/dateProvider.dart';
import 'package:ftts_flutter/provider/supplementProvider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'screen/SplashScreen.dart';
import 'screen/HomeScreen.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // FlutterNativeSplash.remove();
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
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/homeScreen': (BuildContext context) => HomeScreen()
        }
        // HomeScreen(),
        );
  }
}
