import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends HookConsumerWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(onboardingViewModelProvider.notifier);
    final state = ref.watch(onboardingViewModelProvider);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: viewModel.pages,
            enableSideReveal: true,
            enableLoop: false,
            liquidController: viewModel.controller,
            onPageChangeCallback: viewModel.onPageChangedCallback,
            waveType: WaveType.circularReveal,
          ),
          Positioned(
            bottom: 60,
            child: OutlinedButton(
              onPressed: viewModel.animateToNextSlide,
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: tDarkColor),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                foregroundColor: tWhiteColor,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: tDarkColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: state < 2
                ? TextButton(
                    onPressed: viewModel.skip,
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              count: 3,
              activeIndex: state,
              effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xff272727),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
