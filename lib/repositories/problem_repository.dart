import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:resolution_app/dto/problem/get_home_problems_response.dart';
import 'package:resolution_app/mocks/get_home_problems_response.dart';
import 'package:resolution_app/mocks/get_my_problems.dart';
import 'package:resolution_app/models/problems.dart';

class ProblemRepositoryException implements Exception {
  final String message;
  ProblemRepositoryException(this.message);

  @override
  String toString() => 'ProblemRepositoryException: $message';
}

class ProblemRepository {
  final String _baseUrl = dotenv.get('BASE_BACKEND_URL');

  Future<List<GetHomeProblemsResponseDto>> fetchProblems() async {
    await Future.delayed(const Duration(seconds: 3));
    _baseUrl;
    return getMockHomeProblems();
  }

  Future<List<Problem>> fetchMyProblems() async {
    await Future.delayed(const Duration(seconds: 3));
    _baseUrl;
    return getMockMyProblems();
  }

  Future<GetHomeProblemsResponseDto?> fetchProblemById(String problemId) async {
    await Future.delayed(Duration(seconds: 3));
    final problems = getMockHomeProblems();
    for (var i = 0; i < problems.length; i++) {
      if (problems[i].id == problemId) {
        return problems[i];
      }
    }
    return null;
  }
}
