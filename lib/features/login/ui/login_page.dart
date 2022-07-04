import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/forgot_password/ui/forgot_password_page.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/utils/validator.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:redux/redux.dart';

import '../actions.dart';
import '../dtos.dart';
import '../view_models/login_view_model.dart';
import 'login_form_view.dart';
import 'signup_page.dart';
import 'widgets/login_buttons.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/loginPage';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailTextContoller = TextEditingController();
  final TextEditingController _passwordTextContoller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Store<AppState> get store => StoreProvider.of(context);

  @override
  void dispose() {
    _emailTextContoller.dispose();
    _passwordTextContoller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginPageViewModel>(
      converter: (store) => LoginPageViewModel(store.state.loginState),
      builder: _build,
    );
  }

  Widget _build(BuildContext context, LoginPageViewModel viewModel) {
    final formView = LoginFormView(
      formKey: _formKey,
      emailTextContoller: _emailTextContoller,
      passwordTextContoller: _passwordTextContoller,
      loading: viewModel.status.isLoading,
    );

    final loginButton = LoginButton(
      loading: viewModel.status.isLoading,
      onTap: () {
        if (!viewModel.status.isLoading) {
          var validated = Validator.formValidated(_formKey);
          if (validated) {
            store.dispatch(Login(
                email: _emailTextContoller.text,
                password: _passwordTextContoller.text));
          }
        }
      },
    );

    final createAccount = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SignupPage.route);
      },
      child: SizedBox(
        height: 48.0,
        child: Center(
          child: Text(
            'Create an Account',
            style: OhNotesTextStyles.appBarTitle.copyWith(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );

    final forgotPassword = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ForgotPasswordPage.route);
      },
      child: SizedBox(
        height: 48.0,
        child: Center(
          child: Text(
            'Forgot Password?',
            style: OhNotesTextStyles.appBarTitle.copyWith(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );

    final googleButton = GoogleButton(
      onTap: () {
        if (!viewModel.status.isLoading) {
          store.dispatch(LoginUsingGoogle());
        }
      },
      isLoading: viewModel.status.isLoading,
    );

    final body = Center(
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
            loginButton,
            Visibility(
              visible: viewModel.exception != null,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  viewModel.error.contains('ERROR_NETWORK')
                      ? "Can't connect to server. Check connection."
                      : 'Invalid Email or Password.',
                  style: OhNotesTextStyles.notePreviewBody.copyWith(
                    color: OhNotesColor.errorText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48.0),
            createAccount,
            const SizedBox(height: 48.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.white,
                thickness: 2,
              ),
            ),
            const SizedBox(height: 10),
            googleButton,
            const SizedBox(height: 20),
            forgotPassword,
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
  }
}
