class Grades {
  final Map<String, Map<String, dynamic>> _grades;

  Grades(this._grades);

  factory Grades.fromJson(Map<String, dynamic> json) {
    final Map<String, Map<String, dynamic>> grades = {};
    json.forEach((subject, details) {
      grades[subject] = Map<String, dynamic>.from(details);
    });
    return Grades(grades);
  }

  Map<String, Map<String, dynamic>> toJson() => _grades;

  Map<String, dynamic> getSubjectGrades(String subject) {
    return _grades[subject] ?? {};
  }

  int get length {
    return _grades.length;
  }

  Iterable<String> get keys {
    return _grades.keys;
  }

  double getSubjectGrade(String subject) {
    final Map<String, dynamic> subjectGrades = getSubjectGrades(subject);
    return subjectGrades['grade'] ?? 0.0;
  }

  String getSubjectTeacherName(String subject) {
    final Map<String, dynamic> subjectGrades = getSubjectGrades(subject);
    return subjectGrades['teacher_name'] ?? '';
  }

  String getSubjectTeacherEmail(String subject) {
    final Map<String, dynamic> subjectGrades = getSubjectGrades(subject);
    return subjectGrades['teacher_email'] ?? '';
  }
}

// final grades = Grades.fromJson({
//   'Math': {
//     'grade': 85.0,
//     'teacher_name': 'John Smith',
//     'teacher_email': 'john.smith@example.com'
//   },
//   'English': {
//     'grade': 92.0,
//     'teacher_name': 'Jane Doe',
//     'teacher_email': 'jane.doe@example.com'
//   },
//   'Science': {
//     'grade': 78.0,
//     'teacher_name': 'Bob Johnson',
//     'teacher_email': 'bob.johnson@example.com'
//   },
// });

// // Accessing grades for a subject
// final mathGrades = grades.getSubjectGrades('Math'); // returns {'grade': 85.0, 'teacher_name': 'John Smith', 'teacher_email': 'john.smith@example.com'}
// final mathGrade = grades.getSubjectGrade('Math'); // returns 85.0
// final mathTeacherName = grades.getSubjectTeacherName('Math'); // returns 'John Smith'
// final mathTeacherEmail = grades.getSubjectTeacherEmail('Math'); // returns 'john.smith@example.com'
