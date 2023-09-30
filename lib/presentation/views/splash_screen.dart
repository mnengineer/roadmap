import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/constants/image_strings.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/core/di/providers.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(splashViewModelProvider.notifier);
    final state = ref.watch(splashViewModelProvider);
    final animate = state.animate;

    useEffect(
      () {
        viewModel.startAnimation();
        return null;
      },
      const [],
    );

    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1200),
            top: animate ? 0 : -30,
            left: animate ? 0 : -30,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1200),
              opacity: animate ? 1 : 0,
              child: const Image(
                image: AssetImage(tSplashTopIcon),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: animate ? 100 : 100,
            left: animate ? tDefaultSpace : -100,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tAppName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    tAppTagLine,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: animate ? 100 : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
              child: const Image(
                image: AssetImage(tSplashImage),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: animate ? 60 : 0,
            right: animate ? tDefaultSpace : tDefaultSpace,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
              child: Container(
                width: tSplashContainerSize,
                height: tSplashContainerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: tPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
