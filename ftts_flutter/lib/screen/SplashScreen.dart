import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, () {
      Navigator.of(context).pushReplacementNamed('/homeScreen');
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Color(0xFF334CFF),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Image.asset(
                'assets/adot_splash.jpg',
                width: screenWidth,
                // height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
