import 'package:flutter/foundation.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/models/gpas.dart';
import 'package:genibook/models/schedule_class.dart';
import 'package:genibook/models/secret.dart';
import 'package:genibook/models/student_class.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StoreObjects {
  StoreObjects._();

  static Future<void> storeStudent(Student student) async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String stringJson = jsonEncode(student.toJson());
    await storage.write(key: "student", value: stringJson);
  }

  static Future<Student> readStudent() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    // print("PRINT");
    String jsonString = await storage.read(key: "student") ?? "";
    // print("PRINT");
    if (jsonString.isNotEmpty) {
      if (kDebugMode) {
        if (Constants.debugModePrintEVERYTHING) {
          print("[DEBUG: readStudent()->objects.dart]: $jsonString");
        }
      }
      Map<String, dynamic> jsonn = json.decode(jsonString);
      return Student.fromJson(jsonn);
    } else {
      // print("PRINT");
      return eddie;
    }
  }

  static Future<void> storeSecret(Secret secret) async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String stringJson = jsonEncode(secret.toJson());
    await storage.write(key: "secret", value: stringJson);
  }

  static Future<Secret> readSecret() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String jsonString = await storage.read(key: "secret") ?? "";
    if (kDebugMode) {
      if (Constants.debugModePrintEVERYTHING) {
        print("[DEBUG] READ SECRET: $jsonString");
      }
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
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String stringJson = jsonEncode(schedule.toJson());
    await storage.write(key: "schedule", value: stringJson);
  }

  static Future<ScheduleAssignmentsList> readSchedule() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String jsonString = await storage.read(key: "schedule") ?? "";

    if (kDebugMode) {
      if (Constants.debugModePrintEVERYTHING) {
        print("[DEBUG] READ SCHEDULE: $jsonString)");
      }
    }
    if (jsonString.isNotEmpty) {
      Map<String, dynamic> jsonn = json.decode(jsonString);
      return ScheduleAssignmentsList.fromJson(jsonn);
    } else {
      return scheduleAssignments;
    }
  }

  static Future<void> storeGPAHistory(
      Map<String, Map<String, double>> his) async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String stringJson = jsonEncode(his);
    await storage.write(key: "gpa_his", value: stringJson);
  }

  static Future<Map<String, Map<String, double>>> readGPAhistory() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String jsonString = await storage.read(key: "gpa_his") ?? "";

    if (kDebugMode) {
      if (Constants.debugModePrintEVERYTHING) {
        print("[DEBUG] READ GPAhistory: $jsonString");
      }
    }
    if (jsonString.isNotEmpty) {
      final decodedJson = json.decode(jsonString);
      final resp = decodedJson.map<String, Map<String, double>>((key, value) {
        final nestedMap = (value as Map<String, dynamic>).map<String, double>(
            (nestedKey, nestedValue) =>
                MapEntry(nestedKey, nestedValue.toDouble()));
        return MapEntry(key as String, nestedMap);
      });

      return resp;
    } else {
      return {};
    }
  }

  static Future<void> storeGpa(Gpa gpa) async {
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
    String stringJson = jsonEncode(gpa.toJson());
    await storage.write(key: "gpa_curr", value: stringJson);
  }

  static Future<Gpa> readGpa() async {
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
    String jsonString = await storage.read(key: "gpa_curr") ?? "";

    if (kDebugMode) {
      if (Constants.debugModePrintEVERYTHING) {
        print("[DEBUG] READ GPA: $jsonString)");
      }
    }
    if (jsonString.isNotEmpty) {
      Map<String, dynamic> jsonn = json.decode(jsonString);
      return Gpa.fromJson(jsonn);
    } else {
      return Gpa(unweighted: 0.0, weighted: 0.0);
    }
  }

  static Future<Map<String, String>> readAll() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    Map<String, String> thing = await storage.readAll();
    return thing;
  }

  static Future<void> logout() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    await storage.delete(key: "secret");
    await storage.delete(key: "schedule");
    await storage.delete(key: "student");
    await storage.delete(key: "mps");
    await storage.delete(key: "gpa_his");
    await storage.delete(key: "bg-fetch");
    await storage.delete(key: "gpa_curr");
    await storage.delete(key: "bio_auth");
    await storage.delete(key: "session_bio_auth");
    await storage.delete(key: Constants.tosReadKey);
  }

  //static Future<void> storeSecrets() async{
  //}
}
