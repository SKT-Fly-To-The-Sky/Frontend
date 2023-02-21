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
double vitA = 0;
double vitB1 = 0;
double vitB2 = 0;
double vitB3 = 0;
double vitB5 = 0;
double vitB6 = 0;
double vitB7 = 0;
double vitB9 = 0;
double vitB12 = 0;
double vitC = 0;
double vitD = 0;
double vitE = 0;
double vitK = 0;
double omega = 0;

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
  "vitA": vitA,
  "vitB1": vitB1,
  "vitB2": vitB2,
  "vitB3": vitB3,
  "vitB5": vitB5,
  "vitB6": vitB6,
  "vitB7": vitB7,
  "vitB9": vitB9,
  "vitB12": vitB12,
  "vitC": vitC,
  "vitD": vitD,
  "vitE": vitE,
  "vitK": vitK,
  "omega": omega,
  //영양소 추가
};
