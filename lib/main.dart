import 'package:flutter/material.dart';
import 'package:genibook/screens/profile.dart';
import 'package:genibook/models/student_class.dart';
import 'dart:io';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_size/window_size.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'constants.dart';
import 'screens/grades.dart';
import 'screens/login.dart';
import 'utils/http_overrides.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  if (UniversalPlatform.isWindows ||
      UniversalPlatform.isLinux ||
      UniversalPlatform.isMacOS) {
    setWindowMinSize(const Size(350, 650));
    setWindowMaxSize(Size.infinite);
  } else {
    // phone!
  }

  runApp(const Genibook());
}

class Genibook extends StatelessWidget {
  const Genibook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grades',
        theme: ThemeData(
          colorScheme: lightColorScheme ?? Constants.defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? Constants.defaultDarkColorScheme,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: GradesPage(student: eddie),
        //home: LoginPage(),
        //home: ProfilePage(studentData: studentData),
      );
    });
  }
}

Map<String, List<Map<String, dynamic>>> assignments = {
  "Math": [
    {
      "course_name": "Math",
      "mp": "3",
      "dayname": "Monday",
      "full_dayname": "Monday, December 20, 2021",
      "date": "12/20/2021",
      "full_date": "12/20/2021",
      "teacher": "Mr. Smith",
      "category": "Homework",
      "assignment": "Page 40-41, problems 1-10",
      "description": "Complete the assigned problems in your workbook.",
      "grade_percent": "90",
      "grade_num": "9/10",
      "comment": "Great job! Just missed one question.",
      "prev": "N/A",
      "docs": "N/A"
    }
  ],
  "Science": [
    {
      "course_name": "Science",
      "mp": "3",
      "dayname": "Tuesday",
      "full_dayname": "Tuesday, December 21, 2021",
      "date": "12/21/2021",
      "full_date": "12/21/2021",
      "teacher": "Ms. Johnson",
      "category": "Lab Report",
      "assignment": "Experiment 4: Chemical Reactions",
      "description":
          "Write a lab report summarizing the results of the experiment.",
      "grade_percent": "95",
      "grade_num": "19/20",
      "comment": "Excellent work! You just missed a few minor details.",
      "prev": "N/A",
      "docs": "N/A"
    },
    {
      "course_name": "Science",
      "mp": "3",
      "dayname": "Tuesday",
      "full_dayname": "Tuesday, December 21, 2021",
      "date": "12/21/2021",
      "full_date": "12/21/2021",
      "teacher": "Ms. Johnson",
      "category": "Lab Report",
      "assignment": "Experiment 4: Chemical Reactions",
      "description":
          "Write a lab report summarizing the results of the experiment.",
      "grade_percent": "95",
      "grade_num": "19/20",
      "comment": "Excellent work! You just missed a few minor details.",
      "prev": "N/A",
      "docs": "N/A"
    }
  ],
  "English": [
    {
      "course_name": "English",
      "mp": "3",
      "dayname": "Wednesday",
      "full_dayname": "Wednesday, December 22, 2021",
      "date": "12/22/2021",
      "full_date": "12/22/2021",
      "teacher": "Ms. Lee",
      "category": "Essay",
      "assignment": "Persuasive Essay",
      "description": "Write a persuasive essay on the topic given in class.",
      "grade_percent": "85",
      "grade_num": "17/20",
      "comment": "Good job! There were a few errors in grammar and spelling.",
      "prev": "N/A",
      "docs": "N/A"
    }
  ]
};

Student eddie = Student.fromJson({
  'age': 15,
  'img_url': 'https://c.tenor.com/bCfpwMjfAi0AAAAC/cat-typing.gif',
  'state_id': 4238447327,
  'birthday': '06/07/2007',
  'schedule_link': 'https://example.com',
  'name': 'Eddie Tang',
  'grade': 10,
  'locker': 'N/A',
  'counselor_name': 'James Charles',
  'id': 107600,
  'image64': 'N/A',
  'assignments': assignments,
  'grades': {
    'Math': {
      'grade': 85.0,
      'teacher_name': 'John Smith',
      'teacher_email': 'john.smith@example.com'
    },
    'English': {
      'grade': 92.0,
      'teacher_name': 'Jane Doe',
      'teacher_email': 'jane.doe@example.com'
    },
    'Science': {
      'grade': 78.0,
      'teacher_name': 'Bob Johnson',
      'teacher_email': 'bob.johnson@example.com'
    },
  }
});
