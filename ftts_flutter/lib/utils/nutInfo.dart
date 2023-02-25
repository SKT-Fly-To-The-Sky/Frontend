import 'package:intl/intl.dart';

DateTime date = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
String onlydate = formatter.format(date);

double kcal = 0;
double protein = 0;
double fat = 0;
double carbo = 0;
double sugar = 0;
double chole = 0;
double fiber = 0;
double calcium = 0;
double iron = 0;
double magne = 0;
double potass = 0;
double sodium = 0;
double zinc = 0;
double copper = 0;

// 이미지 하나 당 영양성분
Map<String, dynamic> nut_info = {
  'time_div': 'morning',
  'date': onlydate,
  'time': "time",
  'kcal': kcal,
  'protein': protein,
  "fat": fat,
  "carbo": carbo,
  "sugar": sugar,
  "chole": chole,
  "fiber": fiber,
  "calcium": calcium,
  "iron": iron,
  "magne": magne,
  "potass": potass,
  "sodium": sodium,
  "zinc": zinc,
  "copper": copper,
};
