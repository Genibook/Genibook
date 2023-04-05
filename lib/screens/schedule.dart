import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:genibook/models/schedule_class.dart';

class SchedulePage extends StatefulWidget {
  final String jsonData;

  const SchedulePage({Key? key, required this.jsonData}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Assignment> _assignments = [];

  @override
  void initState() {
    super.initState();
    _assignments = parseAssignments(widget.jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2021, 1, 1),
            lastDay: DateTime.utc(2022, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) {
              final events = _assignments.where((assignment) {
                return isSameDay(assignment.date, day);
              }).toList();

              return events.map((event) => event.assignment).toList();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _assignments.length,
              itemBuilder: (context, index) {
                final assignment = _assignments[index];
                if (isSameDay(_selectedDay, assignment.date)) {
                  return ListTile(
                    title: Text(assignment.assignment),
                    subtitle: Text(
                        '${assignment.category} - ${assignment.courseName}'),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
