import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/presentation/views/add_screen.dart';
import 'package:roadmap/presentation/views/detail_screen.dart';
import 'package:roadmap/presentation/views/home_screen.dart';
import 'package:roadmap/presentation/views/login_screen.dart';
import 'package:roadmap/presentation/views/onboarding_screen.dart';
import 'package:roadmap/presentation/views/signup_screen.dart';
import 'package:roadmap/presentation/views/splash_screen.dart';
import 'package:roadmap/presentation/views/welcome_screen.dart';

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
    path: '/welcome',
    name: 'welcome',
    builder: (context, state) {
      return const WelcomeScreen();
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
  GoRoute(
    path: '/add',
    name: 'add',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const AddScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
            child: child,
          );
        },
      );
    },
  ),
  GoRoute(
    path: '/detail',
    name: 'detail',
    builder: (context, state) {
      final item = state.extra as Item?;
      if (item != null) {
        return DetailScreen(item: item);
      } else {
        return const HomeScreen();
      }
    },
  ),
];

final goRouter = GoRouter(
  initialLocation: '/splash',
  routes: routes,
);
