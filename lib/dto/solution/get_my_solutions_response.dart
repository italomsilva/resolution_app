class GetMySolutionsResponseDto {
  final String id;
  final String title;
  final String description;
  final bool approved;
  final DateTime createdAt;
  final String problemId;
  final String problemTitle;
  final int likes;
  final int dislikes;

  GetMySolutionsResponseDto({
    required this.id,
    required this.title,
    required this.description,
    required this.approved,
    required this.createdAt,
    required this.problemId,
    required this.problemTitle,
    required this.likes,
    required this.dislikes,
  });

  factory GetMySolutionsResponseDto.fromJson(Map<String, dynamic> json) {
    return GetMySolutionsResponseDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      approved: json['approved'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      problemId: json['problem_id'] as String,
      problemTitle: json['problem_title'] as String,
      likes: json['likes'] as int,
      dislikes: json['dislikes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'approved': approved,
      'created_at': createdAt.toIso8601String(),
      'problem_id': problemId,
      'problem_title': problemTitle,
      'likes': likes,
      'dislikes': dislikes,
    };
  }
}
