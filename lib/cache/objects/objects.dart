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
      if (kDebugMode) {
        print("[DEBUG: readStudent()->objects.dart]: $json");
      }
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
      print("[DEBUG] READ SECRET:");
      print(jsonString);
    }
    if (jsonString.isNotEmpty) {
      Map<String, dynamic> jsonn = json.decode(jsonString);
      return Secret.fromJson(jsonn);
    } else {
      if (kDebugMode) {
        print("[DEBUG] READ SECRET: EMPTY SECRET STRING?");
      }

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
      print("[DEBUG] READ SCHEDULE:");
      print(jsonString);
    }
    if (jsonString.isNotEmpty) {
      Map<String, dynamic> jsonn = json.decode(jsonString);
      return ScheduleAssignmentsList.fromJson(jsonn);
    } else {
      return scheduleAssignments;
    }
  }

  static Future<void> logout() async {
    await storage.delete(key: "secret");
    await storage.delete(key: "schedule");
    await storage.delete(key: "student");
  }

  //static Future<void> storeSecrets() async{
  //}
}
