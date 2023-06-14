class Lesson {
  late final String name;
  late final double letterGrade;
  late final double creditGrade;

  Lesson({ required this.name, required this.letterGrade, required this.creditGrade});

  @override
  String toString() {
    return "$name $letterGrade $creditGrade";
  }
}