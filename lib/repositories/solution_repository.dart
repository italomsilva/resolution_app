import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:resolution_app/dto/solution/get_all_solutions.dart';
import 'package:resolution_app/dto/solution/get_my_solutions_response.dart';
import 'package:resolution_app/mocks/get_all_solutions.dart';
import 'package:resolution_app/mocks/get_my_solutions.dart';

class SolutionRepositoryException implements Exception {
  final String message;
  SolutionRepositoryException(this.message);

  @override
  String toString() => 'SolutionRepositoryException: $message';
}

class SolutionRepository {
  final String _baseUrl = dotenv.get('BASE_BACKEND_URL');

  Future<List<GetAllSolutionsResponseDto>> fetchSolutions() async {
    await Future.delayed(const Duration(seconds: 3));
    return getMockAllSolutions();
  }

  Future<List<GetMySolutionsResponseDto>> fetchMySolutions() async {
    await Future.delayed(Duration(seconds: 3));
    return getMockMySolutions();
  }
}
