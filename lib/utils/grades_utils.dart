import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  if (!gradeNum.contains("/")) {
    if (gradeNum.contains("Exempt") || gradeNum.contains("Absent")) {
      return Colors.blue;
    } else if (gradeNum.contains("Missing") ||
        gradeNum.contains("Incomplete")) {
      return Colors.red;
    }
    return Colors.blue;
  }
  if (gradeNum.split("/")[1] == "0") {
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
      print("${!assignment.gradeNum.contains("/")}");
    }
  }
  if (!assignment.gradeNum.contains("/")) {
    ending = "pts";
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

List<DropdownMenuItem<String>> generateAvailableStudentsDropDown(
    Map<String, List<dynamic>> input, BuildContext context) {
  List<DropdownMenuItem<String>> ret = [];
  input.forEach((key, value) {
    ret.add(DropdownMenuItem(
        value: key,
        child: Text("${value[0]}-${value[1]}",
            style: const TextStyle(fontSize: 15))));
  });

  return ret;
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
