import 'dart:core';

import 'package:table_calendar/table_calendar.dart';

class ScheduleAssignment {
  final String courseName;
  final String date;
  final String points;
  final String category;
  final String assignment;
  final String description;

  const ScheduleAssignment({
    required this.courseName,
    required this.date,
    required this.points,
    required this.category,
    required this.assignment,
    required this.description,
  });

  factory ScheduleAssignment.fromJson(Map<String, dynamic> json) {
    return ScheduleAssignment(
        date: json["date"],
        courseName: json["course_name"],
        points: json["points"],
        category: json["category"],
        assignment: json["assignment"],
        description: json["description"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "category": category,
      "assignment": assignment,
      "description": description,
      "course_name": courseName,
      "points": points,
    };
  }

  DateTime get dateAsDateTime {
    DateTime now = DateTime.now();
    DateTime datee = DateTime(
        now.year, int.parse(date.split("/")[0]), int.parse(date.split("/")[1]));
    return datee;
  }
}

class ScheduleAssignmentsList {
  final List<ScheduleAssignment> scheduleAssignments;

  const ScheduleAssignmentsList({required this.scheduleAssignments});

  factory ScheduleAssignmentsList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonList = json['scheduleAssignments'];
    final List<ScheduleAssignment> scheduleAssignments = jsonList
        .map((dynamic item) =>
            ScheduleAssignment.fromJson(item as Map<String, dynamic>))
        .toList();
    return ScheduleAssignmentsList(scheduleAssignments: scheduleAssignments);
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> scheduleAssignmentsJsonList =
        scheduleAssignments.map((assignment) => assignment.toJson()).toList();
    return {'scheduleAssignments': scheduleAssignmentsJsonList};
  }

  List<ScheduleAssignment> get list {
    return scheduleAssignments;
  }

  bool doesDayHaveAssignment(DateTime? selectedDay) {
    for (ScheduleAssignment assignment in scheduleAssignments) {
      if (isSameDay(assignment.dateAsDateTime, selectedDay)) {
        return true;
      }
    }
    return false;
  }
}
