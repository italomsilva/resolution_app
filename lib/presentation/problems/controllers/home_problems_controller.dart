import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resolution_app/dto/problem/get_home_problems_response.dart';
import 'package:resolution_app/repositories/problem_repository.dart';

class HomeProblemsController extends ChangeNotifier {
  final ProblemRepository _problemRepository;

  HomeProblemsController(this._problemRepository){
    searchController.addListener(_onSearchChanged);
  }

  List<GetHomeProblemsResponseDto> _problems = [];
  List<GetHomeProblemsResponseDto> get problems => _problems;

  List<GetHomeProblemsResponseDto> _filteredProblems = [];
  List<GetHomeProblemsResponseDto> get filteredProblems => _filteredProblems;
  
  TextEditingController searchController = TextEditingController();
  bool _isSearching = false;
  bool get isSearching => _isSearching;

  String? _errorMessage = "Deu problema aq lek";
  String? get errorMessage => _errorMessage;

  bool _isLoading = true;
  bool get isLoading => _isLoading;


  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

void toggleSearching() {
    _isSearching = !_isSearching;
    if (!_isSearching) {
      searchController.clear();
      filterProblems(searchController.text); 
    }
    notifyListeners();
  }
  
    void filterProblems(String query) {
    query = query.toLowerCase();
    
    if (query.isEmpty) {
      _filteredProblems = List.from(_problems); 
    } else {
      _filteredProblems = _problems.where((problem) {
        return problem.title.toLowerCase().contains(query) ||
            problem.description.toLowerCase().contains(query) ||
            problem.userLogin.toLowerCase().contains(query) ||
            problem.location.toLowerCase().contains(query);
      }).toList();
    }
    notifyListeners();
  }

  void _onSearchChanged() {
    filterProblems(searchController.text);
  }
  
  Future<void> fetchProblems() async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final fetchedProblems = await _problemRepository.fetchProblems();
      _problems = fetchedProblems;
      
      filterProblems(searchController.text);
      
    } catch (e) {
      _setErrorMessage('Não foi possível carregar os problemas: ${e.toString()}');
      _problems = [];
    } finally {
      _setLoading(false);
    }
  }

  void handleProblemCard(BuildContext context, String problemId) {
    context.push('/problem/$problemId');
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }
}