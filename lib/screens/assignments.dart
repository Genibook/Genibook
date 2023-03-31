import 'package:flutter/material.dart';

class AssignmentPage extends StatelessWidget {
  final List<dynamic>? assignments;

  const AssignmentPage({super.key, this.assignments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: assignments == null || assignments!.isEmpty
          ? const Center(
              child: Text('No assignments found. :/'),
            )
          : ListView.builder(
              itemCount: assignments!.length,
              itemBuilder: (BuildContext context, int index) {
                var assignment = assignments![index];
                return Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignment['assignment'],
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Category: ${assignment['category']}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Description: ${assignment['description']}',
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
                              '${assignment['grade_num']} (${assignment['grade_percent']}%)',
                              style: const TextStyle(
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
