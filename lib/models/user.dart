import 'package:resolution_app/models/enums/profile_type.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String document;
  final ProfileType profile;
  final String login;
  final String password;
  final String token;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.document,
    required this.profile,
    required this.login,
    required this.password,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      document: json['document'] as String,
      profile: ProfileType.fromInt(json['profile'] as int),
      login: json['login'] as String,
      password: json['password'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'document': document,
      'profile': profile.value,
      'login': login,
      'password': password,
      'token': token,
    };
  }
}