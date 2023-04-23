import 'package:flutter/material.dart';
// import 'package:genibook/models/student_class.dart';
// import 'package:genibook/models/grades_class.dart';

void showGradesSettingsView(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Grade Settings",
          style: Theme.of(context).textTheme.headline5,
        ),

        // content: SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Text(
        //         assignment.category,
        //         style:
        //             const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        //       ),
        //       const SizedBox(height: 6),
        //       Text(assignment.teacher),
        //       Text(
        //           '${assignment.fullDayName} - ${assignment.fullDate} - MP ${assignment.mp}'),
        //       const SizedBox(height: 10),
        //       Text('Description: ${assignment.description}'),
        //       const SizedBox(height: 6),
        //       Text('Comment: ${assignment.comment}'),
        //       const SizedBox(height: 6),
        //       Text(
        //         'Grade: ${assignment.gradePercent} (${assignment.gradeNum})',
        //         style: const TextStyle(fontSize: 17),
        //       ),
        //     ],
        //   ),
        // ),

        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
