import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/core/utils/helper/validations.dart';
import 'package:roadmap/presentation/widgets/buttons/primary_button.dart';

class LoginFormWidget extends HookConsumerWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider.notifier);
    final state = ref.watch(loginViewModelProvider);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight),
      child: Form(
        key: state.loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -- Email Field
            TextFormField(
              validator: validateEmail,
              controller: state.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(LineAwesomeIcons.user),
                labelText: tEmail,
                hintText: tEmail,
              ),
            ),
            const SizedBox(height: tFormHeight - 20),

            /// -- Password Field
            TextFormField(
              controller: state.password,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your password';
                }
                return null;
              },
              obscureText: !state.showPassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                suffixIcon: IconButton(
                  icon: state.showPassword
                      ? const Icon(LineAwesomeIcons.eye)
                      : const Icon(LineAwesomeIcons.eye_slash),
                  onPressed: viewModel.toggleShowPassword,
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),

            /// -- FORGET PASSWORD BTN
            const Align(
              alignment: Alignment.centerRight,
              // 追加: ForgetPasswordScreen.buildShowModalBottomSheet(context)
            ),

            /// -- LOGIN BTN
            TPrimaryButton(
              isLoading: state.isLoading,
              text: tLogin,
              onPressed: state.isFacebookLoading || state.isGoogleLoading
                  ? () {}
                  : state.isLoading
                      ? () {}
                      : viewModel.login,
            ),
          ],
        ),
      ),
    );
  }
}
