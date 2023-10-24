import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/core/utils/helper/validations.dart';
import 'package:roadmap/presentation/widgets/buttons/primary_button.dart';

class SignUpFormWidget extends HookConsumerWidget {
  const SignUpFormWidget(this._formKey, {super.key});
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(signUpViewModelProvider.notifier);
    final state = ref.watch(signUpViewModelProvider);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Container(
      padding:
          const EdgeInsets.only(top: tFormHeight - 15, bottom: tFormHeight),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              validator: validateEmail,
              decoration: const InputDecoration(
                label: Text(tEmail),
                prefixIcon: Icon(LineAwesomeIcons.envelope),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: passwordController,
              validator: validatePassword,
              obscureText: !state.showPassword,
              decoration: InputDecoration(
                label: const Text(tPassword),
                prefixIcon: const Icon(Icons.fingerprint),
                suffixIcon: IconButton(
                  icon: state.showPassword
                      ? const Icon(LineAwesomeIcons.eye)
                      : const Icon(LineAwesomeIcons.eye_slash),
                  onPressed: viewModel.toggleShowPassword,
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            state.isLoading
                ? const CircularProgressIndicator()
                : TPrimaryButton(
                    isLoading: state.isLoading,
                    text: tSignup,
                    onPressed: state.isGoogleLoading ||
                            state.isFacebookLoading ||
                            state.isLoading
                        ? () {}
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await viewModel.signUp(
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                  ),
          ],
        ),
      ),
    );
  }
}
