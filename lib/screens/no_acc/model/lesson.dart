class Lesson {
  late final String name;
  late final double letterGrade;
  late final double creditGrade;
  late final bool add_credit;

  Lesson(
      {required this.name,
      required this.letterGrade,
      required this.creditGrade,
      required this.add_credit});

  @override
  String toString() {
    return "$name $letterGrade $creditGrade";
  }
}
