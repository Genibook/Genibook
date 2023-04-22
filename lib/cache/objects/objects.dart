import 'package:flutter/foundation.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/models/schedule_class.dart';
import 'package:genibook/models/secret.dart';
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
    String jsonString = await storage.read(key: "student") ?? "";
    if (jsonString.isNotEmpty) {
      Map<String, dynamic> jsonn = json.decode(jsonString);
      return Student.fromJson(jsonn);
    } else {
      return eddie;
    }
  }

  static Future<void> storeSecret(Secret secret) async {
    String stringJson = jsonEncode(secret.toJson());
    await storage.write(key: "secret", value: stringJson);
  }

  static Future<Secret> readSecret() async {
    String jsonString = await storage.read(key: "secret") ?? "";
    if (kDebugMode) {
      print(jsonString);
    }
    if (jsonString.isNotEmpty) {
      Map<String, dynamic> jsonn = json.decode(jsonString);
      return Secret.fromJson(jsonn);
    } else {
      return Secret.fromJson(emptySecretDict);
    }
  }

  static Future<void> storeSchedule(ScheduleAssignmentsList schedule) async {
    String stringJson = jsonEncode(schedule.toJson());
    await storage.write(key: "schedule", value: stringJson);
  }

  static Future<ScheduleAssignmentsList> readSchedule() async {
    String jsonString = await storage.read(key: "schedule") ?? "";
    if (kDebugMode) {
      print(jsonString);
    }
    if (jsonString.isNotEmpty) {
      Map<String, dynamic> jsonn = json.decode(jsonString);
      return ScheduleAssignmentsList.fromJson(jsonn);
    } else {
      return scheduleAssignments;
    }
  }
  //TODO: create logout function and schedule

  //static Future<void> storeSecrets() async{
  //}
}
