class UpdateSolutionRequestDto {
  String id;
  String? title;
  String? description;
  double? estimatedCost;
  UpdateSolutionRequestDto({
    required this.id,
    this.title,
    this.description,
    this.estimatedCost,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (estimatedCost != null) 'estimated_cost': estimatedCost,
    };
  }
}
