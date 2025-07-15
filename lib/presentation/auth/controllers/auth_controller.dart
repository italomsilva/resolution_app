import 'package:flutter/material.dart';
import 'package:resolution_app/models/user.dart';
import 'package:resolution_app/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _userTokenKey = 'user_token';
const String _userIdKey = 'user_id';
const String _userProfileKey = 'user_profile';

class AuthController extends ChangeNotifier {
  final UserRepository _userRepository;
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = true;

  AuthController(this._userRepository) {
    _checkLoginStatus();
  }

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setLoggedInUser(User? user) {
    _currentUser = user;
    _isLoggedIn = user != null;
    notifyListeners();
  }

  Future<void> _checkLoginStatus() async {
    _setLoading(true);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_userTokenKey);
    final userId = prefs.getString(_userIdKey);
    final userProfileInt = prefs.getInt(_userProfileKey);

    if (token != null && userId != null && userProfileInt != null) {
      print(
        'Token e ID encontrados. Tentando buscar dados do usuário na API...',
      );
      try {
        final fetchedUser = _userRepository.fetchUserById(userId, token);
        _setLoggedInUser(fetchedUser);
        print('Auto-login bem-sucedido com dados reais!');
      } on LoginException catch (e) {
        print('Falha na validação do token ou busca de usuário: ${e.message}');
        await logout();
      } catch (e) {
        print('Erro inesperado durante a busca de usuário para auto-login: $e');
        await logout();
      }
    } else {
      print('Nenhum token ou ID encontrado. Usuário não logado.');
      _setLoggedInUser(null);
    }
    _setLoading(false);
  }

  Future<void> login(User user) async {
    _setLoading(true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTokenKey, user.token);
    await prefs.setString(_userIdKey, user.id);
    await prefs.setInt(
      _userProfileKey,
      user.profile.value,
    ); 
    _setLoggedInUser(user); 
    _setLoading(false);
    print('Usuário ${user.name} logado e dados salvos.');
  }

  Future<void> logout() async {
    _setLoading(true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userTokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userProfileKey);
    _setLoggedInUser(null);
    _setLoading(false);
    print('Usuário deslogado e dados limpos.');
  }
}
