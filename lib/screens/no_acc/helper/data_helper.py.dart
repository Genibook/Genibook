import 'package:flutter/material.dart';
import 'package:genibook/screens/no_acc/model/lesson.dart';

class DataHelper {
  static List<Lesson> allAddedLessons = [];

  static addLesson(Lesson lesson) {
    allAddedLessons.add(lesson);
  }

  static double calculateAvg() {
    double sumOfGrade = 0;
    double sumOfCredit = 0;

    for (Lesson element in allAddedLessons) {
      sumOfGrade = sumOfGrade + (element.creditGrade * element.letterGrade);
      sumOfCredit += element.creditGrade;
    }

    return sumOfGrade / sumOfCredit;
  }

  static List<String> _gradeLetters() {
    return ["AA", "BA", "BB", "CB", "CC", "DC", "DD", "FD", "FF"];
  }

  static double _convertLetterToValue(String letter) {
    switch (letter) {
      case "AA":
        return 4;
      case "BA":
        return 3.5;
      case "BB":
        return 3.0;
      case "CB":
        return 2.5;
      case "CC":
        return 2.0;
      case "DC":
        return 1.5;
      case "DD":
        return 1.0;
      case "FD":
        return 0.5;
      case "FF":
        return 0.0;
      default:
        return 1;
    }
  }

  static List<DropdownMenuItem<double>> allGradeLetters() {
    return _gradeLetters()
        .map((e) => DropdownMenuItem(
              child: Text(e),
              value: _convertLetterToValue(e),
            ))
        .toList();
  }

  static List<int> _allCredits() {
    return List.generate(10, (index) => index + 1).toList();
  }

  static List<DropdownMenuItem<double>> allClassesOfCredits() {
    return _allCredits()
        .map((e) => DropdownMenuItem(
              value: e.toDouble(),
              child: Text(e.toString()),
            ))
        .toList();
  }
}
