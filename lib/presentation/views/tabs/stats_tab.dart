import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.white,
      child: Center(
        child: RiveAnimation.asset(
          'assets/rive/404.riv',
        ),
      ),
    );
  }
}
