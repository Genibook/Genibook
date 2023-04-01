import 'package:flutter/material.dart';
import 'package:genibook/models/assignments_class.dart';

void showDetailedAssignmentView(BuildContext context, Assignment assignment) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Assignment Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Course Name: ${assignment.assignmentName}'),
              Text('MP: ${assignment.mp}'),
              Text('Day Name: ${assignment.dayName}'),
              Text('Full Day Name: ${assignment.fullDayName}'),
              Text('Date: ${assignment.date}'),
              Text('Full Date: ${assignment.fullDate}'),
              Text('Teacher: ${assignment.teacher}'),
              Text('Category: ${assignment.category}'),
              Text('Assignment: ${assignment.assignment}'),
              Text('Description: ${assignment.description}'),
              Text('Grade Percent: ${assignment.gradePercent}'),
              Text('Grade Num: ${assignment.gradeNum}'),
              Text('Comment: ${assignment.comment}'),
              Text('Prev: ${assignment.prev}'),
              Text('Docs: ${assignment.docs}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
