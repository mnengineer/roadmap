import 'package:go_router/go_router.dart';
import 'package:roadmap/presentation/views/home_screen.dart';
import 'package:roadmap/presentation/views/login_screen.dart';
import 'package:roadmap/presentation/views/onboarding_screen.dart';
import 'package:roadmap/presentation/views/signup_screen.dart';
import 'package:roadmap/presentation/views/splash_screen.dart';

final routes = [
  GoRoute(
    path: '/splash',
    name: 'splash',
    builder: (context, state) {
      return const SplashScreen();
    },
  ),
  GoRoute(
    path: '/onboarding',
    name: 'onboarding',
    builder: (context, state) {
      return const OnBoardingScreen();
    },
  ),
  GoRoute(
    path: '/login',
    name: 'login',
    builder: (context, state) {
      return const LoginScreen();
    },
  ),
  GoRoute(
    path: '/signup',
    name: 'signup',
    builder: (context, state) {
      return const SignupScreen();
    },
  ),
  GoRoute(
    path: '/home',
    name: 'home',
    builder: (context, state) {
      return const HomeScreen();
    },
  ),
];

final goRouter = GoRouter(
  initialLocation: '/splash',
  routes: routes,
);
