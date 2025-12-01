import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resolution_app/dto/problem/get_home_problems_response.dart';
import 'package:resolution_app/dto/solution/get_all_solutions.dart';
import 'package:resolution_app/dto/solution/react_solution_request.dart';
import 'package:resolution_app/models/enums/solution_reaction.dart';
import 'package:resolution_app/models/solution.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/problem_repository.dart';
import 'package:resolution_app/repositories/solution_repository.dart';

class ProblemController extends ChangeNotifier {
  final ProblemRepository _problemRepository;
  final SolutionRepository _solutionRepository;
  final AuthController _authController;
  ProblemController(
    this._problemRepository,
    this._solutionRepository,
    this._authController,
  );
  GetHomeProblemsResponseDto? _problem;
  GetHomeProblemsResponseDto? get problem => _problem;
  List<GetAllSolutionsResponseDto> _solutions = [];
  List<GetAllSolutionsResponseDto> get solutions => _solutions;

  String? get userId => _authController.currentUser?.id;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _approvedIsLoading = false;
  bool get approvedIsLoading => _approvedIsLoading;
  void _setApprovedLoading(bool value) {
    _approvedIsLoading = value;
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

  final SolutionReaction _reaction = SolutionReaction.none;
  SolutionReaction get reaction => _reaction;

  void verifyIfIsMyProblem() {
    final userId = _authController.currentUser?.id;
    _isMyProblem = (userId == problem?.userId) ? true : false;
    notifyListeners();
  }

  void fetchSolutions() async {
    _setSolutionsLoading(true);
    if (problem != null) {
      final fetchedSolutions = await _solutionRepository.fetchSolutions(
        _authController.currentUser!.token,
        problem!.id,
      );
      fetchedSolutions.sort((a, b) {
        if (b.approved && !a.approved) {
          return 1;
        } else if (!b.approved && a.approved) {
          return -1;
        }

        return b.likes.compareTo(a.likes);
      });
      _solutions = fetchedSolutions;
      notifyListeners();
    }
    _setSolutionsLoading(false);
  }

  void fetchProblem(String problemId) async {
    try {
      final fetchedProblems = await _problemRepository.fetchProblemById(
        problemId,
      );
      _problem = fetchedProblems;
      notifyListeners();
      verifyIfIsMyProblem();
      fetchSolutions();
    } finally {
      _setLoading(false);
    }

    notifyListeners();
  }

  Future<bool> handleDeleteProblem() async {
    if (problem != null) {
      final bool result = await _problemRepository.deleteProblem(
        _authController.currentUser!.token,
        problem!.id,
      );
      return result;
    }
    return false;
  }

  void reactSolution(String solutionId, SolutionReaction newReaction) async {
    final newSolutions = solutions.map((sol) {
      if (sol.id == solutionId) {
        int newLikes = sol.likes;
        int newDislikes = sol.dislikes;
        newReaction = sol.myReaction == newReaction
            ? SolutionReaction.none
            : newReaction;

        if (sol.myReaction == SolutionReaction.like) {
          newLikes--;
        } else if (sol.myReaction == SolutionReaction.dislike) {
          newDislikes--;
        }
        if (newReaction == SolutionReaction.like) {
          newLikes++;
        } else if (newReaction == SolutionReaction.dislike) {
          newDislikes++;
        }

        return sol.copyWith(
          likes: newLikes,
          dislikes: newDislikes,
          myReaction: newReaction,
        );
      }
      return sol;
    }).toList();
    final requestDto = new ReactSolutionRequestDto(
      solutionId: solutionId,
      reaction: newReaction,
    );
    await _solutionRepository.reactSolution(
      _authController.currentUser!.token,
      requestDto,
    );
    _solutions = newSolutions;
    notifyListeners();
  }

  void handleApproved(
    GetAllSolutionsResponseDto solution,
    String problemID,
  ) async {
    _setApprovedLoading(true);
    final bool result = await _solutionRepository.approveSolution(
      _authController.currentUser!.token,
      solution.id,
      problem!.id,
    );
    if (result) {
      fetchSolutions();
      notifyListeners();
    }
    _setApprovedLoading(false);
  }
}
