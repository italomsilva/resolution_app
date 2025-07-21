import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/app_theme.dart';
import 'package:resolution_app/presentation/auth/controllers/my_profile_controller.dart';
import 'package:resolution_app/presentation/auth/widgets/my_problems_sectioon.dart';
import 'package:resolution_app/presentation/auth/widgets/my_profile_section.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Consumer<MyProfileController>(
        builder: (context, controller, child) => Scaffold(
          appBar: AppBar(
            title: Text("Meu Perfil"),
            actions: [
              IconButton(
                onPressed: controller.loadProfileData,
                icon: Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: controller.handleLogout,
                icon: Icon(Icons.logout),
              ),
            ],
            bottom: TabBar(
              dividerColor: AppTheme.neutralColor,
              dividerHeight: 2,
              tabs: const [
                Tab(icon: Icon(Icons.person), text: "Perfil"),
                Tab(
                  icon: Icon(Icons.report_problem_outlined),
                  text: "Problemas",
                ),
                Tab(icon: Icon(Icons.lightbulb), text: "Soluções"),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: const [
                    MyProfileSection(),
                    MyProblemsSection(),
                    Center(child: Text("Conteúdo das Minhas Soluções aqui")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
