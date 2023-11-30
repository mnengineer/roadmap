import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/constants/image_strings.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/presentation/widgets/forms/form_divider_widget.dart';
import 'package:roadmap/presentation/widgets/forms/form_header_widget.dart';
import 'package:roadmap/presentation/widgets/forms/login_form_widget.dart';
import 'package:roadmap/presentation/widgets/forms/social_footer.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider.notifier);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFE400),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormHeaderWidget(
                  image: tLoginScreenImage,
                  title: tLoginTitle,
                  subTitle: tLoginSubTitle,
                ),
                LoginFormWidget(formKey),
                const TFormDividerWidget(),
                SocialFooter(
                  onPressed: viewModel.navigateToSignup,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
