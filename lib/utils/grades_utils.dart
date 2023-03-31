import 'dart:math';
import 'package:flutter/material.dart';

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

MaterialColor getColorFromGrade(dynamic grade) {
  try {
    if (grade != "No Grades" && grade != "No Grades") {
      grade = double.parse(grade);
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
    } else {
      return Colors.blue;
    }
  } catch (e) {
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
