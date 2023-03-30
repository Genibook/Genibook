import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('Grades'),
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
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseName,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Teacher: ${widget.grades[courseName]['teacher_name']}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Email: ${widget.grades[courseName]['teacher_email']}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Grade:',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          widget.grades[courseName]['grade'].toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
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
