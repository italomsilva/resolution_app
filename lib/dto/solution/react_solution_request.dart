import 'package:resolution_app/models/enums/solution_reaction.dart';

class ReactSolutionRequestDto {
  final String solutionId;
  final SolutionReaction reaction;

  ReactSolutionRequestDto({required this.solutionId, required this.reaction});

  Map<String, dynamic> toJson() {
    return {
      'solution_id': solutionId,
      'reaction_type': reaction.value,
    };
  }
}
