import 'package:flutter/material.dart';
import 'package:genibook/models/gpas.dart';

void showDetailedGradePageView(
    BuildContext context, Gpa? studentGpa, String? selectedMp) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Grade Info",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Selected MP: $selectedMp",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(),
              Text(
                "Weighted Percent GPA: ${studentGpa?.weighted} ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Unweighted Percent GPA: ${studentGpa?.unweighted} ",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            //TODO: add learn more button to talk about how we calculate the gpa and stuff
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
