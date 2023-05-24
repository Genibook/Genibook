// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:genipaws/constants.dart';

class Grades {
  Map<String, Grade> gradesMap;

  Grades({required this.gradesMap});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    gradesMap.forEach((key, value) {
      json[key] = value.toJson();
    });
    return json;
  }

  factory Grades.fromJson(Map<String, dynamic> json) {
    Map<String, Grade> gradesMap = {};
    json.forEach((key, value) {
      gradesMap[key] = Grade.fromJson(value);
    });
    return Grades(gradesMap: gradesMap);
  }

  int get length => gradesMap.length;
  Iterable<String> get keys {
    return gradesMap.keys;
  }

  double getSubjectGrade(String subject) {
    Grade grade = gradesMap[subject] ??
        Grade.fromJson(
          {
            'grade': 85.0,
            'teacher_name': 'John Smith',
            'teacher_email': 'john.smith@example.com'
          },
        );
    return grade.grade;
  }

  String getSubjectTeacherName(String subject) {
    Grade grade = gradesMap[subject] ??
        Grade.fromJson(
          {
            'grade': 85.0,
            'teacher_name': 'John Smith',
            'teacher_email': 'john.smith@example.com'
          },
        );
    return grade.teacherName;
  }

  String getSubjectTeacherEmail(String subject) {
    Grade grade = gradesMap[subject] ??
        Grade.fromJson(
          {
            'grade': 85.0,
            'teacher_name': 'John Smith',
            'teacher_email': 'john.smith@example.com'
          },
        );
    return grade.teacherEmail;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (kDebugMode) {
      print("[DEBUG] Operator == for Grades class was called");
      print("[DEBUG] is other grades?: ${other is Grades}");
    }

    return other is Grades &&
        const DeepCollectionEquality().equals(gradesMap, other.gradesMap);
  }

  @override
  int get hashCode => gradesMap.hashCode;
}

class Grade {
  double grade;
  String teacherName;
  String teacherEmail;

  Grade({
    required this.grade,
    required this.teacherName,
    required this.teacherEmail,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      if (Constants.debugModePrintEVERYTHING) {
        print("[DEBUG: Grade.fromJson()]: $json");
      }
    }
    double gradee;
    if (json["grade"].runtimeType == double) {
      gradee = json["grade"];
    } else {
      gradee = double.parse(json["grade"]);
    }
    return Grade(
      grade: gradee,
      teacherName: json['teacher_name'],
      teacherEmail: json['teacher_email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grade'] = grade;
    data['teacher_name'] = teacherName;
    data['teacher_email'] = teacherEmail;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Grade &&
          runtimeType == other.runtimeType &&
          grade == other.grade &&
          teacherName == other.teacherName &&
          teacherEmail == other.teacherEmail;

  @override
  int get hashCode =>
      grade.hashCode ^ teacherName.hashCode ^ teacherEmail.hashCode;
}


// final grades = Grades.fromJson({
//   'Math': {
//     'grade': 85.0,
//     'teacher_name': 'John Smith',
//     'teacher_email': 'john.smith@example.com'
//   },
//   'English': {
//     'grade': 92.0,
//     'teacher_name': 'Jane Doe',
//     'teacher_email': 'jane.doe@example.com'
//   },
//   'Science': {
//     'grade': 78.0,
//     'teacher_name': 'Bob Johnson',
//     'teacher_email': 'bob.johnson@example.com'
//   },
// });

// // Accessing grades for a subject
// final mathGrades = grades.getSubjectGrades('Math'); // returns {'grade': 85.0, 'teacher_name': 'John Smith', 'teacher_email': 'john.smith@example.com'}
// final mathGrade = grades.getSubjectGrade('Math'); // returns 85.0
// final mathTeacherName = grades.getSubjectTeacherName('Math'); // returns 'John Smith'
// final mathTeacherEmail = grades.getSubjectTeacherEmail('Math'); // returns 'john.smith@example.com'
