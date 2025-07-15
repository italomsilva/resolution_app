import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/presentation/auth/pages/login_page.dart';
import 'package:resolution_app/presentation/auth/pages/profile_page.dart';
import 'package:resolution_app/presentation/auth/pages/register_page.dart';
import 'package:resolution_app/presentation/layout/main_scaffold.dart';
import 'package:resolution_app/presentation/problems/controllers/home_problems_controller.dart';
import 'package:resolution_app/presentation/problems/pages/add_problem_page.dart';
import 'package:resolution_app/presentation/problems/pages/home_problems_page.dart';
import 'package:resolution_app/presentation/splash/splash_screen.dart';
import 'package:resolution_app/repositories/problem_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static late final GoRouter _router;
  static bool _isInitialized = false;

  static GoRouter get router {
    return _router;
  }

  static Future<void> initialize(BuildContext context) async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('first_launch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('first_launch', false);
    }

    final authController = Provider.of<AuthController>(context, listen: false);

    String initialRoute;
    if (isFirstLaunch) {
      initialRoute = '/splash';
    } else {
      initialRoute = authController.isLoggedIn ? '/problems' : '/login';
    }

    _router = GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        // ---------------------------------------------------------------------
        // ALTERAÇÃO 1: Mudar ShellRoute para StatefulShellRoute.indexedStack
        // Isso é crucial para preservar o estado das abas (páginas e controllers).
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            // navigationShell é o widget que gerencia as abas.
            // Passamos para MainScaffold para que ele controle a navegação interna.
            return MainScaffold(navigationShell: navigationShell);
          },
          branches: [
            // ALTERAÇÃO 2: Cada grupo de rotas da sua Bottom Navigation Bar
            // deve ser uma StatefulShellBranch.
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/problems',
                  builder: (context, state) {
                    return ChangeNotifierProvider<HomeProblemsController>(
                      create: (context) => HomeProblemsController(
                        Provider.of<ProblemRepository>(context, listen: false),
                      ),
                      child: const HomeProblemsPage(),
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/add_problem",
                  builder: (context, state) {
                    // Adicione um controller aqui se AddProblemPage precisar de estado
                    return const AddProblemPage(); // Adicione 'const' se AddProblemPage for Stateless
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/profile",
                  builder: (context, state) => const ProfilePage(),
                ),
              ],
            ),
            // Se você tiver outras abas, adicione-as como StatefulShellBranch aqui.
          ],
        ),
        // ---------------------------------------------------------------------
      ],

      redirect: (context, state) {
        final authController = Provider.of<AuthController>(
          context,
          listen: false,
        );
        final isLoggedIn = authController.isLoggedIn;
        final isLoggingIn = state.matchedLocation == '/login';
        final isSplashing = state.matchedLocation == '/splash';
        final isRegistering = state.matchedLocation == '/register';

        final bool isPublicRoute = isLoggingIn || isSplashing || isRegistering;

        if (!isLoggedIn && !isPublicRoute) {
          return '/login';
        }

        if (isLoggedIn && isPublicRoute) {
          return '/problems';
        }
        return null;
      },
    );
    _isInitialized = true;
  }
}