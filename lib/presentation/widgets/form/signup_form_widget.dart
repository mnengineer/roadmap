import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/core/utils/helper/validations.dart';

class SignUpFormWidget extends HookConsumerWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(signUpViewModelProvider.notifier);
    final state = ref.watch(signUpViewModelProvider);

    return Container(
      padding:
          const EdgeInsets.only(top: tFormHeight - 15, bottom: tFormHeight),
      child: Form(
        key: viewModel.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: state.fullName,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name cannot be empty';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text(tFullName),
                prefixIcon: Icon(LineAwesomeIcons.user),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: state.email,
              validator: validateEmail,
              decoration: const InputDecoration(
                label: Text(tEmail),
                prefixIcon: Icon(LineAwesomeIcons.envelope),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: state.phoneNo,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Phone number cannot be empty';
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text(tPhoneNo),
                prefixIcon: Icon(LineAwesomeIcons.phone),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: state.password,
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
                : ElevatedButton(
                    onPressed: state.isFacebookLoading ||
                            state.isGoogleLoading ||
                            state.isLoading
                        ? null
                        : viewModel.createUser,
                    child: const Text(tSignup),
                  ),
          ],
        ),
      ),
    );
  }
}
