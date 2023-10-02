import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/constants/image_strings.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/core/di/providers.dart';

class WelcomeScreen extends HookConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(welcomeViewModelProvider.notifier);
    final state = ref.watch(welcomeViewModelProvider);
    final animate = state.animate;

    useEffect(
      () {
        viewModel.animationIn();
        return null;
      },
      const [],
    );

    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1200),
            top: animate ? 0 : 0,
            left: animate ? 0 : 0,
            right: animate ? 0 : 0,
            bottom: animate ? 0 : -100,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
              child: Container(
                padding: const EdgeInsets.all(tDefaultSpace),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: 'welcome-image-tag',
                      child: Image(
                        image: const AssetImage(tWelcomeScreenImage),
                        width: width * 0.7,
                        height: height * 0.6,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          tWelcomeTitle,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          tWelcomeSubTitle,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: viewModel.navigateToLogin,
                            child: Text(tLogin.toUpperCase()),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: viewModel.navigateToSignup,
                            child: Text(tSignup.toUpperCase()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
