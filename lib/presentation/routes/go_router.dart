import 'package:go_router/go_router.dart';
import 'package:roadmap/core/constants/routes.dart';
import 'package:roadmap/core/utils/helper/route_helpers.dart';
import 'package:roadmap/presentation/views/auth/login_screen.dart';
import 'package:roadmap/presentation/views/auth/signup_screen.dart';
import 'package:roadmap/presentation/views/home/add_screen.dart';
import 'package:roadmap/presentation/views/home/detail_screen.dart';
import 'package:roadmap/presentation/views/home/edit_screen.dart';
import 'package:roadmap/presentation/views/home/home_screen.dart';
import 'package:roadmap/presentation/views/onboarding/onboarding_screen.dart';
import 'package:roadmap/presentation/views/splash/splash_screen.dart';
import 'package:roadmap/presentation/views/welcome/welcome_screen.dart';

final goRouter = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    simpleRoute(
      path: Routes.splash,
      name: 'splash',
      builder: (_) => const SplashScreen(),
    ),
    simpleRoute(
      path: Routes.onboarding,
      name: 'onboarding',
      builder: (_) => const OnBoardingScreen(),
    ),
    simpleRoute(
      path: Routes.welcome,
      name: 'welcome',
      builder: (_) => const WelcomeScreen(),
    ),
    simpleRoute(
      path: Routes.login,
      name: 'login',
      builder: (_) => const LoginScreen(),
    ),
    simpleRoute(
      path: Routes.signup,
      name: 'signup',
      builder: (_) => const SignupScreen(),
    ),
    simpleRoute(
      path: Routes.home,
      name: 'home',
      builder: (_) => const HomeScreen(),
    ),
    customRoute(
      path: Routes.add,
      name: 'add',
      child: const AddScreen(),
    ),
    itemRoute(
      path: Routes.edit,
      name: 'edit',
      builder: (item) => EditScreen(item: item),
    ),
    itemRoute(
      path: Routes.detail,
      name: 'detail',
      builder: (item) => DetailScreen(item: item),
    ),
  ],
);
