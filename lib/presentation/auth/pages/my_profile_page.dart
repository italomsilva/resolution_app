import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/app_theme.dart';
import 'package:resolution_app/presentation/auth/controllers/my_profile_controller.dart';
import 'package:resolution_app/presentation/auth/widgets/my_problems_section.dart';
import 'package:resolution_app/presentation/auth/widgets/my_profile_section.dart';
import 'package:resolution_app/presentation/auth/widgets/my_solutions_section.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      final controller =
          Provider.of<MyProfileController>(context, listen: false);
      if (_tabController.index == 1 && controller.problems == null) {
        controller.handleSeeProblems();
      } else if (_tabController.index == 2 && controller.solutions == null) {
        controller.handleSeeSolutions();
      }
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return TabBarViewWrapper(
      tabController: _tabController,
      child: Consumer<MyProfileController>(
        builder: (context, controller, child) => Scaffold(
          appBar: AppBar(
            title: Text("Meu Perfil"),
            actions: [
              IconButton(
                onPressed: () {
                  controller.handleLogout();
                  context.go("/");
                },
                icon: Icon(Icons.logout),
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
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
                  controller: _tabController,
                  children: const [
                    MyProfileSection(),
                    MyProblemsSection(),
                    MySolutionsSection(),
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

class TabBarViewWrapper extends StatelessWidget {
  final TabController tabController;
  final Widget child;
  const TabBarViewWrapper(
      {required this.tabController, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
