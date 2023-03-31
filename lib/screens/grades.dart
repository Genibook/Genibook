import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/utils/grades_utils.dart';
import 'package:genibook/widgets/navbar.dart';
import 'assignments.dart';

class GradesPage extends StatefulWidget {
  final Map<String, dynamic> grades;
  final Map<String, dynamic> assignments;

  GradesPage({required this.grades, required this.assignments});

  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navbar(selectedIndex: Constants.gradePageNavNumber),
      appBar: AppBar(
        title: const Text('Grades'),
        elevation: 2,
        shadowColor: Theme.of(context).shadowColor,
      ),
      body: ListView.builder(
        itemCount: widget.grades.length,
        itemBuilder: (BuildContext context, int index) {
          String courseName = widget.grades.keys.elementAt(index);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignmentPage(
                    assignments: widget.assignments[courseName],
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseName,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Teacher: ${widget.grades[courseName]['teacher_name']}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Email: ${widget.grades[courseName]['teacher_email']}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Grade:',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          widget.grades[courseName]['grade'].toString(),
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: getColorFromGrade(
                                  widget.grades[courseName]['grade'])),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
