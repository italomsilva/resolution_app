import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resolution_app/dto/problem/get_home_problems_response.dart';
import 'package:resolution_app/dto/solution/get_all_solutions.dart';
import 'package:resolution_app/models/enums/solution_reaction.dart';
import 'package:resolution_app/models/solution.dart';
import 'package:resolution_app/repositories/problem_repository.dart';
import 'package:resolution_app/repositories/solution_repository.dart';

class ProblemController extends ChangeNotifier {
  final ProblemRepository _problemRepository;
  final SolutionRepository _solutionRepository;
  ProblemController(this._problemRepository, this._solutionRepository);
  GetHomeProblemsResponseDto? _problem;
  GetHomeProblemsResponseDto? get problem => _problem;
  List<GetAllSolutionsResponseDto> _solutions = [];
  List<GetAllSolutionsResponseDto> get solutions => _solutions;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isMyProblem = true;
  bool get isMyProblem => _isMyProblem;

  bool _solutionsLoading = false;
  bool get solutionsLoading => _solutionsLoading;
  void _setSolutionsLoading(bool value) {
    _solutionsLoading = value;
    notifyListeners();
  }

  SolutionReaction _reaction = SolutionReaction.none;
  SolutionReaction get reaction => _reaction;

  void handleBack(BuildContext context) {
    context.pop();
  }

  void verifyIfIsMyProblem() {
    _isMyProblem = false;
    notifyListeners();
  }

  void fetchSolutions() async {
    _setSolutionsLoading(true);
    final fetchedSolutions = await _solutionRepository.fetchSolutions();
    _solutions = fetchedSolutions;
    notifyListeners();
    _setSolutionsLoading(false);
  }

  void fetchProblem(String problemId) async {
    try {
      final fetchedProblems = await _problemRepository.fetchProblemById(
        problemId,
      );
      _problem = fetchedProblems;
      notifyListeners();
      fetchSolutions();
    } finally {
      _setLoading(false);
    }

    notifyListeners();
  }

  void handleDeleteProblem() {}

  void reactSolution(SolutionReaction reaction){}
}
