import 'package:resolution_app/mocks/get_my_problems.dart';
import 'package:resolution_app/models/solution.dart'; // Importe sua classe Solution
import 'package:resolution_app/models/problems.dart'; // Importe sua classe Problem

List<Solution> getMockAllSolutions() {
  final List<Solution> allSolutions = [];
  final List<Problem> problems = getMockMyProblems();

  int solutionCounter = 1;

  for (final problem in problems) {
    for (int i = 1; i <= 10; i++) {
      final String solutionId =
          's${solutionCounter.toString().padLeft(4, '0')}';
      final String solutionTitle =
          'Solução #${i} para ${problem.title.substring(0, problem.title.length > 30 ? 30 : problem.title.length)}...';
      final String solutionDescription =
          'Proposta detalhada para resolver "${problem.title}". Envolve etapas de avaliação, reparo e acompanhamento da solução. Custo estimado inclui mão de obra e materiais.';
      final double estimatedCost = (100.0 + (i * 50) + (solutionCounter % 100))
          .toDouble();
      final bool approved = i % 3 == 0;
      final DateTime solutionCreatedAt = problem.createdAt.add(
        Duration(days: i, hours: i * 2),
      );

      allSolutions.add(
        Solution(
          id: solutionId,
          title: solutionTitle,
          description: solutionDescription,
          estimatedCost: estimatedCost,
          approved: approved,
          createdAt: solutionCreatedAt,
          problemId: problem.id,
          userId: problem.userId,
        ),
      );
      solutionCounter++;
    }
  }

  return allSolutions;
}
