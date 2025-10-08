import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/presentation/auth/controllers/login_controller.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Consumer<LoginController>(
            builder: (context, controller, child) {
              final ThemeData theme = Theme.of(context);
              return Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Icon(
                      Icons.lock_person,
                      size: 60,
                      color: theme.primaryColor,
                    ),
                    Text(
                      "Login",
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
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
                    TextFormField(
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
                    ),
                    const SizedBox(height: 20),
                    MyFormButton(
                      text: 'Entrar',
                      isLoading: controller.isLoading,
                      onPressed: () {
                        controller.handleLogin(context);
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
                      child: Text('Não tem uma conta? Crie uma!'),
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
                      child: Text('Esqueceu a senha?'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
