class Gpa {
  double unweighted;
  double weighted;

  Gpa({required this.unweighted, required this.weighted});

  Map<String, dynamic> toJson() {
    return {
      'unweighted': unweighted,
      'weighted': weighted,
    };
  }

  factory Gpa.fromJson(Map<String, dynamic> json) {
    return Gpa(
      unweighted: json['unweighted'].toDouble(),
      weighted: json['weighted'].toDouble(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Gpa &&
          runtimeType == other.runtimeType &&
          unweighted == other.unweighted &&
          weighted == other.weighted;

  @override
  int get hashCode => unweighted.hashCode ^ weighted.hashCode;
}
