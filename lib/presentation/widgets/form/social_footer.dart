import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/constants/colors.dart';
import 'package:roadmap/core/constants/image_strings.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/presentation/widgets/buttons/clickable_richtext_widget.dart';
import 'package:roadmap/presentation/widgets/buttons/social_button.dart';

class SocialFooter extends HookConsumerWidget {
  const SocialFooter({
    super.key,
    this.text1 = tDontHaveAnAccount,
    this.text2 = tSignup,
    required this.onPressed,
  });

  final String text1;
  final String text2;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider.notifier);
    final state = ref.watch(loginViewModelProvider);

    return Container(
      padding: const EdgeInsets.only(
        top: tDefaultSpace * 1.5,
        bottom: tDefaultSpace,
      ),
      child: Column(
        children: [
          TSocialButton(
            image: tGoogleLogo,
            background: tGoogleBgColor,
            foreground: tGoogleForegroundColor,
            text: tConnectWith + tGoogle,
            // isLoading: state is AsyncLoading,
            onPressed: state is AsyncLoading || state.isLoading
                ? () {}
                : state is AsyncLoading
                    ? () {}
                    : viewModel.googleSignIn,
          ),
          const SizedBox(height: 10),
          TSocialButton(
            image: tFacebookLogo,
            foreground: tWhiteColor,
            background: tFacebookBgColor,
            text: tConnectWith + tFacebook,
            // isLoading: state is AsyncLoading,
            onPressed: state is AsyncLoading || state.isLoading
                ? () {}
                : state is AsyncLoading
                    ? () {}
                    : viewModel.facebookSignIn,
          ),
          const SizedBox(height: tDefaultSpace * 2),
          ClickableRichTextWidget(
            text1: text1,
            text2: text2,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
