import 'package:resolution_app/dto/solution/create_solution_request_dto.dart';
import 'package:resolution_app/dto/solution/get_all_solutions.dart';
import 'package:resolution_app/dto/solution/get_my_solutions_response.dart';
import 'package:resolution_app/dto/solution/get_solutions_reactions.dart';
import 'package:resolution_app/dto/solution/react_solution_request.dart';
import 'package:resolution_app/dto/solution/update_solution_request_dto.dart';
import 'package:resolution_app/models/enums/solution_reaction.dart';
import 'package:resolution_app/models/solution.dart';
import 'package:resolution_app/repositories/solution_repository.dart';
import 'package:resolution_app/mocks/mock_data.dart';

class SolutionRepositoryMock extends SolutionRepository {
  List<Solution> get _mockSolutions => MockData.mockSolutions;
  Map<String, Map<String, SolutionReaction>> get _reactions => MockData.mockReactions;

  @override
  Future<bool> createSolution(
    String token,
    CreateSolutionRequestDto createRequest,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = MockData.mockUsers.firstWhere(
      (u) => "Bearer ${u.token}" == token || u.token == token,
      orElse: () => MockData.mockUsers.first,
    );
    _mockSolutions.add(Solution(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: createRequest.title,
      description: createRequest.description,
      estimatedCost: createRequest.estimatedCost,
      approved: false,
      createdAt: DateTime.now(),
      problemId: createRequest.problemId,
      userId: user.id,
    ));
    return true;
  }

  @override
  Future<List<GetAllSolutionsResponseDto>> fetchSolutions(
    String token,
    String problemId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final filtered = _mockSolutions.where((s) => s.problemId == problemId).toList();
    final currentUser = MockData.mockUsers.firstWhere(
      (u) => "Bearer ${u.token}" == token || u.token == token,
      orElse: () => MockData.mockUsers.first,
    );
    
    return filtered.map((s) {
      final solutionReactions = _reactions[s.id] ?? {};
      int likes = solutionReactions.values.where((r) => r == SolutionReaction.like).length;
      int dislikes = solutionReactions.values.where((r) => r == SolutionReaction.dislike).length;
      final myReaction = solutionReactions[currentUser.id] ?? SolutionReaction.none; 

      final author = MockData.mockUsers.firstWhere(
        (u) => u.id == s.userId,
        orElse: () => MockData.mockUsers.first,
      );

      final problem = MockData.mockProblems.firstWhere(
        (p) => p.id == s.problemId,
        orElse: () => MockData.mockProblems.first,
      );

      return GetAllSolutionsResponseDto(
        id: s.id,
        title: s.title,
        description: s.description,
        estimatedCost: s.estimatedCost,
        approved: s.approved,
        createdAt: s.createdAt,
        problemId: s.problemId,
        problemTitle: problem.title,
        userId: s.userId,
        userLogin: author.login,
        likes: likes,
        dislikes: dislikes,
        myReaction: myReaction,
      );
    }).toList();
  }

  @override
  Future<List<GetMySolutionsResponseDto>> fetchMySolutions(String token) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = MockData.mockUsers.firstWhere(
      (u) => "Bearer ${u.token}" == token || u.token == token,
      orElse: () => MockData.mockUsers.first,
    );
    final filtered = _mockSolutions.where((s) => s.userId == user.id).toList();
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return filtered.map((s) {
      final problem = MockData.mockProblems.firstWhere(
        (p) => p.id == s.problemId,
        orElse: () => MockData.mockProblems.first,
      );

      final solutionReactions = _reactions[s.id] ?? {};
      int likes = solutionReactions.values.where((r) => r == SolutionReaction.like).length;
      int dislikes = solutionReactions.values.where((r) => r == SolutionReaction.dislike).length;

      return GetMySolutionsResponseDto(
        id: s.id,
        title: s.title,
        description: s.description,
        approved: s.approved,
        createdAt: s.createdAt,
        problemId: s.problemId,
        problemTitle: problem.title,
        likes: likes,
        dislikes: dislikes,
      );
    }).toList();
  }

  @override
  Future<void> reactSolution(String token, ReactSolutionRequestDto requestDto) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = MockData.mockUsers.firstWhere(
      (u) => "Bearer ${u.token}" == token || u.token == token,
      orElse: () => MockData.mockUsers.first,
    );
    if (!_reactions.containsKey(requestDto.solutionId)) {
      _reactions[requestDto.solutionId] = {};
    }
    _reactions[requestDto.solutionId]![user.id] = requestDto.reaction;
  }

  @override
  Future<bool> approveSolution(
    String token,
    String solutionId,
    String problemID,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final idx = _mockSolutions.indexWhere((s) => s.id == solutionId);
    if (idx != -1) {
      final existing = _mockSolutions[idx];
      _mockSolutions[idx] = Solution(
        id: existing.id,
        title: existing.title,
        description: existing.description,
        estimatedCost: existing.estimatedCost,
        approved: true,
        createdAt: existing.createdAt,
        problemId: existing.problemId,
        userId: existing.userId,
      );
      return true;
    }
    return false;
  }

  @override
  Future<Solution?> fetchSolutionById(String solutionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _mockSolutions.firstWhere((s) => s.id == solutionId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> updateSolution(
    String token,
    UpdateSolutionRequestDto updateRequest,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockSolutions.indexWhere((s) => s.id == updateRequest.id);
    if (index == -1) return false;

    final existing = _mockSolutions[index];
    _mockSolutions[index] = Solution(
      id: existing.id,
      title: updateRequest.title ?? existing.title,
      description: updateRequest.description ?? existing.description,
      estimatedCost: updateRequest.estimatedCost ?? existing.estimatedCost,
      approved: existing.approved, 
      createdAt: existing.createdAt,
      problemId: existing.problemId,
      userId: existing.userId,
    );
    return true;
  }

  @override
  Future<bool> deleteSolution(String token, String solutionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final initialLen = _mockSolutions.length;
    _mockSolutions.removeWhere((s) => s.id == solutionId);
    return _mockSolutions.length < initialLen;
  }

  @override
  Future<List<StatsCountSolutionsReactionsResponse>> statsCountSolutionsReactions(
    String token,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = MockData.mockUsers.firstWhere(
      (u) => "Bearer ${u.token}" == token || u.token == token,
      orElse: () => MockData.mockUsers.first,
    );
    
    final mySols = _mockSolutions.where((s) => s.userId == user.id).toList();
    List<StatsCountSolutionsReactionsResponse> stats = [];

    for (var s in mySols) {
      final solutionReactions = _reactions[s.id] ?? {};
      int likes = solutionReactions.values.where((r) => r == SolutionReaction.like).length;
      int dislikes = solutionReactions.values.where((r) => r == SolutionReaction.dislike).length;
      stats.add(StatsCountSolutionsReactionsResponse(
        solutionTitle: s.title,
        likes: likes,
        dislikes: dislikes,
        createdAt: s.createdAt,
      ));
    }

    stats.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return stats;
  }
}
