import 'package:resolution_app/dto/user/register_user_request_dto.dart';
import 'package:resolution_app/models/user.dart';
import 'package:resolution_app/repositories/user_repository.dart';
import 'package:resolution_app/mocks/mock_data.dart';

class UserRepositoryMock extends UserRepository {
  List<User> get _mockUsers => MockData.mockUsers;

  @override
  Future<User?> login(String login, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _mockUsers.firstWhere(
        (u) => u.login == login && u.password == password,
      );
    } catch (_) {
      throw UserException(
        'Credenciais inválidas. Verifique seu login e senha.',
      );
    }
  }

  @override
  Future<User> fetchUserById(id, token) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _mockUsers.firstWhere((u) => u.id == id);
    } catch (_) {
      throw UserException('GetUserById: erro ao buscar usuario pelo Id.');
    }
  }

  @override
  Future<User?> create(RegisterUserRequestDto user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_mockUsers.any((u) => u.login == user.login)) {
      throw UserException("Erro no Cadastro: Este Login já está em uso");
    }
    if (_mockUsers.any((u) => u.document == user.document)) {
      throw UserException("Erro no Cadastro: Este documento já está em uso");
    }

    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: user.name,
      email: user.email,
      document: user.document,
      profile: user.profile,
      login: user.login,
      password: user.password,
      token: 'fake-jwt-token-${DateTime.now().millisecondsSinceEpoch}',
    );
    _mockUsers.add(newUser);
    return newUser;
  }

  @override
  Future<User?> update({
    required String token,
    String? name,
    String? login,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockUsers.indexWhere(
      (u) => "Bearer ${u.token}" == token || u.token == token,
    );
    if (index == -1) {
      throw UserException('Atualização falhou: Usuário não encontrado');
    }

    final current = _mockUsers[index];
    final updatedUser = User(
      id: current.id,
      name: name ?? current.name,
      email: current.email,
      document: current.document,
      profile: current.profile,
      login: login ?? current.login,
      password: password,
      token: current.token,
    );
    _mockUsers[index] = updatedUser;
    return updatedUser;
  }
}
