import 'package:resolution_app/models/enums/problem_status.dart';

class GetHomeProblemsResponseDto {
  final String id;
  final String title;
  final String description;
  final String location;
  final ProblemStatus status;
  final DateTime createdAt;
  final String userId;
  final String userLogin;
  final int solutionsCount;

  GetHomeProblemsResponseDto({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.status,
    required this.createdAt,
    required this.userId,
    required this.userLogin,
    required this.solutionsCount,
  });

  factory GetHomeProblemsResponseDto.fromJson(Map<String, dynamic> json) {
    return GetHomeProblemsResponseDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      status: ProblemStatus.fromInt(json['status'] as int),
      createdAt: DateTime.parse(json['createdAt'] as String),
      userId: json['userId'] as String,
      userLogin: json['userLogin'] as String,
      solutionsCount: json['solutionsCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'status': status.value,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
      'userLogin': userLogin,
      'solutionsCount': solutionsCount,
    };
  }
}
