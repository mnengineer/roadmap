import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/presentation/views/splash_screen.dart';
import 'package:roadmap/presentation/views/tabs/home_tab.dart';
import 'package:roadmap/presentation/views/tabs/stats_tab.dart';
import 'package:roadmap/presentation/views/welcome_screen.dart';
import 'package:roadmap/presentation/widgets/add_item_dialog.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = useState(0);
    final borderRadiusAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    )..forward();

    Widget tabContent() {
      switch (tabIndex.value) {
        case 0:
          return const HomeTab();
        case 1:
          return const StatsTab();
        default:
          return Container();
      }
    }

    final iconList = <IconData>[
      Icons.home,
      Icons.bar_chart,
    ];

    final authStateAsyncValue = ref.watch(authStateProvider);

    return authStateAsyncValue.when(
      data: (user) {
        if (user != null) {
          return Scaffold(
            body: tabContent(),
            floatingActionButton: tabIndex.value != 1
                ? FloatingActionButton(
                    onPressed: () => AddItemDialog.show(context, Item.empty()),
                    child: const Icon(Icons.add),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              itemCount: iconList.length,
              tabBuilder: (int index, bool isActive) {
                final color = isActive ? Colors.white : Colors.grey;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconList[index],
                      size: 24,
                      color: color,
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        index == 0 ? 'Home' : 'Stats',
                        style: TextStyle(color: color),
                      ),
                    ),
                  ],
                );
              },
              backgroundColor: Colors.grey[900],
              activeIndex: tabIndex.value,
              splashColor: Colors.white,
              notchAndCornersAnimation: borderRadiusAnimationController,
              splashSpeedInMilliseconds: 300,
              notchSmoothness: NotchSmoothness.defaultEdge,
              gapLocation: GapLocation.center,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              onTap: (index) => tabIndex.value = index,
            ),
          );
        }
        return const WelcomeScreen();
      },
      loading: () => const SplashScreen(),
      error: (error, _) => Text(error.toString()),
    );
  }
}
