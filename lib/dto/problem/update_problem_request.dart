import 'package:resolution_app/models/enums/problem_status.dart';

class UpdateProblemRequest {
  final String id;
  final String? title;
  final String? description;
  final String? location;
  final ProblemStatus? status;

  UpdateProblemRequest({
    required this.id,
    this.title,
    this.description,
    this.location,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      if (status != null) 'status': status!.value,
    };
  }
}