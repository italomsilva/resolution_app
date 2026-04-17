import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:resolution_app/app_router.dart';
import 'package:resolution_app/app_theme.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/repositories/problem_repository.dart';
import 'package:resolution_app/repositories/mocks/problem_repository_mock.dart';
import 'package:resolution_app/repositories/solution_repository.dart';
import 'package:resolution_app/repositories/mocks/solution_repository_mock.dart';
import 'package:resolution_app/repositories/user_repository.dart';
import 'package:resolution_app/repositories/mocks/user_repository_mock.dart';
import 'package:resolution_app/presentation/problems/controllers/home_problems_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  GoRouter? _router;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserRepository>(
          create: (_) => dotenv.get('USE_MOCK', fallback: 'false') == 'true'
              ? UserRepositoryMock()
              : UserRepository(),
        ),
        Provider<ProblemRepository>(
          create: (_) => dotenv.get('USE_MOCK', fallback: 'false') == 'true'
              ? ProblemRepositoryMock()
              : ProblemRepository(),
        ),
        Provider<SolutionRepository>(
          create: (_) => dotenv.get('USE_MOCK', fallback: 'false') == 'true'
              ? SolutionRepositoryMock()
              : SolutionRepository(),
        ),
        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(
            Provider.of<UserRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<HomeProblemsController>(
          create: (context) => HomeProblemsController(
            Provider.of<ProblemRepository>(context, listen: false),
          ),
        ),
      ],
      child: Consumer<AuthController>(
        builder: (context, authController, child) {
          if (_router == null && !authController.isLoading) {
            AppRouter.initialize(context).then((_) {
              setState(() {
                _router = AppRouter.router;
              });
            });
          }

          if (authController.isLoading || _router == null) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(body: Center(child: CircularProgressIndicator())),
            );
          }

          return MaterialApp.router(
            title: 'ResolutionApp', 
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: _router!, 
          );
        },
      ),
    );
  }
}
