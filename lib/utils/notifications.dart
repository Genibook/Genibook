import 'package:genibook/models/grades_class.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:genibook/models/student_class.dart';
import 'package:genibook/services/notification_service.dart';

/// Sending a notification with a given student object that tells that user what grade changed
Future<void> sendBGTaskNotification(
    Student newStudent, Student oldStudent) async {
  Grades newGrades = newStudent.grades;
  Grades oldGrades = oldStudent.grades;

  if (newGrades == oldGrades) {
    return;
  }

  String body = "";
  List<Map<String, Grade>> diffs = Grades.getDifferences(newGrades, oldGrades);
  for (Map<String, Grade> diff in diffs) {
    String className = diff.keys.elementAt(1);
    Grade newGrade = diff.values.elementAt(1);
    Grade oldGrade = diff.values.elementAt(0);

    body +=
        "${Emojis.clothing_graduation_cap} $className: ${oldGrade.grade} -> ${newGrade.grade}\n";
  }

  await NotificationService.showNotification(
    title: "${Emojis.animals_cat} Your grades changed!",
    body: body,
  );
}
