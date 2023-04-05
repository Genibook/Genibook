import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/widgets/navbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:genibook/models/schedule_class.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleAssignmentsList scheduleAssignments;

  const SchedulePage({Key? key, required this.scheduleAssignments})
      : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          const Navbar(selectedIndex: Constants.schedulePageNavNumber),
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
            lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
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
              final events =
                  widget.scheduleAssignments.list.where((assignment) {
                return isSameDay(assignment.dateAsDateTime, day);
              }).toList();

              return events.map((event) => event.assignment).toList();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.scheduleAssignments.list.length,
              itemBuilder: (context, index) {
                final assignment = widget.scheduleAssignments.list[index];

                if (isSameDay(_selectedDay, assignment.dateAsDateTime)) {
                  return ListTile(
                    title: Text(assignment.assignment),
                    subtitle: Text(
                        '${assignment.category} - ${assignment.courseName}'),
                    trailing: Text(assignment.points),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
