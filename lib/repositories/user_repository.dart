import 'package:resolution_app/models/enums/profile_type.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:resolution_app/models/user.dart';

class LoginException implements Exception {
  final String message;
  LoginException(this.message);

  @override
  String toString() => 'LoginException: $message';
}

class UserRepository {
  final String _baseUrl = dotenv.get('BASE_BACKEND_URL');

  Future<User?> login(String login, String password) async {
    // await Future.delayed(const Duration(seconds: 3));

    _baseUrl;

    if (login == 'aaaaaaaa' && password == '11111111') {
      return User(
        id: 'jdfghkjgdkjfgkgfkdsg',
        name: 'Aloit',
        email: 'aloit085@gmail.com',
        document: '12345678900',
        profile: ProfileType.individual,
        login: 'aloit085',
        password: '1234',
        token: 'jdhfkghdgkfhgdhgjfgjkdgfhghdfghjdg',
      );
    }
    return null;
    // final url = Uri.parse('$_baseUrl/auth/login');

    // try {
    //   final response = await http.post(
    //     url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(<String, String>{
    //       'login': login,
    //       'password': password,
    //     }),
    //   );

    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> responseData = jsonDecode(response.body);
    //     return User.fromJson(responseData);
    //   } else if (response.statusCode == 401) {
    //     throw LoginException(
    //       'Credenciais inválidas. Verifique seu login e senha.',
    //     );
    //   } else {
    //     throw LoginException(
    //       'Falha ao fazer login. Tente novamente mais tarde.',
    //     );
    //   }
    // } catch (e) {
    //   print('Erro de rede ou inesperado durante o login: $e');

    //   if (e is LoginException) {
    //     rethrow;
    //   }
    //   throw LoginException(
    //     'Não foi possível conectar ao servidor. Verifique sua conexão.',
    //   );
    // }
  }

  User fetchUserById(id, token) {
    return User(
      id: "1123243434345",
      name: "Italo Monteiro Silva",
      email: "italo7777@gmail.com",
      document: "757.491.303-04",
      profile: ProfileType.individual,
      login: "aloit085",
      password: "bomberbibis",
      token: "jhdfjhsjhfjdshjfhdjsklhjhjhfjhjkhfkdsj",
    );
  }
}
