import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/presentation/views/home/tabs/home_tab_screen.dart';
import 'package:roadmap/presentation/views/home/tabs/stats_tab_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(goalViewModelProvider.notifier);
    final tabIndex = useState(0);
    final borderRadiusAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    )..forward();
    final iconList = [
      Icons.home,
      Icons.bar_chart,
    ];

    return Scaffold(
      extendBody: true,
      body: _tabContent(index: tabIndex.value),
      floatingActionButton: _buildFloatingActionButton(
        tabIndex.value,
        viewModel.navigateToAdd,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(
        tabIndex,
        borderRadiusAnimationController,
        iconList,
      ),
    );
  }

  Widget _tabContent({required int index}) {
    switch (index) {
      case 0:
        return const HomeTabScreen();
      case 1:
        return const StatsTabScreen();
      default:
        return Container();
    }
  }

  FloatingActionButton? _buildFloatingActionButton(
    int tabIndex,
    VoidCallback onPressed,
  ) {
    if (tabIndex != 1) {
      return FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.add),
      );
    }
    return null;
  }

  AnimatedBottomNavigationBar _buildBottomNavigationBar(
    ValueNotifier<int> tabIndex,
    AnimationController borderRadiusAnimationController,
    List<IconData> iconList,
  ) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? Colors.white : Colors.grey;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconList[index], size: 24, color: color),
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
    );
  }
}
