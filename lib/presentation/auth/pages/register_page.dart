import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/presentation/auth/controllers/register_controller.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.keyboard_arrow_left_sharp),
        ),
        title: Text("Registrar-se"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Consumer<RegisterController>(
          builder: (context, controller, child) {
            return Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Nome Completo',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: controller.validateName,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'email@exemplo.com',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.documentController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Documento',
                      hintText: '12345678900',
                      prefixIcon: Icon(Icons.account_box),
                    ),
                    validator: controller.validateDocument,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: controller.loginController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Login',
                      hintText: 'exemplo01',
                      prefixIcon: Icon(Icons.account_circle),
                    ),
                    validator: controller.validateLogin,
                  ),
                  const SizedBox(height: 20),
                  Consumer<RegisterController>(
                    builder:
                        (
                          BuildContext context,
                          RegisterController value,
                          Widget? child,
                        ) {
                          return TextFormField(
                            controller: controller.passwordController,
                            obscureText: !(controller.isPasswordVisible),
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              hintText: 'Sua senha',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.togglePasswordVisibility();
                                },
                                icon: Icon(
                                  controller.isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            validator: controller.validatePassword,
                          );
                        },
                  ),
                  const SizedBox(height: 20),
                  Consumer<RegisterController>(
                    builder:
                        (
                          BuildContext context,
                          RegisterController value,
                          Widget? child,
                        ) {
                          return TextFormField(
                            controller: controller.confirmPasswordController,
                            obscureText: !(controller.isConfirmPasswordVisible),
                            decoration: InputDecoration(
                              labelText: 'Confirmar senha',
                              hintText: '',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.toggleConfirmPasswordVisibility();
                                },
                                icon: Icon(
                                  controller.isConfirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            validator: controller.validateConfirmPassword,
                          );
                        },
                  ),
                  const SizedBox(height: 30),
                  Consumer<RegisterController>(
                    builder:
                        (
                          BuildContext context,
                          RegisterController value,
                          Widget? child,
                        ) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Qual o seu tipo de perfil?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              RadioGroup(
                                groupValue: controller.profileTypeValue,
                                onChanged: controller.changeProfileType,
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      title: Text("Pessoa Física"),
                                      value: 3,
                                    ),
                                    RadioListTile(
                                      title: Text("Pessoa Jurídica"),
                                      value: 0,
                                    ),
                                    RadioListTile(
                                      title: Text("Prefeitura"),
                                      value: 2,
                                    ),
                                    RadioListTile(title: Text("ONG"), value: 1),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Consumer<RegisterController>(
                      builder: (context, registerController, child) {
                        return MyFormButton(
                          text: "Registrar",
                          isLoading: controller.isLoading,
                          onPressed: () {
                            controller.handleRegister(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
