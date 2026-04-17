import 'package:flutter/material.dart';
import 'package:resolution_app/app_theme.dart';
import 'package:resolution_app/dto/problem/get_home_problems_response.dart';
import 'package:resolution_app/dto/problem/stats_count_problem_status_response.dart';
import 'package:resolution_app/dto/problem/update_problem_request.dart';
import 'package:resolution_app/models/enums/problem_status.dart';
import 'package:resolution_app/models/problems.dart';
import 'package:resolution_app/repositories/problem_repository.dart';
import 'package:resolution_app/mocks/mock_data.dart';

class ProblemRepositoryMock extends ProblemRepository {
  List<Problem> get _mockProblems => MockData.mockProblems;

  @override
  Future<List<GetHomeProblemsResponseDto>> fetchProblems({
    String? token,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final sorted = List<Problem>.from(_mockProblems)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return sorted.map((p) {
      final user = MockData.mockUsers.firstWhere(
        (u) => u.id == p.userId,
        orElse: () => MockData.mockUsers.first,
      );
      return GetHomeProblemsResponseDto(
        id: p.id,
        title: p.title,
        description: p.description,
        location: p.location,
        status: p.status,
        createdAt: p.createdAt,
        userId: p.userId,
        userLogin: user.login,
        solutionsCount: MockData.mockSolutions.where((s) => s.problemId == p.id).length,
      );
    }).toList();
  }

  @override
  Future<List<Problem>> fetchMyProblems(String token) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = MockData.mockUsers.firstWhere(
      (u) => "Bearer ${u.token}" == token || u.token == token,
      orElse: () => MockData.mockUsers.first,
    );
    return _mockProblems.where((p) => p.userId == user.id).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<bool> createProblem(
    String token,
    String title,
    String description,
    String location,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = MockData.mockUsers.firstWhere(
      (u) => "Bearer ${u.token}" == token || u.token == token,
      orElse: () => MockData.mockUsers.first,
    );
    final newProblem = Problem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      location: location,
      status: ProblemStatus.open,
      createdAt: DateTime.now(),
      userId: user.id,
    );
    _mockProblems.add(newProblem);
    return true;
  }

  @override
  Future<GetHomeProblemsResponseDto?> fetchProblemById(String problemId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final problem = _mockProblems.firstWhere((p) => p.id == problemId);
      final user = MockData.mockUsers.firstWhere(
        (u) => u.id == problem.userId,
        orElse: () => MockData.mockUsers.first,
      );
      return GetHomeProblemsResponseDto(
        id: problem.id,
        title: problem.title,
        description: problem.description,
        location: problem.location,
        status: problem.status,
        createdAt: problem.createdAt,
        userId: problem.userId,
        userLogin: user.login,
        solutionsCount: MockData.mockSolutions.where((s) => s.problemId == problem.id).length,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> updateProblem(
    String token,
    UpdateProblemRequest updateRequest,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockProblems.indexWhere((p) => p.id == updateRequest.id);
    if (index == -1) return false;

    final existing = _mockProblems[index];
    _mockProblems[index] = existing.copyWith(
      title: updateRequest.title ?? existing.title,
      description: updateRequest.description ?? existing.description,
      location: updateRequest.location ?? existing.location,
      status: updateRequest.status ?? existing.status,
    );
    return true;
  }

  @override
  Future<bool> deleteProblem(String token, String problemId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final initialLength = _mockProblems.length;
    _mockProblems.removeWhere((p) => p.id == problemId);
    return _mockProblems.length < initialLength;
  }

  @override
  Future<List<StatsCountProblemStatusResponse>> statsCountProblemStatus(
    String token,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final Map<ProblemStatus, int> counts = {
      ProblemStatus.open: 0,
      ProblemStatus.inProgress: 0,
      ProblemStatus.resolved: 0,
      ProblemStatus.canceled: 0,
    };

    for (var problem in _mockProblems) {
      counts[problem.status] = (counts[problem.status] ?? 0) + 1;
    }

    Color getColor(ProblemStatus status) {
      switch (status) {
        case ProblemStatus.open:
          return AppTheme.lightTheme.primaryColorDark;
        case ProblemStatus.inProgress:
          return AppTheme.lightTheme.primaryColorLight;
        case ProblemStatus.resolved:
          return AppTheme.lightTheme.primaryColor;
        case ProblemStatus.canceled:
          return AppTheme.neutralColor;
      }
    }

    return counts.entries
        .map(
          (e) => StatsCountProblemStatusResponse(
            status: e.key,
            count: e.value,
            color: getColor(e.key),
          ),
        )
        .toList();
  }
}
