import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/presentation/views/home_screen.dart';

final goRouterProvider = Provider(
  (ref) {
    final routes = [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
    ];
    return GoRouter(
      initialLocation: '/home',
      routes: routes,
    );
  },
);
