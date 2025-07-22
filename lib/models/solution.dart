class Solution {
  final String id;
  final String title;
  final String description;
  final double estimatedCost;
  final bool approved;
  final DateTime createdAt;
  final String problemId;
  final String userId;

  Solution({
    required this.id,
    required this.title,
    required this.description,
    required this.estimatedCost,
    required this.approved,
    required this.createdAt,
    required this.problemId,
    required this.userId,
  });

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      estimatedCost: json['estimated_cost'] as double,
      approved: json['approved'] as bool,
      createdAt: json['created_at'] as DateTime,
      problemId: json['problem_id'] as String,
      userId: json['user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'estimated_cost': estimatedCost,
      'approved': approved,
      'created_at': createdAt,
      'problem_id': problemId,
      'user_id': userId,
    };
  }
}