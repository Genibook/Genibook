import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/widgets/navbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:genibook/models/schedule_class.dart';
import 'package:genibook/routes/swipe.dart';

class SchedulePage extends StatefulWidget {
  final ScheduleAssignmentsList scheduleAssignments;

  const SchedulePage({Key? key, required this.scheduleAssignments})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
    return GestureDetector(
        onPanUpdate: (details) {
          swipeHandler(details, Constants.schedulePageNavNumber, context);
        },
        child: Scaffold(
            bottomNavigationBar:
                const Navbar(selectedIndex: Constants.schedulePageNavNumber),
            appBar: AppBar(
              title: const Text('Schedule'),
              automaticallyImplyLeading: false,
              elevation: 2,
              shadowColor: Theme.of(context).shadowColor,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
                    lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    calendarBuilders: CalendarBuilders(
                      singleMarkerBuilder: (context, date, _) {
                        return Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: date == _selectedDay
                                  ? Colors.transparent
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary), //Change color
                          width: 5.0,
                          height: 5.0,
                          margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        );
                      },
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      HapticFeedback.lightImpact();
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
                      child: widget.scheduleAssignments
                              //TODO: if day generated is with assignments it does not show, maybe change to _focusDay and it will work.
                              .doesDayHaveAssignment(_selectedDay)
                          ? ListView.builder(
                              itemCount: widget.scheduleAssignments.list.length,
                              itemBuilder: (context, index) {
                                final assignment =
                                    widget.scheduleAssignments.list[index];
                                if (isSameDay(
                                    _selectedDay, assignment.dateAsDateTime)) {
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
                            )
                          : SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.asset("assets/noData.png"))),
                ],
              ),
            )));
  }
}
