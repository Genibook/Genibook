import 'package:flutter/material.dart';
import 'package:genipaws/models/student_class.dart';
import 'package:genipaws/utils/profile_utils.dart';

AlertDialog gimmeDetailedProfileView(Student student) {
  return AlertDialog(
    title: const Text(
      'Details',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    content: SizedBox(
        height: 90,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Locker : ${student.locker}',
            style: const TextStyle(fontSize: 12.0),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'State ID: ${student.stateId}',
            style: const TextStyle(fontSize: 12.0),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Birthday: ${student.birthday}',
            style: const TextStyle(fontSize: 12.0),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                'Schedule Link: ',
                style: TextStyle(fontSize: 12.0),
              ),
              InkWell(
                  onTap: () {
                    LaunchUrl(student.scheduleLink);
                  },
                  child: const Text(
                    "click me!",
                    style: TextStyle(fontSize: 12.0, color: Colors.blue),
                  ))
            ],
          ),
        ])),
  );
}
