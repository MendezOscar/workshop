import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSelector extends StatefulWidget {
  final List<DateTime>? dates;
  final DateTime startDeadline;
  final DateTime endDeadline;

  final void Function(DateTime index)? onSelected;
  const CalendarSelector(
      {super.key,
      required this.onSelected,
      this.dates,
      required this.startDeadline,
      required this.endDeadline});

  @override
  _CalendarSelectorState createState() => _CalendarSelectorState();
}

class _CalendarSelectorState extends State<CalendarSelector> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool todayIsWithinRangeSelected() {
    if (DateTime.now().isAtSameMomentAs(_focusedDay)) {
      return true;
    } else {
      return false;
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }

    Navigator.of(context).pop();
    widget.onSelected!.call(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableCalendar(
          firstDay: widget.startDeadline,
          lastDay: widget.endDeadline,
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0XFF0879A6))),
            selectedDecoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0XFF0879A6)),
            todayTextStyle: todayIsWithinRangeSelected()
                ? TextStyle(color: Colors.white)
                : TextStyle(color: Colors.black),
          ),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          availableCalendarFormats: const {CalendarFormat.month: 'Month'},
          weekNumbersVisible: false,
          startingDayOfWeek: StartingDayOfWeek.monday,
          onDaySelected: _onDaySelected,
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
        )
      ],
    );
  }
}
