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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Selected MP:",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text("$selectedMp")
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Weighted GPA:",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text("${studentGpa?.weighted}")
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Unweighted GPA:",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text("${studentGpa?.unweighted}")
                ],
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
