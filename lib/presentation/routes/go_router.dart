import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/presentation/views/home_screen.dart';
import 'package:roadmap/presentation/views/splash_screen.dart';

final goRouterProvider = Provider(
  (ref) {
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
    return GoRouter(
      initialLocation: '/splash',
      routes: routes,
    );
  },
);
