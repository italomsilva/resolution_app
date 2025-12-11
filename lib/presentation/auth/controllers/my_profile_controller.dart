import 'package:flutter/material.dart';
import 'package:resolution_app/dto/problem/stats_count_problem_status_response.dart';
import 'package:resolution_app/dto/solution/get_my_solutions_response.dart';
import 'package:resolution_app/dto/solution/get_solutions_reactions.dart';
import 'package:resolution_app/mocks/problems_count.dart';
import 'package:resolution_app/models/enums/profile_type.dart';
import 'package:resolution_app/models/problems.dart';
import 'package:resolution_app/models/user.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/problem_repository.dart';
import 'package:resolution_app/repositories/solution_repository.dart';
import 'package:resolution_app/repositories/user_repository.dart';

class MyProfileController extends ChangeNotifier {
  final AuthController _authController;
  final UserRepository _userRepository;
  final ProblemRepository _problemRepository;
  final SolutionRepository _solutionRepository;

  MyProfileController(
    this._authController,
    this._userRepository,
    this._problemRepository,
    this._solutionRepository,
  );

  User? _user;
  User? get user => _user;
  void _setUser(User user) {
    _user = user;
    notifyListeners();
  }

  List<StatsCountProblemStatusResponse> problemStats = [];
  List<StatsCountSolutionsReactionsResponse> dataSolutions = [];

  List<Problem>? _problems;
  List<Problem>? get problems => _problems;

  List<GetMySolutionsResponseDto>? _solutions;
  List<GetMySolutionsResponseDto>? get solutions => _solutions;

  TextEditingController nameController = TextEditingController();
  TextEditingController documentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void initControllers() {
    final currentUser = user;
    if (currentUser != null) {
      nameController.text = currentUser.name;
      documentController.text = currentUser.document;
      emailController.text = currentUser.email;
      loginController.text = currentUser.login;
    }
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _problemStatsLoading = true;
  bool get problemStatsLoading => _problemStatsLoading;
  bool _solutionStatsLoading = true;
  bool get solutionStatsLoading => _solutionStatsLoading;

  bool _isDisposed = false;
  void _safeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  bool _editMode = false;
  bool get editMode => _editMode;

  bool _loadSubmit = false;
  bool get loadSubmit => _loadSubmit;
  void setLoadSubmit(value) {
    _loadSubmit = value;
    _safeNotifyListeners();
  }

  bool _problemsLoading = false;
  bool get problemsLoading => _problemsLoading;
  void setProblemsLoading(value) {
    _problemsLoading = value;
    _safeNotifyListeners();
  }

  bool _seeProblems = false;
  bool get seeProblems => _seeProblems;

  bool _solutionsLoading = false;
  bool get solutionsLoading => _solutionsLoading;
  void setSolutionsLoading(value) {
    _solutionsLoading = value;
    _safeNotifyListeners();
  }

  bool _seeSolutions = false;
  bool get seeSolutions => _seeSolutions;

  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  Future<User> loadProfileData() async {
    final user = _authController.currentUser;
    final userFromDb = await _userRepository.fetchUserById(
      _authController.currentUser!.id,
      _authController.currentUser!.token,
    );

    if (userFromDb != null) {
      _authController.login(userFromDb);
      _setUser(userFromDb);
      _isLoading = false;
      _safeNotifyListeners();
      initControllers();
      loadProblemStats();
      loadSolutionStats();
      _safeNotifyListeners();
    }
    return userFromDb;
  }

  void loadProblemStats() async {
    _problemStatsLoading = true;
    _safeNotifyListeners();
    problemStats = await _problemRepository.statsCountProblemStatus(
      _authController.currentUser!.token,
    );
    if (problemStats.isEmpty == true) {
      problemStats = [];
      _safeNotifyListeners();
    }
    _problemStatsLoading = false;
    _safeNotifyListeners();
  }

  void loadSolutionStats() async {
    _solutionStatsLoading = true;
    _safeNotifyListeners();
    dataSolutions = [];
    if (dataSolutions.isEmpty == true) {
      dataSolutions = await _solutionRepository.statsCountSolutionsReactions(
        _authController.currentUser!.token,
      );
      _safeNotifyListeners();
    }
    _solutionStatsLoading = false;
    _safeNotifyListeners();
  }

  void setEditMode({bool? value}) {
    _editMode = value ?? !_editMode;
    _safeNotifyListeners();
  }

  void handleEditProfileSubmit() async {
    final User? userUpdated = await _userRepository.update(
      token: user!.token,
      name: nameController.text == user!.name ? null : nameController.text,
      login: loginController.text == user!.login ? null : loginController.text,
      password: passwordController.text,
    );
    if (userUpdated != null) {
      _setUser(
        User(
          id: user!.id,
          name: nameController.text,
          email: user!.email,
          document: user!.document,
          profile: user!.profile,
          login: loginController.text,
          password: user!.password,
          token: user!.token,
        ),
      );
      setEditMode(value: false);
      _authController.login(userUpdated);
    }
  }

  void handleLogout() {
    _authController.logout(clearData: true);
  }

  void handleSeeProblems() async {
    setProblemsLoading(true);
    final List<Problem> problems = await _problemRepository.fetchMyProblems(
      user!.token,
    );
    _problems = problems;
    _safeNotifyListeners();
    setProblemsLoading(false);
    _seeProblems = true;
    _safeNotifyListeners();
  }

  void handleSeeSolutions() async {
    setSolutionsLoading(true);
    final List<GetMySolutionsResponseDto> solutions = await _solutionRepository
        .fetchMySolutions(_authController.currentUser!.token);
    _solutions = solutions;
    _safeNotifyListeners();
    setSolutionsLoading(false);
    _seeSolutions = true;
    _safeNotifyListeners();
  }

  Future<bool> deleteProblem(String problemId) async {
    final bool result = await _problemRepository.deleteProblem(
      _authController.currentUser!.token,
      problemId,
    );
    return result;
  }

  Future<bool> deleteSolution(String solutionId) async {
    final bool result = await _solutionRepository.deleteSolution(
      _authController.currentUser!.token,
      solutionId,
    );
    return result;
  }

  void handleRefresh(int value) {}

  String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
