import 'package:flutter/material.dart';
import 'package:resolution_app/dtos/problems/get_home_problems_response.dart';
import 'package:resolution_app/repositories/problem_repository.dart';

class HomeProblemsController extends ChangeNotifier {
  final ProblemRepository _problemRepository;

  HomeProblemsController(this._problemRepository);

  List<GetHomeProblemsResponseDto> _problems = [];
  List<GetHomeProblemsResponseDto> get problems => _problems;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> fetchProblems() async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final fetchedProblems = _problemRepository.fetchProblems();
      _problems = await fetchedProblems;
    } catch (e) {
      _setErrorMessage('Não foi possível carregar os problemas: $e');
      _problems = [];
    } finally {
      _setLoading(false);
    }
  }
}
