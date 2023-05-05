import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/cache/login/tos.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/models/assignments_class.dart';
import 'package:genibook/models/grades_class.dart';
import 'package:genibook/routes/swipes.dart';
import 'package:genibook/models/secret.dart';
import 'package:genibook/models/student_class.dart';
import 'package:genibook/screens/login.dart';
import 'package:genibook/secrets.dart';

const simpleTaskKey = "be.tramckrijte.workmanagerExample.simpleTask";
const rescheduledTaskKey = "be.tramckrijte.workmanagerExample.rescheduledTask";
const failedTaskKey = "be.tramckrijte.workmanagerExample.failedTask";
const simpleDelayedTask = "be.tramckrijte.workmanagerExample.simpleDelayedTask";
const simplePeriodicTask =
    "be.tramckrijte.workmanagerExample.simplePeriodicTask";
const simplePeriodic1HourTask =
    "be.tramckrijte.workmanagerExample.simplePeriodic1HourTask";

void writeMapToFile(Map<String, String> map, String filePath) {
  final file = File(filePath);

  // Convert the map to a string
  final jsonString = json.encode(map);

  // Write the string to the file
  file.writeAsString(jsonString);
}

class DebugScreen extends StatefulWidget {
  const DebugScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DebugScreenState();
  }
}

class _DebugScreenState extends State<DebugScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "API calls",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(SlideToRightPageRoute(child: const LoginPage()));
                },
                child: const Text("RETURN TO LOGIN PAGE TO DEBUG")),
            ElevatedButton(
                onPressed: (() async {
                  Student student = await ApiHandler.getNewStudent(false);
                  if (kDebugMode) {
                    print(student.toJson());
                  }
                }),
                child: const Text("Get STUDENT")),
            ElevatedButton(
                onPressed: (() async {
                  Secret secret = Secret(
                      username: email,
                      password: password,
                      userSelector: "1",
                      mp: "MP1",
                      highSchool: "Montgomery High School");
                  bool valid = await ApiHandler.login(secret);
                  if (kDebugMode) {
                    print(valid);
                  }
                }),
                child: const Text("LOGIN")),
            Text(
              "Caching",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            ElevatedButton(
                onPressed: () async {
                  Map<String, String> thing = await StoreObjects.readAll();
                  if (kDebugMode) {
                    String filePath = 'test_data/data.json';

                    writeMapToFile(thing, filePath);
                  }
                },
                child: const Text("ALL")),
            ElevatedButton(
                onPressed: () async {
                  bool val = await writeTOS();
                  if (kDebugMode) {
                    print("Assigned value to: $val");
                  }
                },
                child: const Text("TOS")),
            Text(
              "Logic",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print(Assignments.fromJson(assignments) ==
                        Assignments.fromJson(assignments2));
                  }
                },
                child: const Text("Assignments ==")),
            ElevatedButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print(Grades.fromJson(grades) == Grades.fromJson(grades2));
                  }
                },
                child: const Text("Grades ==")),
            ElevatedButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print(eddie == baddie);
                  }
                },
                child: const Text("Student ==")),
            ElevatedButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print(scheduleAssignments == scheduleAssignments2);
                  }
                },
                child: const Text("schedule assignments ==")),
            Text(
              "Caching",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            ElevatedButton(
                onPressed: () async {
                  bool val = await writeTOS();
                  if (kDebugMode) {
                    print("Assigned value to: $val");
                  }
                },
                child: const Text("TOS")),
            Text(
              "Plugin initialization",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      )),
    );
  }
}
