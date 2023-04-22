import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/models/assignments_class.dart';
import 'package:genibook/utils/grades_utils.dart';
import 'package:flutter/services.dart';
import 'package:genibook/widgets/deatiled_assignment.dart';

class AssignmentPage extends StatelessWidget {
  final List<Assignment> assignmentsForAClass;

  const AssignmentPage({super.key, required this.assignmentsForAClass});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      if (Constants.debugModePrintEVERYTHING) {
        for (Assignment ass in assignmentsForAClass) {
          print("[DEBUG BUILD: assignmentpage]: ${ass.toJson()}");
        }
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Assignments'),
        ),
        body: assignmentsForAClass.isEmpty
            ? const Center(
                child: Text('No assignments found. :/'),
              )
            : SafeArea(
                child: ListView.builder(
                  itemCount: assignmentsForAClass.length,
                  itemBuilder: (BuildContext context, int index) {
                    Assignment assignment = assignmentsForAClass[index];
                    return GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          showDetailedAssignmentView(context, assignment);
                        },
                        child: Card(
                          margin: const EdgeInsets.all(16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  assignment.assignment,
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "${assignment.dayName} - ${assignment.date} - MP ${assignment.mp}"),
                                const SizedBox(height: 16.0),
                                Text(
                                  'Category: ${assignment.category}',
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  'Description: ${assignment.description}',
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Grade:',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    gradeNumThenPercentForAssignments(
                                        assignment),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ));
  }
}
