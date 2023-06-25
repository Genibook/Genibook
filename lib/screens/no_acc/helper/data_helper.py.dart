import 'package:genibook/screens/no_acc/model/lesson.dart';

class DataHelper {
  static List<Lesson> allAddedLessons = [];

  static addLesson(Lesson lesson) {
    allAddedLessons.add(lesson);
  }

  static List<double> calculateAvg() {
    double sumOfGrade = 0;
    double sumOfCredit = 0;

    double sumOfGradeWeighted = 0;

    for (Lesson element in allAddedLessons) {
      sumOfGrade = sumOfGrade + (element.creditGrade * element.grade);
      sumOfCredit += element.creditGrade;
      if (element.addCredit) {
        sumOfGradeWeighted += (element.grade + 5) * element.creditGrade;
      } else {
        sumOfGradeWeighted += element.grade * element.creditGrade;
      }
    }

    return [sumOfGrade / sumOfCredit, sumOfGradeWeighted / sumOfCredit];
  }
}
