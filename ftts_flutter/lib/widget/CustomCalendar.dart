import 'package:flutter/material.dart';
import 'package:ftts_flutter/widget/DailyGraph.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:ftts_flutter/provider/dateProvider.dart';
import '../screen/MainScreen.dart';
import '../utils.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<dateProvider>(context, listen: false);
    return TableCalendar(
      locale: 'ko-KR',
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            provider.changeDate(_selectedDay); // 선택한 날짜에 해당하는 그래프 위젯 렌더링
            print("change onDaySelected");
          });
        }
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
