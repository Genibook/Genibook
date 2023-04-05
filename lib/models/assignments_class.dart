//Assignments assignments = Assignments.fromJson(assignmentsJson);
// String assignmentsJsonString = jsonEncode(assignments.toJson());

class Assignments {
  Map<String, List<Assignment>> assignments;

  Assignments(this.assignments);

  factory Assignments.fromJson(Map<String, dynamic> json) {
    Map<String, List<Assignment>> data = {};
    json.forEach((key, value) {
      List<Assignment> assignments = [];
      for (var assignment in value) {
        assignments.add(Assignment.fromJson(assignment));
      }
      data[key] = assignments;
    });
    return Assignments(data);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    assignments.forEach((key, value) {
      json[key] = value.map((assignment) => assignment.toJson()).toList();
    });
    return json;
  }

  List<Assignment> operator [](String key) {
    return assignments[key] ?? [Assignment.fromJson({})];
  }

  bool isEmptyForAClass(String key) {
    return assignments[key]!.isEmpty;
  }

  int get length => assignments.length;

  bool get isEmptyDict => assignments.isEmpty;

  bool get isNotEmpty => assignments.isNotEmpty;
}

class Assignment {
  String courseName;
  String mp;
  String dayName;
  String fullDayName;
  String date;
  String fullDate;
  String teacher;
  String category;
  String assignment;
  String description;
  String gradePercent;
  String gradeNum;
  String comment;
  String prev;
  String docs;

  Assignment({
    required this.courseName,
    required this.mp,
    required this.dayName,
    required this.fullDayName,
    required this.date,
    required this.fullDate,
    required this.teacher,
    required this.category,
    required this.assignment,
    required this.description,
    required this.gradePercent,
    required this.gradeNum,
    required this.comment,
    required this.prev,
    required this.docs,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      courseName: json['course_name'],
      mp: json['mp'],
      dayName: json['dayname'],
      fullDayName: json['full_dayname'],
      date: json['date'],
      fullDate: json['full_date'],
      teacher: json['teacher'],
      category: json['category'],
      assignment: json['assignment'],
      description: json['description'],
      gradePercent: json['grade_percent'],
      gradeNum: json['grade_num'],
      comment: json['comment'],
      prev: json['prev'],
      docs: json['docs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_name': courseName,
      'mp': mp,
      'dayname': dayName,
      'full_dayname': fullDayName,
      'date': date,
      'full_date': fullDate,
      'teacher': teacher,
      'category': category,
      'assignment': assignment,
      'description': description,
      'grade_percent': gradePercent,
      'grade_num': gradeNum,
      'comment': comment,
      'prev': prev,
      'docs': docs,
    };
  }
}
