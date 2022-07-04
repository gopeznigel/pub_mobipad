import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/login/dtos.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/utils/validator.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:redux/redux.dart';

import '../actions.dart';
import '../view_models/login_view_model.dart';
import 'login_page.dart';
import 'signup_form_view.dart';
import 'widgets/login_buttons.dart';

class SignupPage extends StatelessWidget {
  static const String route = '/signupPage';

  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailTextContoller = TextEditingController();
    final passwordTextContoller = TextEditingController();
    final confirmPasswordTextContoller = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Store<AppState> store = StoreProvider.of<AppState>(context);

    return StoreConnector(
      converter: (Store<AppState> store) =>
          LoginPageViewModel(store.state.loginState),
      builder: (BuildContext context, LoginPageViewModel viewModel) {
        final formView = SignupFormView(
          formKey: formKey,
          emailTextContoller: emailTextContoller,
          passwordTextContoller: passwordTextContoller,
          confirmPasswordTextContoller: confirmPasswordTextContoller,
        );

        final signUpButton = LoginButton(
          loading: viewModel.status.isLoading,
          label: 'Create Account',
          onTap: () {
            var validated = Validator.formValidated(formKey);
            if (validated) {
              store.dispatch(SignUp(
                  email: emailTextContoller.text,
                  password: passwordTextContoller.text));
            }
          },
        );

        final loginExistingAccount = GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, LoginPage.route);
          },
          child: Text(
            'Login using Existing Account',
            style: OhNotesTextStyles.appBarTitle.copyWith(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        );

        final body = SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                formView,
                const SizedBox(height: 30),
                signUpButton,
                Visibility(
                  visible: viewModel.exception != null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      viewModel.error.contains('ALREADY_IN_USE')
                          ? 'Email is already in use.'
                          : "Can't connect to server. Check connection.",
                      style: OhNotesTextStyles.notePreviewBody.copyWith(
                        color: OhNotesColor.errorText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 150),
                loginExistingAccount,
              ],
            ),
          ),
        );

        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: body,
            ),
          ),
        );
      },
    );
  }
}
