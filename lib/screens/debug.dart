import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/api/rawdata.dart';
import 'package:genibook/cache/login/tos.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/models/assignments_class.dart';
import 'package:genibook/models/grades_class.dart';
import 'package:genibook/api/swipes.dart';
import 'package:genibook/models/secret.dart';
import 'package:genibook/models/student_class.dart';
import 'package:genibook/screens/login.dart';
import 'package:genibook/secrets.dart';
import 'package:workmanager/workmanager.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

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
              style: Theme.of(context).textTheme.headline3,
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
              style: Theme.of(context).textTheme.headline3,
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
              style: Theme.of(context).textTheme.headline3,
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
              style: Theme.of(context).textTheme.headline3,
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
              style: Theme.of(context).textTheme.headline5,
            ),
            ElevatedButton(
              child: const Text("Start the Flutter background service"),
              onPressed: () {
                Workmanager().initialize(
                  callbackDispatcher,
                  isInDebugMode: true,
                );
              },
            ),
            const SizedBox(height: 16),

            //This task runs once.
            //Most likely this will trigger immediately
            ElevatedButton(
              child: const Text("Register OneOff Task"),
              onPressed: () {
                Workmanager().registerOneOffTask(
                  simpleTaskKey,
                  simpleTaskKey,
                  inputData: <String, dynamic>{
                    'int': 1,
                    'bool': true,
                    'double': 1.0,
                    'string': 'string',
                    'array': [1, 2, 3],
                  },
                );
              },
            ),
            ElevatedButton(
              child: const Text("Register rescheduled Task"),
              onPressed: () {
                Workmanager().registerOneOffTask(
                  rescheduledTaskKey,
                  rescheduledTaskKey,
                  inputData: <String, dynamic>{
                    'key': Random().nextInt(64000),
                  },
                );
              },
            ),
            ElevatedButton(
              child: const Text("Register failed Task"),
              onPressed: () {
                Workmanager().registerOneOffTask(
                  failedTaskKey,
                  failedTaskKey,
                );
              },
            ),
            //This task runs once
            //This wait at least 10 seconds before running
            ElevatedButton(
                child: const Text("Register Delayed OneOff Task"),
                onPressed: () {
                  Workmanager().registerOneOffTask(
                    simpleDelayedTask,
                    simpleDelayedTask,
                    initialDelay: const Duration(seconds: 10),
                  );
                }),
            const SizedBox(height: 8),
            //This task runs periodically
            //It will wait at least 10 seconds before its first launch
            //Since we have not provided a frequency it will be the default 15 minutes
            ElevatedButton(
                onPressed: Platform.isAndroid
                    ? () {
                        Workmanager().registerPeriodicTask(
                          simplePeriodicTask,
                          simplePeriodicTask,
                          initialDelay: const Duration(seconds: 10),
                        );
                      }
                    : null,
                child: const Text("Register Periodic Task (Android)")),
            //This task runs periodically
            //It will run about every hour
            ElevatedButton(
                onPressed: Platform.isAndroid
                    ? () {
                        Workmanager().registerPeriodicTask(
                          simplePeriodicTask,
                          simplePeriodic1HourTask,
                          frequency: const Duration(hours: 1),
                        );
                      }
                    : null,
                child: const Text("Register 1 hour Periodic Task (Android)")),
            const SizedBox(height: 16),
            Text(
              "Task cancellation",
              style: Theme.of(context).textTheme.headline5,
            ),
            ElevatedButton(
              child: const Text("Cancel All"),
              onPressed: () async {
                await Workmanager().cancelAll();
                if (kDebugMode) {
                  print('Cancel all tasks completed');
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("asdhfjadsfadsf");
    switch (task) {
      case simpleTaskKey:
        if (kDebugMode) {
          print("$simpleTaskKey was executed. inputData = $inputData");
        }
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("test", true);
        if (kDebugMode) {
          print("Bool from prefs: ${prefs.getBool("test")}");
        }
        break;
      case rescheduledTaskKey:
        final key = inputData!['key']!;
        final prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey('unique-$key')) {
          if (kDebugMode) {
            print('has been running before, task is successful');
          }
          return true;
        } else {
          await prefs.setBool('unique-$key', true);
          if (kDebugMode) {
            print('reschedule task');
          }
          return false;
        }
      case failedTaskKey:
        if (kDebugMode) {
          print('failed task');
        }
        return Future.error('failed');
      case simpleDelayedTask:
        if (kDebugMode) {
          print("$simpleDelayedTask was executed");
        }
        break;
      case simplePeriodicTask:
        if (kDebugMode) {
          print("$simplePeriodicTask was executed");
        }
        break;
      case simplePeriodic1HourTask:
        if (kDebugMode) {
          print("$simplePeriodic1HourTask was executed");
        }
        break;
      case Workmanager.iOSBackgroundTask:
        if (kDebugMode) {
          print("The iOS background fetch was triggered");
        }
        // Directory? tempDir = await getTemporaryDirectory();
        // String? tempPath = tempDir.path;
        // print(
        //     "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
        break;
    }

    return Future.value(true);
  });
}
