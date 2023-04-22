class Secret {
  final String _username;
  final String _password;
  final int _userSelector;
  final String _mp;
  final String _highSchool;

  Secret(this._username, this._password, this._userSelector, this._mp,
      this._highSchool);

  String get username => _username;
  String get password => _password;
  int get userSelector => _userSelector;
  String get mp => _mp;

  Map<String, dynamic> toJson() => {
        'username': _username,
        'password': _password,
        'userSelector': _userSelector,
        "highSchool": _highSchool,
        'mp': _mp,
      };

  factory Secret.fromJson(Map<String, dynamic> json) {
    return Secret(
      json['username'] as String,
      json['password'] as String,
      json['userSelector'] as int,
      json['mp'] as String,
      json["highSchool"] as String,
    );
  }
}
