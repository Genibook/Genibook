import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genibook/cache/login/tos.dart';
import 'package:genibook/models/assignments_class.dart';
import 'package:genibook/models/grades_class.dart';
import 'package:genibook/navigator/api_navigator.dart';
import 'package:genibook/navigator/swipes.dart';
import 'package:genibook/screens/login.dart';

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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
            Column(
              children: [
                Text(
                  "API calls",
                  style: Theme.of(context).textTheme.headline3,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          SlideToRightPageRoute(child: const LoginPage()));
                    },
                    child: const Text("RETURN TO LOGIN PAGE TO DEBUG"))
              ],
            ),
            Column(
              children: [
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
                    child: const Text("TOS"))
              ],
            ),
            Column(
              children: [
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
                        print(Grades.fromJson(grades) ==
                            Grades.fromJson(grades2));
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
              ],
            )
          ]))),
    );
  }
}
