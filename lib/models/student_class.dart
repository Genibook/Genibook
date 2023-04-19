import 'package:genibook/models/assignments_class.dart';
import 'package:genibook/models/grades_class.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class Student {
  int age;
  String imageUrl;
  int stateId;
  String birthday;
  String scheduleLink;
  String name;
  int grade;
  String locker;
  String counselorName;
  int id;
  String image64;

  Assignments assignments;
  Grades grades;

  Student({
    required this.age,
    required this.imageUrl,
    required this.stateId,
    required this.birthday,
    required this.scheduleLink,
    required this.name,
    required this.grade,
    required this.locker,
    required this.counselorName,
    required this.id,
    required this.image64,
    required this.assignments,
    required this.grades,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      age: json['age'],
      imageUrl: json['img_url'],
      stateId: json['state_id'],
      birthday: json['birthday'],
      scheduleLink: json['schedule_link'],
      name: json['name'],
      grade: json['grade'],
      locker: json['locker'],
      counselorName: json['counselor_name'],
      id: json['id'],
      image64: json['image64'],
      assignments: json['assignments'] != null
          ? Assignments.fromJson(json['assignments'])
          : Assignments.fromJson({}),
      grades: json['grades'] != null
          ? Grades.fromJson(json['grades'])
          : Grades.fromJson({}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'img_url': imageUrl,
      'state_id': stateId,
      'birthday': birthday,
      'schedule_link': scheduleLink,
      'name': name,
      'grade': grade,
      'locker': locker,
      'counselor_name': counselorName,
      'id': id,
      'image64': image64,
      'assignments': assignments,
      'grades': grades,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Student &&
        other.age == age &&
        other.imageUrl == imageUrl &&
        other.stateId == stateId &&
        other.birthday == birthday &&
        other.scheduleLink == scheduleLink &&
        other.name == name &&
        other.grade == grade &&
        other.locker == locker &&
        other.counselorName == counselorName &&
        other.id == id &&
        other.image64 == image64 &&
        other.assignments == assignments &&
        other.grades == grades;
  }

  @override
  int get hashCode =>
      age.hashCode ^
      imageUrl.hashCode ^
      stateId.hashCode ^
      birthday.hashCode ^
      scheduleLink.hashCode ^
      name.hashCode ^
      grade.hashCode ^
      locker.hashCode ^
      counselorName.hashCode ^
      id.hashCode ^
      image64.hashCode ^
      const DeepCollectionEquality().hash(assignments.toJson()) ^
      const DeepCollectionEquality().hash(grades.toJson());
}
