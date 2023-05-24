//Assignments assignments = Assignments.fromJson(assignmentsJson);
// String assignmentsJsonString = jsonEncode(assignments.toJson());

import 'package:flutter/foundation.dart';
import 'package:genipaws/constants.dart';

class Assignments {
  Map<String, List<Assignment>> assignments;

  Assignments(this.assignments);

  factory Assignments.fromJson(Map<String, dynamic> json) {
    Map<String, List<Assignment>> data = {};
    json.forEach((key, value) {
      List<Assignment> assignments = [];
      for (var assignment in value) {
        assignments.add(Assignment.fromJson(assignment));
      }
      data[key] = assignments;
    });
    return Assignments(data);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    assignments.forEach((key, value) {
      json[key] = value.map((assignment) => assignment.toJson()).toList();
    });
    return json;
  }

  List<Assignment> operator [](String key) {
    return assignments[key] ?? [Assignment.fromJson({})];
  }

  bool isEmptyForAClass(String key) {
    return assignments[key]!.isEmpty;
  }

  int get length => assignments.length;

  bool get isEmptyDict => assignments.isEmpty;

  bool get isNotEmpty => assignments.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Assignments && mapEquals(assignments, other.assignments);

  @override
  int get hashCode => mapHashCode(assignments);

  static int mapHashCode(Map<String, List<Assignment>> map) {
    return map.values.map((v) => mapListHashCode(v)).reduce((a, b) => a ^ b);
  }

  static int mapListHashCode(List<dynamic> list) {
    return list.map((v) => v.hashCode).reduce((a, b) => a ^ b);
  }

  static bool mapEquals(
      Map<String, List<Assignment>> map1, Map<String, List<Assignment>> map2) {
    if (identical(map1, map2)) {
      if (kDebugMode) {
        print("identitcal");
      }
      return true;
    }
    if (map1.length != map2.length) {
      if (kDebugMode) {
        print("diff lengths");
      }
      return false;
    }
    for (final key in map1.keys) {
      if (!map2.containsKey(key)) {
        if (kDebugMode) {
          print(
              "[DEBUG mapEquals] map 2 IN THE COMPARISON no key, RETURNING FALSE");
        }

        return false;
      }
      if (map1[key] is List<Assignment> && map2[key] is List<Assignment>) {
        if (!listEquals(map1[key], map2[key])) {
          if (kDebugMode) {
            print("assignment list not equal");
          }
          return false;
        }
      } else if (map1[key] != map2[key]) {
        if (kDebugMode) {
          print("assignment list not equal second if statement");
        }
        return false;
      }
    }
    return true;
  }
}

class Assignment {
  String courseName;
  String mp;
  String dayName;
  String fullDayName;
  String date;
  String fullDate;
  String teacher;
  String category;
  String assignment;
  String description;
  String gradePercent;
  String gradeNum;
  String comment;
  String prev;
  String docs;

  Assignment({
    required this.courseName,
    required this.mp,
    required this.dayName,
    required this.fullDayName,
    required this.date,
    required this.fullDate,
    required this.teacher,
    required this.category,
    required this.assignment,
    required this.description,
    required this.gradePercent,
    required this.gradeNum,
    required this.comment,
    required this.prev,
    required this.docs,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    String percent = json['grade_percent'];
    percent = percent.replaceAll(RegExp(r'%'), "");
    if (kDebugMode) {
      if (Constants.debugModePrintEVERYTHING) {
        print("[DEBUG: Assignment.fromJson()]: $json");
        print("[DEBUG: Assignment.fromJson()]: $percent");
      }
    }
    return Assignment(
      courseName: json['course_name'],
      mp: json['mp'],
      dayName: json['dayname'],
      fullDayName: json['full_dayname'],
      date: json['date'],
      fullDate: json['full_date'],
      teacher: json['teacher'],
      category: json['category'],
      assignment: json['assignment'],
      description: json['description'],
      gradePercent: percent,
      gradeNum: json['grade_num'],
      comment: json['comment'],
      prev: json['prev'],
      docs: json['docs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_name': courseName,
      'mp': mp,
      'dayname': dayName,
      'full_dayname': fullDayName,
      'date': date,
      'full_date': fullDate,
      'teacher': teacher,
      'category': category,
      'assignment': assignment,
      'description': description,
      'grade_percent': gradePercent,
      'grade_num': gradeNum,
      'comment': comment,
      'prev': prev,
      'docs': docs,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Assignment &&
          courseName == other.courseName &&
          mp == other.mp &&
          dayName == other.dayName &&
          fullDayName == other.fullDayName &&
          date == other.date &&
          fullDate == other.fullDate &&
          teacher == other.teacher &&
          category == other.category &&
          assignment == other.assignment &&
          description == other.description &&
          gradePercent == other.gradePercent &&
          gradeNum == other.gradeNum &&
          comment == other.comment &&
          prev == other.prev &&
          docs == other.docs;

  @override
  int get hashCode =>
      courseName.hashCode ^
      mp.hashCode ^
      dayName.hashCode ^
      fullDayName.hashCode ^
      date.hashCode ^
      fullDate.hashCode ^
      teacher.hashCode ^
      category.hashCode ^
      assignment.hashCode ^
      description.hashCode ^
      gradePercent.hashCode ^
      gradeNum.hashCode ^
      comment.hashCode ^
      prev.hashCode ^
      docs.hashCode;
}
