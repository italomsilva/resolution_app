import 'package:resolution_app/models/enums/problem_status.dart';

class Problem {
  final String id;
  final String title;
  final String description;
  final String location;
  final ProblemStatus status; 
  final DateTime createdAt;
  final String userId;

  Problem({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.status,
    required this.createdAt,
    required this.userId,
  });

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      status: ProblemStatus.fromInt(json['status'] as int),
      createdAt: DateTime.parse(json['created_at'] as String),
      userId: json['user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'status': status.value, 
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
    };
  }

  Problem copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    ProblemStatus? status,
    DateTime? createdAt,
    String? userId,
  }) {
    return Problem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }
}