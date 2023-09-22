import 'package:flutter/foundation.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/cache/objects/config.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/api/utils.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/models/gpas.dart';
import 'package:genibook/models/schedule_class.dart';
import 'package:genibook/models/secret.dart';
import 'package:genibook/utils/notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

import 'package:genibook/models/student_class.dart';

class ApiHandler {
  ApiHandler._();

  static Future<Map<String, dynamic>> loadData(
      String ending, Map<String, String> data) async {
    final response = await http.post(getCorrectUri(ending, data));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      if (kDebugMode) {
        print("[DEBUG loadData]: failed to get data");
      }
      return {};
    }
  }

  static Future<bool> login(Secret secret) async {
    final response = await http
        .post(getCorrectUri("/${Constants.apiName}/login/", secret.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
        print("[DEBUG login]: failed to login");
      }
      return false;
    }
  }

  static Future<Student> getNewStudent(
      bool getCached, bool isBackgroundTask) async {
    if (kDebugMode) {
      if (Constants.debugModePrintEVERYTHING) {
        print("[DEBUG: getNewStudent()]: calling getNewStudent()");
      }
    }

    /// currentStudent is either [eddie] or the [Student] in the cache
    Student currentStudent = await StoreObjects.readStudent();

    if (currentStudent != eddie && getCached) {
      return currentStudent;
    } else if (getCached) {
      return eddie;
    }
    // secrets are stored before calling this function.
    Secret secret = await StoreObjects.readSecret();
    Map<String, dynamic> json =
        await loadData("/${Constants.apiName}/student/", secret.toJson());
    if (json.isEmpty) {
      if (kDebugMode) {
        print("[DEBUG: getNewStudent()] json is empty");
      }
      return currentStudent;
    } else {
      if (kDebugMode) {
        print("[DEBUG]: getNewStudent() json is NOT empty");
      }
      Student apiStudent = Student.fromJson(json);

      if (apiStudent == currentStudent) {
        return currentStudent;
      } else {
        if (isBackgroundTask) {
          sendBGTaskNotification(apiStudent, currentStudent);
        }

        StoreObjects.storeStudent(apiStudent);
        return apiStudent;
      }
    }
  }

  static Future<ScheduleAssignmentsList> getNewSchedule(bool getCached) async {
    /// it will either be the one [in cache] or [scheduleAssignments] variable in rawdata.dart
    ScheduleAssignmentsList cachedSchedule = await StoreObjects.readSchedule();
    if (getCached && cachedSchedule != scheduleAssignments) {
      return cachedSchedule;
    }
    Secret secret = await StoreObjects.readSecret();
    Map<String, dynamic> json =
        await loadData("/${Constants.apiName}/schedule/", secret.toJson());
    // print(json);
    //print(secret.toJson());

    if (json.isEmpty) {
      if (kDebugMode) {
        if (Constants.debugModePrintEVERYTHING) {
          print("[DEBUG getNewSchedule] json is empty");
        }
      }
      return cachedSchedule;
    } else {
      ScheduleAssignmentsList apiSchedule =
          ScheduleAssignmentsList.fromJson(json);
      if (apiSchedule == cachedSchedule) {
        //   print(cachedSchedule.toJson());
        return cachedSchedule;
      } else {
        StoreObjects.storeSchedule(apiSchedule);

        return apiSchedule;
      }
    }
  }

  static Future<List<dynamic>> getMPs(bool getCached) async {
    List<dynamic> cachedMps = await ConfigCache.readMPs();
    List<dynamic> apiMps = <dynamic>[];
    Secret secret = await StoreObjects.readSecret();

    if (getCached) {
      return cachedMps;
    }

    final response = await http
        .post(getCorrectUri("/${Constants.apiName}/mps/", secret.toJson()));
    if (response.statusCode == 200) {
      List<dynamic> mps = json.decode(response.body);
      apiMps = mps;
    } else {
      if (kDebugMode) {
        print("[DEBUG getMPs]: failed to get mps data");
      }
    }

    if (apiMps.isEmpty) {
      if (kDebugMode) {
        print("[DEBUG getMPs] mps is empty");
      }
      return cachedMps;
    } else {
      if (apiMps == cachedMps) {
        return cachedMps;
      } else {
        ConfigCache.storeMPs(apiMps);
        return apiMps;
      }
    }
  }

  static Future<Map<String, Map<String, double>>> getGPAhistory(
      bool getCached) async {
    Map<String, Map<String, double>> cachedHis =
        await StoreObjects.readGPAhistory();

    if (Constants.fakeGrades) {
      return {
        "2020 - 21": {"unweighted": 90, "weighted": 93},
        "2021 - 22": {"unweighted": 96, "weighted": 98},
        "Current": {"unweighted": 98.90, "weighted": 101.2}
      };
    }

    if (getCached) {
      return cachedHis;
    }

    Map<String, Map<String, double>> ret = {};
    Secret secret = await StoreObjects.readSecret();

    Map<String, String> map = secret.toJson();
    if ((map["mp"] ?? "") == "MP1") {
      map["mp"] = "MP1";
    } else if ((map["mp"] ?? "") == "MP2") {
      map["mp"] = "FG";
    }

    final response =
        await http.post(getCorrectUri("/${Constants.apiName}/gpas_his/", map));
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);

      final resp = decodedJson.map<String, Map<String, double>>((key, value) {
        final nestedMap = (value as Map<String, dynamic>).map<String, double>(
            (nestedKey, nestedValue) =>
                MapEntry(nestedKey, nestedValue.toDouble()));
        return MapEntry(key as String, nestedMap);
      });

      ret = resp;
    } else {
      if (kDebugMode) {
        print("[DEBUG getGPAhistory]: failed to get gpa history data");
      }
    }

    if (ret.isEmpty) {
      if (kDebugMode) {
        print("[DEBUG getGPAhistory] gpa history data is empty");
      }
      return cachedHis;
    } else {
      StoreObjects.storeGPAHistory(ret);

      return ret;
    }
  }

  static Future<Map<String, List<dynamic>>> getAvailableStudents() async {
    Map<String, List<dynamic>> ret = {};
    List<dynamic> grades = [];
    List<dynamic> ids = [];

    Secret secret = await StoreObjects.readSecret();
    Map<String, String> map = secret.toJson();
    var response = await http
        .post(getCorrectUri("/${Constants.apiName}/grade_of_students/", map));
    if (response.statusCode == 200) {
      grades = json.decode(response.body);
    } else {
      if (kDebugMode) {
        print(
            "[DEBUG getAvailableStudents]: failed to get (/${Constants.apiName}/grade_of_students/) data");
      }
    }

    response =
        await http.post(getCorrectUri("/${Constants.apiName}/ids/", map));
    if (response.statusCode == 200) {
      ids = json.decode(response.body);
    } else {
      if (kDebugMode) {
        print(
            "[DEBUG getAvailableStudents]: failed to get (/${Constants.apiName}/ids/) data");
      }
    }

    for (int i = 0; i < grades.length; i++) {
      ret["${i + 1}"] = [];
      ret["${i + 1}"]?.add(ids[i]);
      ret["${i + 1}"]?.add(grades[i]);
    }

    return ret;
  }

  static Future<Gpa> getGpa(bool getCached) async {
    Gpa cachedGpa = await StoreObjects.readGpa();

    Secret secret = await StoreObjects.readSecret();

    if (getCached) {
      return cachedGpa;
    }

    Map<String, dynamic> jsonString =
        await loadData("/${Constants.apiName}/gpas/", secret.toJson());

    if (jsonString.isEmpty) {
      if (kDebugMode) {
        print("[DEBUG getGpas] GPAs are empty");
      }
      return cachedGpa;
    } else {
      Gpa apiGpa = Gpa.fromJson(jsonString);
      if (apiGpa == cachedGpa) {
        return cachedGpa;
      } else {
        StoreObjects.storeGpa(apiGpa);
        return apiGpa;
      }
    }
  }

  static Future<int> getLatencyThroughLogin() async {
    Secret secret = await StoreObjects.readSecret();

    final startTime = DateTime.now();

    await http
        .post(getCorrectUri("/${Constants.apiName}/login/", secret.toJson()));

    final endTime = DateTime.now();
    final latency = endTime.difference(startTime).inMilliseconds;

    return latency;
  }
}
