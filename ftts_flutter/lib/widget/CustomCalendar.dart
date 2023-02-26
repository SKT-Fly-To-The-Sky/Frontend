import 'package:flutter/material.dart';
import 'package:ftts_flutter/provider/supplementProvider.dart';
import 'package:ftts_flutter/utils/nutInfo.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:ftts_flutter/provider/dateProvider.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import '../model/ConnectServer.dart';
import '../utils.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  Map<String, dynamic> _oneDayInfo = {};
  String _dateString = '';

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var dateprovider = Provider.of<dateProvider>(context, listen: false);
    var graphprovider = Provider.of<graphProvider>(context, listen: false);
    final connectServer = ConnectServer();

    return TableCalendar(
      locale: 'ko-KR',
      daysOfWeekHeight: 20,
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) async {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;

        _dateString = DateFormat('yyyy-MM-dd').format(_selectedDay);

        Map<String,dynamic>? result;
        result = await connectServer.getOneDayInfo(_dateString);
        graphprovider.changeOneDayInfo(result!);
        dateprovider.changeDate(_selectedDay); // 선택한 날짜에 해당하는 그래프 위젯 렌더링

      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: const BoxDecoration(
          color: const Color(0xFFaea2eb),
          shape: BoxShape.circle,
        ),
        todayDecoration: const BoxDecoration(
          color: const Color(0xFF3617CE),
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: const TextStyle(fontSize: 17.0)),
    );
  }
}
