class GetAllSolutionsResponseDto {
  final String id;
  final String title;
  final String description;
  final double estimatedCost;
  final bool approved;
  final DateTime createdAt;
  final String problemId;
  final String problemTitle;
  final String userId;
  final String userLogin;
  final int likes;
  final int dislikes;

  GetAllSolutionsResponseDto({
    required this.id,
    required this.title,
    required this.description,
    required this.estimatedCost,
    required this.approved,
    required this.createdAt,
    required this.problemId,
    required this.problemTitle,
    required this.userId,
    required this.userLogin,
    required this.likes,
    required this.dislikes,
  });

  factory GetAllSolutionsResponseDto.fromJson(Map<String, dynamic> json) {
    return GetAllSolutionsResponseDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      estimatedCost: json['estimated_cost'] as double,
      approved: json['approved'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      problemId: json['problem_id'] as String,
      problemTitle: json['problem_title'] as String,
      userId: json['user_id'] as String,
      userLogin: json['user_login'] as String,
      likes: json['likes'] as int,
      dislikes: json['dislikes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'estimated_cost': estimatedCost,
      'approved': approved,
      'created_at': createdAt.toIso8601String(),
      'problem_id': problemId,
      'problem_title': problemTitle,
      'user_id': userId,
      'user_login': userLogin,
      'likes': likes,
      'dislikes': dislikes,
    };
  }
}
