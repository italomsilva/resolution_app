import 'package:resolution_app/models/enums/profile_type.dart';

class RegisterUserRequestDto {
  final String name;
  final String email;
  final String document;
  final ProfileType profile;
  final String login;
  final String password;


  RegisterUserRequestDto({
    required this.name,
    required this.email,
    required this.document,
    required this.profile,
    required this.login,
    required this.password,
  });

  factory RegisterUserRequestDto.fromJson(Map<String, dynamic> json) {
    return RegisterUserRequestDto(
      name: json['name'] as String,
      email: json['email'] as String,
      document: json['document'] as String,
      profile: json['profile'] as ProfileType,
      login: json['login'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'document': document,
      'profile': profile,
      'login': login,
      'password': password,
    };
  }
}
