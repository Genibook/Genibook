import 'package:flutter/foundation.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:genibook/models/student_class.dart';

class ApiHandler {
  ApiHandler._();

  static Future<Map<String, dynamic>> loadData(String ending) async {
    final response = await http.get(getCorrectUri(ending));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      if (kDebugMode) {
        print("failed to load data");
      }
      return {};
    }
  }

  static Future<Student> getNewStudent(Student currentStudent) async {
    Map<String, dynamic> json = await loadData("/apiv1/student");
    if (json.isEmpty) {
      if (kDebugMode) {
        print("json is empty");
      }
      return currentStudent;
    } else {
      Student apiStudent = Student.fromJson(json);
      if (apiStudent == currentStudent) {
        return currentStudent;
      } else {
        StoreObjects.storeStudent(apiStudent);
        return apiStudent;
      }
    }
  }
}
