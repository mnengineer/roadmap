import 'package:go_router/go_router.dart';
import 'package:roadmap/presentation/views/home_screen.dart';
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
