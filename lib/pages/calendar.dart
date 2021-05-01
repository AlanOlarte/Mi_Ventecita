import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key key}) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay;
  DateTime _selectedDay;
  DateTime now = DateTime.now();
  String dia = '';

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    dia = '${now.day}/${now.month}/${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  Widget _calendar() {
    return Column(
      children: [
        TableCalendar(
          //locale: 'es_ES',

            headerStyle:
            HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            selectedDayPredicate: (day) => _selectedDay == day,
            onDaySelected: (selectedDay, focusedDay) {
              final diaLengt = (selectedDay.day.toString().length == 1)? '${selectedDay.day}' : '${selectedDay.day}';
              final mesLengt = (selectedDay.month.toString().length == 1)? '${selectedDay.month}' : '${selectedDay.month}';
              setState(() {
                _focusedDay = focusedDay;
                _selectedDay = selectedDay;
                dia = '$diaLengt/$mesLengt/${selectedDay.year}';
              });
            },
            focusedDay: _focusedDay,
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(Duration(days: 300))),
        TextButton(onPressed: () {}, child: Text("Agendar")),
        Text(DateFormat('EEEEE', 'en_US').format(DateFormat.yMd('en_US').parse(dia)))
      ],
    );
  }
}
