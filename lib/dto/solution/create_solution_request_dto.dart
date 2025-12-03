class CreateSolutionRequestDto {
  String title;
  String description;
  double estimatedCost;
  String problemId;
  CreateSolutionRequestDto({
    required this.title,
    required this.description,
    required this.estimatedCost,
    required this.problemId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'estimated_cost': estimatedCost,
      'problem_id': problemId,
    };
  }
}
