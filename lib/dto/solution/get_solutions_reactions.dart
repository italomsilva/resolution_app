class StatsCountSolutionsReactionsResponse {
  final String solutionTitle;
  final int likes;
  final int dislikes;
  final DateTime createdAt;

  StatsCountSolutionsReactionsResponse({
    required this.solutionTitle,
    required this.likes,
    required this.dislikes,
    required this.createdAt,
  });


    factory StatsCountSolutionsReactionsResponse.fromJson(Map<String, dynamic> json) {
    return StatsCountSolutionsReactionsResponse(
      solutionTitle: json['solution_title'] as String,
      likes: json['likes'] as int,
      dislikes: json['dislikes'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }


}