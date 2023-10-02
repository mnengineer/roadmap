import 'package:flutter/material.dart';
import 'package:roadmap/core/constants/image_strings.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/presentation/widgets/form/form_divider_widget.dart';
import 'package:roadmap/presentation/widgets/form/form_header_widget.dart';
import 'package:roadmap/presentation/widgets/form/login_form_widget.dart';
import 'package:roadmap/presentation/widgets/form/social_footer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tLoginTitle,
                  subTitle: tLoginSubTitle,
                ),
                const LoginFormWidget(),
                const TFormDividerWidget(),
                SocialFooter(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
