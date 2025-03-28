class UserModel {
  String? uid;
  String? username;
  String? email;
  String? password;

  UserModel(
      {required this.uid,
      required this.username,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
}
