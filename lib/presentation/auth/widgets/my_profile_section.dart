import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/presentation/auth/controllers/my_profile_controller.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';
import 'package:resolution_app/presentation/commom_widgets/my_confirm_action.dart';
import 'package:resolution_app/presentation/commom_widgets/my_confirm_dialog.dart';
import 'package:resolution_app/presentation/commom_widgets/my_error_widget.dart';
import 'package:resolution_app/presentation/commom_widgets/my_loading_widget.dart';

class MyProfileSection extends StatefulWidget {
  const MyProfileSection({super.key});

  @override
  State<MyProfileSection> createState() => _MyProfileSectionState();
}

class _MyProfileSectionState extends State<MyProfileSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyProfileController>(
      builder: (context, controller, child) {
        final theme = Theme.of(context);
        if (controller.isLoading) {
          return MyLoadingWidget();
        } else if (controller.user == null) {
          return MyErrorWidget(
            baseMessage: "Usuario Não encontrado! Faça login NOvamente",
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: (){controller.setEditMode();},
                    icon: Icon(
                      size: theme.textTheme.headlineLarge?.fontSize,
                      color: theme.primaryColorDark,
                      controller.editMode ? Icons.close : Icons.edit_outlined,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: theme.primaryColorLight,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: theme.primaryColor,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "${controller.user?.login}",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.user!.email,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    enabled: controller.editMode,
                    label: controller.editMode ? Text("Nome") : null,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: controller.documentController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.badge_outlined),
                    enabled: false,
                    label: controller.editMode ? Text("Documento") : null,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: controller.loginController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.login),
                    enabled: controller.editMode,
                    label: controller.editMode ? Text("Login") : null,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    enabled: false,
                    label: controller.editMode ? Text("Email") : null,
                  ),
                ),
                SizedBox(height: 20),
                MyFormButton(
                  text: "Salvar",
                  onPressed: controller.editMode
                      ? () async {
                          final String? password = await myConfirmDialogMessage(
                            context: context,
                            title: "Confirmar Alterações",
                            message:
                                "Digite sua senha para confirmar as alterações.",
                            cancelMessage: "Cancelar",
                            confirmMessage: "Salvar",
                            labelText: "Senha",
                            passwordController: controller.passwordController,
                          );
                          if (password !=null){
                            controller.handleEditProfileSubmit();
                          }
                        }
                      : null,
                  isLoading: controller.loadSubmit,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
