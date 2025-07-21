import 'package:flutter/material.dart';
import 'package:resolution_app/mocks/problems_count.dart';
import 'package:resolution_app/models/enums/profile_type.dart';
import 'package:resolution_app/models/problems.dart';
import 'package:resolution_app/models/user.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/problem_repository.dart';
import 'package:resolution_app/repositories/user_repository.dart';

class MyProfileController extends ChangeNotifier {
  final AuthController _authController;
  final UserRepository _userRepository;
  final ProblemRepository _problemRepository;
  final List<ProblemStatusChartData> dataProblem = getMockProblemChartData();
  MyProfileController(
    this._authController,
    this._userRepository,
    this._problemRepository,
  );

  User? _user;
  User? get user => _user;
  void _setUser(User user) {
    _user = user;
    notifyListeners();
  }

  List<Problem>? _problems;
  List<Problem>? get problems => _problems;

  TextEditingController nameController = TextEditingController();
  TextEditingController documentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController loginController = TextEditingController();

  void initControllers() {
    final currentUser = user;
    if (currentUser != null) {
      nameController.text = currentUser.name;
      documentController.text = currentUser.document;
      emailController.text = currentUser.email;
      loginController.text = currentUser.login;
    }
  }

  String? _errorMessage = null;
  String? get errorMessage => _errorMessage;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _editMode = false;
  bool get editMode => _editMode;

  bool _loadSubmit = false;
  bool get loadSubmit => _loadSubmit;
  void setLoadSubmit(value) {
    _loadSubmit = value;
    notifyListeners();
  }

  bool _problemsLoading = false;
  bool get problemsLoading => _problemsLoading;
  void setProblemsLoading(value) {
    _problemsLoading = value;
    notifyListeners();
  }

  bool _seeProblems = false;
  bool get seeProblems => _seeProblems;

  Future<User> loadProfileData() async {
    final user = await _authController.currentUser;
    if (user == null) {
      _isLoading = false;
      return User(
        id: "",
        name: "",
        email: "",
        document: "",
        profile: ProfileType.unknown,
        login: "",
        password: "",
        token: "",
      );
    }
    _setUser(user);
    _isLoading = false;
    notifyListeners();
    initControllers();
    return user;
  }

  void handleEdit() {
    _editMode = !editMode;
    notifyListeners();
  }

  void handleLogout() {}
  void handleSubmit() async {
    setLoadSubmit(true);
    await Future.delayed(Duration(seconds: 3));
    setLoadSubmit(false);
  }

  void handleSeeProblems() async {
    setProblemsLoading(true);
    final List<Problem> problems = await _problemRepository.fetchMyProblems();
    _problems = problems;
    notifyListeners();
    setProblemsLoading(false);
    _seeProblems = true;
    notifyListeners();
  }

  void deleteProblem() {}

  void handleRefresh(int value){}
}
