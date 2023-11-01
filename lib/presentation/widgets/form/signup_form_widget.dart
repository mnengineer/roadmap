import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:roadmap/core/constants/sizes.dart';
import 'package:roadmap/core/constants/text_strings.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/core/utils/helper/validations.dart';
import 'package:roadmap/presentation/widgets/button/primary_button.dart';
import 'package:roadmap/presentation/widgets/dialog/error_dialog.dart';
import 'package:roadmap/presentation/widgets/snackbar/snackbar.dart';

class SignUpFormWidget extends HookConsumerWidget {
  const SignUpFormWidget(this._formKey, {super.key});
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(signUpViewModelProvider.notifier);
    final state = ref.watch(signUpViewModelProvider);

    final snackbar = ref.read(snackbarProvider);
    final errorDialog = ref.read(errorDialogProvider);

    final isObscure = useState(true);
    final authenticationAttempt = useState(false);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    void toggleShowPassword() {
      isObscure.value = !isObscure.value;
    }

    useEffect(
      () {
        if (authenticationAttempt.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.when(
              data: (_) {
                snackbar.successSnackBar(
                  context,
                  title: 'Sginup Success',
                );
                viewModel.navigateToHome();
              },
              loading: () {},
              error: (error, stackTrace) {
                errorDialog.showErrorDialog(
                  context,
                  title: 'Sginup Error',
                  message: error.toString(),
                );
              },
            );
          });
        }
        return null;
      },
      [state],
    );

    return Container(
      padding:
          const EdgeInsets.only(top: tFormHeight - 15, bottom: tFormHeight),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -- Email Field
            TextFormField(
              controller: emailController,
              validator: validateEmail,
              decoration: const InputDecoration(
                label: Text(tEmail),
                prefixIcon: Icon(LineAwesomeIcons.envelope),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),

            /// -- Password Field
            TextFormField(
              controller: passwordController,
              validator: validatePassword,
              obscureText: isObscure.value,
              decoration: InputDecoration(
                label: const Text(tPassword),
                prefixIcon: const Icon(Icons.fingerprint),
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

            /// -- SIGNUP BTN
            TPrimaryButton(
              isLoading: state is AsyncLoading,
              text: tSignup,
              onPressed: state is AsyncLoading
                  ? () {}
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        authenticationAttempt.value = true;
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
