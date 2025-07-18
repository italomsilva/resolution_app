import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resolution_app/presentation/auth/controllers/auth_controller.dart';
import 'package:resolution_app/presentation/auth/controllers/profile_controller.dart';
import 'package:resolution_app/presentation/auth/pages/login_page.dart';
import 'package:resolution_app/presentation/auth/pages/profile_page.dart';
import 'package:resolution_app/presentation/auth/pages/register_page.dart';
import 'package:resolution_app/presentation/layout/main_scaffold.dart';
import 'package:resolution_app/presentation/problems/controllers/add_problem_controller.dart';
import 'package:resolution_app/presentation/problems/controllers/home_problems_controller.dart';
import 'package:resolution_app/presentation/problems/pages/add_problem_page.dart';
import 'package:resolution_app/presentation/problems/pages/home_problems_page.dart';
import 'package:resolution_app/presentation/splash/splash_screen.dart';
import 'package:resolution_app/repositories/problem_repository.dart';
import 'package:resolution_app/repositories/user_repository.dart';
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
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainScaffold(navigationShell: navigationShell);
          },
          branches: [
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
                    return ChangeNotifierProvider<AddProblemController>(
                      create: (context) => AddProblemController(
                        Provider.of<ProblemRepository>(context, listen: false),
                        Provider.of<AuthController>(context, listen: false),
                      ),
                      child: AddProblemPage(),
                    );
                  },
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: "/profile",
                  builder: (context, state) {
                    return ChangeNotifierProvider(
                      create: (context) => ProfileController(
                        Provider.of<AuthController>(context, listen: false),
                        Provider.of<UserRepository>(context, listen: false),
                        Provider.of<ProblemRepository>(context, listen: false),
                      ),
                      child: ProfilePage(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
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
