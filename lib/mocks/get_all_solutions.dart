import 'dart:math';

import 'package:resolution_app/dto/solution/get_all_solutions.dart';
import 'package:resolution_app/mocks/get_my_problems.dart';
import 'package:resolution_app/models/enums/solution_reaction.dart';
import 'package:resolution_app/models/solution.dart'; // Importe sua classe Solution
import 'package:resolution_app/models/problems.dart'; // Importe sua classe Problem

List<GetAllSolutionsResponseDto> getMockAllSolutions() {
  final List<GetAllSolutionsResponseDto> allSolutions = [];
  final List<Problem> problems = getMockMyProblems();

  int solutionCounter = 1;

  for (final problem in problems) {
    for (int i = 1; i <= 10; i++) {
      final String solutionId =
          's${solutionCounter.toString().padLeft(4, '0')}';
      final String solutionTitle = 'Solução #$i para ${problem.title}';
      final String solutionDescription =
          'Proposta detalhada para resolver "${problem.title}". Envolve etapas de avaliação, reparo e acompanhamento da solução. Custo estimado inclui mão de obra e materiais.';
      final double estimatedCost = (100.0 + (i * 50) + (solutionCounter % 100))
          .toDouble();
      final bool approved = i % 3 == 0;
      final DateTime solutionCreatedAt = problem.createdAt.add(
        Duration(days: i, hours: i * 2),
      );

      allSolutions.add(
        GetAllSolutionsResponseDto(
          id: solutionId,
          title: solutionTitle,
          description: solutionDescription,
          estimatedCost: estimatedCost,
          approved: approved,
          createdAt: solutionCreatedAt,
          problemId: problem.id,
          userId: problem.userId,
          problemTitle: problem.title,
          userLogin: 'User_${problem.userId}',
          likes: Random().nextInt(251),
          dislikes: Random().nextInt(251),
          myReaction: SolutionReaction.fromInt(Random().nextInt(3)),
        ),
      );
      solutionCounter++;
    }
  }

  return allSolutions;
}
