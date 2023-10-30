import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap/domain/entities/goal_item.dart';
import 'package:roadmap/presentation/views/home/home_screen.dart';
import 'package:roadmap/presentation/widgets/dialog/error_dialog.dart';

GoRoute simpleRoute({
  required String path,
  required String name,
  required WidgetBuilder builder,
}) =>
    GoRoute(
      path: path,
      name: name,
      builder: (context, state) => builder(context),
    );

GoRoute customRoute({
  required String path,
  required String name,
  required Widget child,
}) =>
    GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    );

GoRoute itemRoute({
  required String path,
  required String name,
  required Widget Function(GoalItem item) builder,
}) =>
    GoRoute(
      path: path,
      name: name,
      builder: (context, state) {
        final item = state.extra as GoalItem?;
        if (item != null) {
          return builder(item);
        }
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showDialog<void>(
            context: context,
            builder: (_) => const ErrorDialog(message: 'Item not found.'),
          ),
        );
        return const HomeScreen();
      },
    );
