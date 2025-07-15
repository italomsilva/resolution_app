import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/user_repository.dart';

class LoginController extends ChangeNotifier {
  final UserRepository _userRepository;
  final AuthController _authController;

  LoginController(this._userRepository, this._authController);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _passVisible = false;
  bool get passVisible => _passVisible;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void togglePasswordVisible() {
    _passVisible = !_passVisible;
    notifyListeners();
  }

  Future<void> handleLogin(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    _setLoading(true);
    final String login = loginController.text;
    final String password = passwordController.text;

    try {
      final user = await _userRepository.login(login, password);
      if (!context.mounted) return;

      if (user != null) {
        await _authController.login(user);

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
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login falhou: Credenciais inválidas")),
        );
      }
    } finally {
      if (context.mounted) {
        _setLoading(false);
      }
    }
  }

  String? validateLogin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }
    final RegExp loginRegex = RegExp(r"^[a-zA-Z0-9]+$");
    if (!loginRegex.hasMatch(value)) {
      return 'O login deve conter apenas letras (sem acento) e números.';
    }
    if (value.length < 5) {
      return 'Seu login deve ter no mínimo 5 caracteres.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }
    if (value.length < 8) {
      return 'Sua senha deve ter no mínimo 8 caracteres';
    }
    return null;
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
