import 'package:flutter/material.dart';
import 'package:resolution_app/models/enums/profile_type.dart';
import 'package:resolution_app/models/user.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/problem_repository.dart';
import 'package:resolution_app/repositories/user_repository.dart';

class ProfileController extends ChangeNotifier {
  final AuthController _authController;
  final UserRepository _userRepository;
  final ProblemRepository _problemRepository;

  ProfileController(
    this._authController,
    this._userRepository,
    this._problemRepository,
  );

  User? _currentUser = null;
  User? get currentUser => _currentUser;
  void _setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  String? _errorMessage = null;
  String? get errorMessage => _errorMessage;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  loadProfileData() {
    final newUser = User(
      id: "aloit",
      name: "aloit",
      email: "aloit@gmail.com",
      document: "12345678",
      profile: ProfileType.fromInt(1),
      login: "aloit085",
      password: "234214214312",
      token: "432432432",
    );
    _setCurrentUser(newUser);
    _isLoading = false;
    notifyListeners();
    return newUser;
  }
}
