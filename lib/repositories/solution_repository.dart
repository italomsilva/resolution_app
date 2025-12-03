import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:resolution_app/dto/solution/create_solution_request_dto.dart';
import 'package:resolution_app/dto/solution/get_all_solutions.dart';
import 'package:resolution_app/dto/solution/get_my_solutions_response.dart';
import 'package:resolution_app/dto/solution/react_solution_request.dart';
import 'package:resolution_app/dto/solution/update_solution_request_dto.dart';
import 'package:resolution_app/mocks/get_all_solutions.dart';
import 'package:resolution_app/mocks/get_my_solutions.dart';
import 'package:resolution_app/models/solution.dart';

class SolutionRepositoryException implements Exception {
  final String message;
  SolutionRepositoryException(this.message);

  @override
  String toString() => 'SolutionRepositoryException: $message';
}

class SolutionRepository {
  final String _baseUrl = dotenv.get('BASE_BACKEND_URL');

  Future<bool> createSolution(
    String token,
    CreateSolutionRequestDto createRequest,
  ) async {
    final url = Uri.parse('$_baseUrl/solution');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer $token",
        },
        body: jsonEncode(createRequest.toJson()),
      );
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return true;
      } else {
        throw SolutionRepositoryException(
          "Falha ao buscar soluções: Servidor ou Problema de conexão",
        );
      }

    } catch (e) {
      if (e is SolutionRepositoryException) {
        rethrow;
      }
      return false;
    }
  }

  Future<List<GetAllSolutionsResponseDto>> fetchSolutions(
    String token,
    String problemId,
  ) async {
    final url = Uri.parse('$_baseUrl/solutions/problem/app/$problemId');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer $token",
        },
      );
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = responseData["data"] as List<dynamic>;
        List<GetAllSolutionsResponseDto> solutions = result
            .map((e) => GetAllSolutionsResponseDto.fromJson(e))
            .toList();
        return solutions;
      } else {
        throw SolutionRepositoryException(
          "Falha ao buscar soluções: Servidor ou Problema de conexão",
        );
      }
    } catch (e) {
      if (e is SolutionRepositoryException) {
        rethrow;
      }
      return [];
    }
  }

  Future<List<GetMySolutionsResponseDto>> fetchMySolutions() async {
    await Future.delayed(Duration(seconds: 3));
    return getMockMySolutions();
  }

  Future<void> reactSolution(String token, ReactSolutionRequestDto requestDto) {
    final url = Uri.parse('$_baseUrl/solution/reaction');
    try {
      return http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer $token",
        },
        body: jsonEncode(requestDto.toJson()),
      );
    } catch (e) {
      throw SolutionRepositoryException(
        "Falha ao reagir à solução: Servidor ou Problema de conexão",
      );
    }
  }

  Future<bool> approveSolution(
    String token,
    String solutionId,
    String problemID,
  ) async {
    final url = Uri.parse('$_baseUrl/solution/approve');
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer $token",
        },
        body: jsonEncode({"solution_id": solutionId, "problem_id": problemID}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw SolutionRepositoryException(
        "Falha ao aprovar a solução: Servidor ou Problema de conexão",
      );
    }
  }

  Future<Solution?> fetchSolutionById(String solutionId) async {
    final url = Uri.parse('$_baseUrl/solutions/$solutionId');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final solutionData = responseData["data"];
        return Solution.fromJson(solutionData);
      } else {
        throw SolutionRepositoryException(
          "Falha ao buscar solução: Servidor ou Problema de conexão",
        );
      }
    } catch (e) {
      if (e is SolutionRepositoryException) {
        rethrow;
      }
    }
  }

  Future<bool> updateSolution(
    String token,
    UpdateSolutionRequestDto updateRequest,
  ) async {
    final url = Uri.parse('$_baseUrl/solution');
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer ${token}",
        },
        body: jsonEncode(updateRequest.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw SolutionRepositoryException(
          "Falha ao atualizar solução: Servidor ou Problema de conexão",
        );
      }
    } catch (e) {
      if (e is SolutionRepositoryException) {
        rethrow;
      }
      throw SolutionRepositoryException("Erro inesperado ao atualizar solução");
    }
  }

  Future<bool> deleteSolution(String token, String solutionId) async {
    final url = Uri.parse('$_baseUrl/solution');
    try {
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer ${token}",
        },
        body: jsonEncode({'id': solutionId}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw SolutionRepositoryException(
          "Falha ao deletar solução: Servidor ou Problema de conexão",
        );
      }
    } catch (e) {
      if (e is SolutionRepositoryException) {
        rethrow;
      }
      return false;
    }
  }
}
