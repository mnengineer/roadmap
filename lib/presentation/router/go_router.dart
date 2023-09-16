import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/presentation/router/screen_path.dart';
import 'package:roadmap/presentation/screens/edit.dart';
import 'package:roadmap/presentation/screens/list.dart';

final goRouterProvider = Provider(
  (ref) {
    final routes = [
      GoRoute(
        path: ScreenId.list.path,
        name: ScreenId.list.routeName,
        builder: (context, state) {
          return const ListScreen();
        },
      ),
      GoRoute(
        path: ScreenId.edit.path,
        name: ScreenId.edit.routeName,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return EditScreen(memoId: id);
        },
      ),
    ];

    return GoRouter(
      initialLocation: ScreenId.list.path,
      routes: routes,
    );
  },
);
