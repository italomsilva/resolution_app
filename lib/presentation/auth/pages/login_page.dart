import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/presentation/auth/controllers/login_controller.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';
import 'package:resolution_app/repositories/user_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginController(
        Provider.of<UserRepository>(context, listen: false),
        Provider.of<AuthController>(context, listen: false),
      ),
      child: Builder(
        builder: (context) {
          final LoginController controller = Provider.of<LoginController>(
            context,
            listen: false,
          );
          final theme = Theme.of(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Icon(
                        Icons.lock_person,
                        size: 60,
                        color: theme.colorScheme.primary,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: controller.loginController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Usuário',
                          hintText: 'exemplo01',
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: controller.validateLogin,
                      ),
                      const SizedBox(height: 20),
                      Consumer<LoginController>(
                        builder:
                            (
                              BuildContext context,
                              LoginController value,
                              Widget? child,
                            ) {
                              return TextFormField(
                                controller: controller.passwordController,
                                obscureText: !(controller.passVisible),
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  hintText: 'Sua senha',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: controller.togglePasswordVisible,
                                    icon: controller.passVisible
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                  ),
                                ),
                                validator: controller.validatePassword,
                              );
                            },
                      ),
                      const SizedBox(height: 30),
                      Consumer<LoginController>(
                        builder: (context, value, child) {
                          return MyFormButton(
                            text: 'Entrar',
                            isLoading: controller.isLoading,
                            onPressed: () {
                              controller.handleLogin(context);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          context.push("/register");
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Não tem uma conta? Crie uma!',
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextButton(
                        onPressed: () {
                          print('Esqueceu a senha? Clicado!');
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Esqueceu a senha?',
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
