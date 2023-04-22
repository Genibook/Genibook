import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/models/assignments_class.dart';

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

MaterialColor getColorFromGrade(double grade) {
  if (grade >= 90) {
    return Colors.green;
  } else if ((90 > grade) && (grade >= 80)) {
    return Colors.yellow;
  } else if ((80 > grade) && (grade >= 70)) {
    return Colors.amber;
  } else if ((70 > grade) && (grade >= 60)) {
    return Colors.orange;
  } else if ((60 > grade) && (grade >= 50)) {
    return Colors.deepOrange;
  } else if (50 > grade && grade != 0.0) {
    return Colors.red;
  } else if (grade == -1) {
    return Colors.red;
  } else {
    return Colors.blue;
  }
}

MaterialColor getColorFromGradeAssignment(
    String gradePercent, String gradeNum) {
  double grade;
  if (gradeNum.contains("Not") || gradeNum.split("/")[1] == "0") {
    return Colors.blue;
  } else {
    grade = double.parse(gradePercent);
    if (grade >= 90) {
      return Colors.green;
    } else if ((90 > grade) && (grade >= 80)) {
      return Colors.yellow;
    } else if ((80 > grade) && (grade >= 70)) {
      return Colors.amber;
    } else if ((70 > grade) && (grade >= 60)) {
      return Colors.orange;
    } else if ((60 > grade) && (grade >= 50)) {
      return Colors.deepOrange;
    } else if (50 > grade && grade != 0.0) {
      return Colors.red;
    } else if (grade == -1) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }
}

Widget gradeNumThenPercentForAssignments(Assignment assignment) {
  String ending = "%";
  if (kDebugMode) {
    if (Constants.debugModePrintEVERYTHING) {
      print("${assignment.gradeNum} - ${assignment.gradePercent}");
    }
  }
  if (assignment.gradeNum.contains("Not")) {
    ending = "pts";
    //todo
    /*
flutter: 5/5 - 100.0
flutter: 5/5 - 100.0
flutter: 5/5 - 100.0
flutter: 5/5 - 100.0
flutter: 5/5 - 100.0
flutter: Absent  - Assignment Pts: 5

phsyed marking 2
    */
  } else if (assignment.gradeNum.split("/")[1] == "0" ||
      assignment.gradePercent.isEmpty) {
    ending = "Extra Points";
  }
  return Text(
    '${assignment.gradeNum} (${assignment.gradePercent}$ending)',
    style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: getColorFromGradeAssignment(
            assignment.gradePercent, assignment.gradeNum)),
  );
}
// } catch (e) {
//   if (grade >= 90) {
//     return Colors.green;
//   } else if ((90 > grade) && (grade >= 80)) {
//     return Colors.yellow;
//   } else if ((80 > grade) && (grade >= 70)) {
//     return Colors.amber;
//   } else if ((70 > grade) && (grade >= 60)) {
//     return Colors.orange;
//   } else if ((60 > grade) && (grade >= 50)) {
//     return Colors.deepOrange;
//   } else if (50 > grade && grade != 0.0) {
//     return Colors.red;
//   } else if (grade == -1) {
//     return Colors.red;
//   } else {
//     return Colors.blue;
//   }
// }
