class Secret {
  final String username;
  final String password;
  final String userSelector;
  final String mp;
  final String highSchool;

  Secret(
      {required this.username,
      required this.password,
      required this.userSelector,
      required this.mp,
      required this.highSchool});

  Map<String, String> toJson() => {
        'username': username,
        'password': password,
        'user': userSelector,
        "highschool": highSchool,
        'mp': mp,
      };

  factory Secret.fromJson(Map<String, dynamic> json) {
    return Secret(
      username: json['username'] as String,
      password: json['password'] as String,
      userSelector: json['user'] as String,
      mp: json['mp'] as String,
      highSchool: json["highschool"] as String,
    );
  }

  bool get valid {
    if (password.isNotEmpty &&
        mp.isNotEmpty &&
        username.isNotEmpty &&
        highSchool.isNotEmpty &&
        username.isNotEmpty &&
        userSelector.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
