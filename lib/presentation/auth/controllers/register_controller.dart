import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resolution_app/dto/user/register_user_request_dto.dart';
import 'package:resolution_app/models/enums/profile_type.dart';
import 'package:resolution_app/models/user.dart';
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
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _isConfirmPasswordVisible = false;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

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

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void handleRegister(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final userInput = new RegisterUserRequestDto(
      name: nameController.text,
      email: emailController.text,
      document: documentController.text,
      profile: ProfileType.fromInt(profileTypeValue),
      login: loginController.text,
      password: passwordController.text,
    );
    try {
      final user = await _userRepository.create(userInput);
      if (!context.mounted) return;

      if (user != null) {
        _authController.login(user);
        if (context.mounted) {
          context.go('/problems');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login falhou: Servidor ou Problema de conexão"),
          ),
        );
      }
    } catch (e) {
      if (context.mounted && e is UserException) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      if (context.mounted) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  String? validateName(String? value) {
    _authController;
    _userRepository;
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }
    return null;
  }

  String? validateDocument(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }
    return null;
  }

  String? validateProfile(String? value) {
    return null;
  }

  String? validateLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }
    if (value.length < 5) {
      return 'Sua senha deve ter no mínimo 8 caracteres';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }
    if (value != passwordController.text) {
      return "Senhas não coincidem";
    }
    return null;
  }
}
