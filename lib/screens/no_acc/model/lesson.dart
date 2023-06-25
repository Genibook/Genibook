class Lesson {
  late final String name;
  late final double grade;
  late final double creditGrade;
  late final bool addCredit;

  Lesson(
      {required this.name,
      required this.grade,
      required this.creditGrade,
      required this.addCredit});

  @override
  String toString() {
    return "$name $grade $creditGrade";
  }
}
