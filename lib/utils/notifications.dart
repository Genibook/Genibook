// import 'package:genibook/models/grades_class.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:genibook/models/student_class.dart';
import 'package:genibook/services/notification_service.dart';

/// Sending a notification with a given student object that tells that user what grade changed
Future<void> sendBGTaskNotification(
    Student newStudent, Student oldStudent) async {
  // Grades newGrades = newStudent.grades;
  // Grades oldGrades = oldStudent.grades;

  // if (newGrades == oldGrades) {
  //   return;
  // }

  await NotificationService.showNotification(
    title: "${Emojis.animals_cat} Your grades changed, take a look!",
    body: "Body of the notification",
  );
}
