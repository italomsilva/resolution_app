import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:resolution_app/dto/problem/get_home_problems_response.dart';
import 'package:resolution_app/dto/problem/update_problem_request.dart';
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

  Future<List<GetHomeProblemsResponseDto>> fetchProblems({
    String? token,
  }) async {
    final url = Uri.parse('$_baseUrl/problems/app');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer ${token}",
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = responseData["data"] as List<dynamic>;
        List<GetHomeProblemsResponseDto> problems = result
            .map((e) => GetHomeProblemsResponseDto.fromJson(e))
            .toList();

        problems.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        return problems;
      } else {
        print(responseData);
        throw ProblemRepositoryException(
          "Falha ao buscar problemas: Servidor ou Problema de conexão",
        );
      }
    } catch (e) {
      if (e is ProblemRepositoryException) {
        rethrow;
      }
      throw ProblemRepositoryException("Erro inesperado ao buscar problemas");
    }
  }

  Future<List<Problem>> fetchMyProblems(String token) async {
    final url = Uri.parse('$_baseUrl/problems/user');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer ${token}",
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = responseData["data"] as List<dynamic>;
        return result.map((e) => Problem.fromJson(e)).toList();
      } else {
        print(responseData);
        throw ProblemRepositoryException(
          "Falha ao buscar problemas: Servidor ou Problema de conexão",
        );
      }
    } catch (e) {
      if (e is ProblemRepositoryException) {
        rethrow;
      }
      throw ProblemRepositoryException("Erro inesperado ao buscar problemas");
    }
  }

  Future<bool> createProblem(
    String token,
    String title,
    String description,
    String location,
  ) async {
    final url = Uri.parse('$_baseUrl/problem');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer ${token}",
        },
        body: jsonEncode({
          'title': title,
          'description': description,
          'location': location,
        }),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        throw ProblemRepositoryException(
          "Falha ao adicionar problema: Servidor ou Problema de conexão",
        );
      }
    } catch (e) {
      if (e is ProblemRepositoryException) {
        rethrow;
      }
      throw ProblemRepositoryException("Erro inesperado ao buscar problemas");
    }
  }

  Future<GetHomeProblemsResponseDto?> fetchProblemById(String problemId) async {
    final url = Uri.parse('$_baseUrl/problem/app/$problemId');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final result = responseData["data"] as Map<String, dynamic>;
        return GetHomeProblemsResponseDto.fromJson(result);
      } else {
        print(responseData);
        throw ProblemRepositoryException(
          "Falha ao buscar problema: Servidor ou Problema de conexão",
        );
      }
    } catch (e) {
      if (e is ProblemRepositoryException) {
        rethrow;
      }
      throw ProblemRepositoryException("Erro inesperado ao buscar problema");
    }
  }

  Future<bool> updateProblem(
    String token,
    UpdateProblemRequest updateRequest,
  ) async {
    final url = Uri.parse('$_baseUrl/problem');
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
        throw ProblemRepositoryException(
          "Falha ao atualizar problema: Servidor ou Problema de conexão",
        );
      }
    } catch (e) {
      if (e is ProblemRepositoryException) {
        rethrow;
      }
      throw ProblemRepositoryException("Erro inesperado ao atualizar problema");
    }
  }

  Future<bool> deleteProblem(String token, String problemId) async {
    final url = Uri.parse('$_baseUrl/problem');
    try {
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer ${token}",
        },
        body: jsonEncode({'id': problemId}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ProblemRepositoryException(
          "Falha ao deletar problema: Servidor ou Problema de conexão",
        );
      }
    } catch (e) {
      if (e is ProblemRepositoryException) {
        rethrow;
      }
      return false;
    }
  }
}
