import 'package:flutter/material.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/user_repository.dart';

class RegisterController extends ChangeNotifier {
  final UserRepository _userRepository;
  final AuthController _authController;
  RegisterController(this._userRepository, this._authController);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController documentController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  int _profileTypeValue = 1;
  int get profileTypeValue => _profileTypeValue;

  void changeProfileType(int? value) {
    if (value != null) {
      _profileTypeValue = value;
      notifyListeners();
    }
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void handleRegister() {}
  void resolveLogin(context) async {}
  String? validateName(String? value) {
    return null;
  }

  String? validateEmail(String? value) {
    return null;
  }

  String? validateDocument(String? value) {
    return null;
  }

  String? validateProfile(String? value) {
    return null;
  }

  String? validateLogin(String? value) {
    return null;
  }

  String? validatePassword(String? value) {
    return null;
  }
}
