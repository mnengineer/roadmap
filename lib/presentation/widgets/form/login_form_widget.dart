import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/core/utils/helper/validations.dart';
import 'package:roadmap/presentation/widgets/buttons/primary_button.dart';
import 'package:roadmap/presentation/widgets/dialog/error_dialog.dart';
import 'package:roadmap/presentation/widgets/snackbar/snackbar.dart';

class LoginFormWidget extends HookConsumerWidget {
  const LoginFormWidget(this._formKey, {super.key});
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModelProvider.notifier);
    final state = ref.watch(loginViewModelProvider);
    final errorDialog = ref.read(errorDialogProvider);
    final snackbar = ref.read(snackbarProvider);

    final isObscure = useState(true);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    void toggleShowPassword() {
      isObscure.value = !isObscure.value;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -- Email Field
            TextFormField(
              validator: validateEmail,
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(LineAwesomeIcons.user),
                labelText: tEmail,
                hintText: tEmail,
              ),
            ),
            const SizedBox(height: tFormHeight - 20),

            /// -- Password Field
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your password';
                }
                return null;
              },
              obscureText: isObscure.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure.value
                        ? LineAwesomeIcons.eye_slash
                        : LineAwesomeIcons.eye,
                  ),
                  onPressed: toggleShowPassword,
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),

            /// -- FORGET PASSWORD BTN
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: viewModel.navigateToSignup,
                child: const Text(tForgetPassword),
              ),
            ),

            /// -- LOGIN BTN
            TPrimaryButton(
              isLoading: state is AsyncLoading,
              text: tLogin,
              onPressed: state is AsyncLoading
                  ? () {}
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        await viewModel.login(
                          emailController.text,
                          passwordController.text,
                        );
                        state.when(
                          data: (_) {
                            snackbar.successSnackBar(
                              context,
                              title: 'Success',
                              message: 'The operation was successful.',
                            );
                            viewModel.navigateToHome();
                          },
                          loading: () {},
                          error: (error, stackTrace) {
                            errorDialog.showErrorDialog(
                              context,
                              title: 'Error',
                              message: 'An error occurred.',
                            );
                          },
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
