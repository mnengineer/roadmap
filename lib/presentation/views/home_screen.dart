import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/entities/item.dart';
import 'package:roadmap/presentation/views/mypage_screen.dart';
import 'package:roadmap/presentation/views/tabs/home_tab.dart';
import 'package:roadmap/presentation/views/tabs/stats_tab.dart';
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

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                builder: (context) {
                  final height = MediaQuery.of(context).size.height;
                  final desiredHeight = height * 0.9;
                  return SizedBox(
                    height: desiredHeight,
                    child: const MyPageScreen(),
                  );
                },
              );
            },
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: tabContent(),
      floatingActionButton: tabIndex.value != 1
          ? FloatingActionButton(
              onPressed: () => AddItemDialog.show(context, Item.empty()),
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.blue : Colors.grey;
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
        backgroundColor: Colors.white,
        activeIndex: tabIndex.value,
        splashColor: Colors.blue,
        notchAndCornersAnimation: borderRadiusAnimationController,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => tabIndex.value = index,
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.blue,
        ),
      ),
    );
  }
}
