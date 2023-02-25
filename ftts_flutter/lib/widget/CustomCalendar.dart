import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:ftts_flutter/provider/dateProvider.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
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
    Future<void> _getOneDayInfo(DateTime day) async {
      try {
        _dateString = DateFormat('yyyy-MM-dd').format(day);
        Response response = await Dio().get(
            'http://jeongsuri.iptime.org:10019/dodo/intakes/nutrients/day?date=${_dateString}');
        _oneDayInfo = await response.data['result'];
      } catch (e) {
        print("_getOneDayInfo error!!");
      }
    }

    return TableCalendar(
      locale: 'ko-KR',
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
        await _getOneDayInfo(_selectedDay);
        dateprovider.changeDate(_selectedDay); // 선택한 날짜에 해당하는 그래프 위젯 렌더링
        graphprovider.changeOneDayInfo(_oneDayInfo);
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
