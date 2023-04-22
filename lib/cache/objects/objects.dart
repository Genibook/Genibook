import 'package:genibook/api/rawdata.dart';
import 'package:genibook/models/schedule_class.dart';
import 'package:genibook/models/student_class.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

class StoreObjects {
  StoreObjects._();

  static Future<void> storeStudent(Student student) async {
    String stringJson = jsonEncode(student.toJson());
    await storage.write(key: "student", value: stringJson);
  }

  static Future<Student> readStudent() async {
    String jsonString = await storage.read(key: "student") ?? "{}";
    if (jsonString.isNotEmpty) {
      Map<String, dynamic> jsonn = json.decode(jsonString);
      return Student.fromJson(jsonn);
    } else {
      return eddie;
    }
  }

  static Future<void> storeSchedules(ScheduleAssignmentsList schedule) async {
    String stringJson = jsonEncode(schedule.toJson());
    await storage.write(key: "schedule", value: stringJson);
  }

  //static Future<void> storeSecrets() async{
  //}
}
