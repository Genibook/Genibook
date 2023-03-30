import 'package:flutter/material.dart';

class AssignmentPage extends StatelessWidget {
  final List<dynamic>? assignments;

  AssignmentPage({this.assignments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignments'),
      ),
      body: assignments == null || assignments!.isEmpty
          ? Center(
              child: Text('No assignments found.'),
            )
          : ListView.builder(
              itemCount: assignments!.length,
              itemBuilder: (BuildContext context, int index) {
                var assignment = assignments![index];
                return Card(
                  margin: EdgeInsets.all(16.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignment['assignment'],
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Category: ${assignment['category']}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Description: ${assignment['description']}',
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
                              '${assignment['grade_num']} (${assignment['grade_percent']}%)',
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
                );
              },
            ),
    );
  }
}
