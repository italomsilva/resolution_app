import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resolution_app/dto/user/register_user_request_dto.dart';
import 'package:resolution_app/models/enums/profile_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:resolution_app/models/user.dart';

class UserException implements Exception {
  final String message;
  UserException(this.message);

  @override
  String toString() => 'UserException: $message';
}

class UserRepository {
  final String _baseUrl = dotenv.get('BASE_BACKEND_URL');

  Future<User?> login(String login, String password) async {
    final url = Uri.parse('$_baseUrl/sign-in');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
        },
        body: jsonEncode(<String, String>{
          'login': login,
          'password': password,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return User.fromJson(responseData["data"]);
      } else if ((response.statusCode == 401) &&
          (responseData["message"] == "Invalid login or password")) {
        throw UserException(
          'Credenciais inválidas. Verifique seu login e senha.',
        );
      } else {
        print(responseData["message"]);
        throw UserException("Login falhou: Servidor ou Problema de conexão");
      }
    } catch (e) {
      if (e is UserException) {
        rethrow;
      }
      throw UserException("Login falhou: Erro inesperado no Login");
    }
  }

  Future<User> fetchUserById(id, token) async {
    final url = Uri.parse("$_baseUrl/user/$id");

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
        },
      );
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return User.fromJson(responseData["data"]);
      } else {
        throw UserException(
          'GetUserById: erro ao buscar usuario pelo Id. Erro: ${responseData["message"]}',
        );
      }
    } catch (e) {
      print("GetUserById: erro ao buscar usuario pelo Id: $e");

      if (e is UserException) {
        rethrow;
      }
      throw UserException(
        'Não foi possível conectar ao servidor. Verifique sua conexão.',
      );
    }
  }

  Future<User?> create(RegisterUserRequestDto user) async {
    final url = Uri.parse("$_baseUrl/sign-up");

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
        },
        body: jsonEncode(<String, dynamic>{
          'name': user.name,
          'email': user.email,
          'document': user.document,
          'profile': user.profile.value,
          'login': user.login,
          'password': user.password,
        }),
      );
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return User.fromJson(responseData["data"]);
      } else if (response.statusCode == 409) {
        if (responseData["message"] == "Login already in use") {
          throw UserException("Erro no Cadastro: Este Login já está em uso");
        } else if (responseData["message"] == "Document already in use") {
          throw UserException(
            "Erro no Cadastro: Este documento já está em uso",
          );
        }
      } else {
        throw UserException("Cadastro falhou: Servidor ou Problema de conexão");
      }
    } catch (e) {
      if (e is UserException) {
        rethrow;
      }
      throw UserException("Cadastro falhou: Erro inesperado no Cadastro $e");
    }
  }

  Future<User?> update({
    required String token,
    String? name,
    String? login,
    required String password,
  }) async {
    final url = Uri.parse("$_baseUrl/user");

    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'go-api-key': dotenv.get('API_KEY_VALUE'),
          'req-token': "Bearer ${token}",
        },
        body: jsonEncode(<String, dynamic>{
          if (name != null) 'name': name,
          if (login != null) 'login': login,
          'password': password,
        }),
      );
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseData["data"] != null
            ? User.fromJson(responseData["data"])
            : null;
      } else {
        throw UserException("Atualização falhou: ${responseData["message"]}");
      }
    } catch (e) {
      if (e is UserException) {
        rethrow;
      }
      throw UserException("Atualização falhou: Erro inesperado na atualização");
    }
  }
}
