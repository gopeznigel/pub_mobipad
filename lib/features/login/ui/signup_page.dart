import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/features/login/ui/login_page.dart';
import 'package:mobipad/vars/colors.dart';
import 'package:redux/redux.dart';

import '../../../state.dart';
import '../../../utils/validator.dart';
import '../actions.dart';
import '../ui/signup_form_view.dart';
import '../ui/widgets/login_buttons.dart';
import '../view_model/view_model.dart';

class SignUpPage extends StatefulWidget {
  static const String route = '/signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ///
  /// Email Text contoller. Use to store password inputs.
  ///
  final _emailTextContoller = TextEditingController();

  ///
  /// Password Text controller. Use to store password inputs.
  ///
  final _passwordTextContoller = TextEditingController();

  ///
  /// Confirm Password Text controller. Use to store password inputs.
  ///
  final _confirmPasswordTextContoller = TextEditingController();

  ///
  /// Form key. Used for validating email and password inputs.
  ///
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///
  /// The store. This contains the state of the app.
  ///
  Store<AppState> get store => StoreProvider.of(context);

  @override
  void dispose() {
    _emailTextContoller.dispose();
    _passwordTextContoller.dispose();
    _confirmPasswordTextContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) =>
            LoginPageViewModel(store.state.loginState),
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, LoginPageViewModel viewModel) {
    final error = viewModel.exception?.exception?.toString() ?? '';

    final _formView = SignupFormView(
      formKey: _formKey,
      emailTextContoller: _emailTextContoller,
      passwordTextContoller: _passwordTextContoller,
      confirmPasswordTextContoller: _confirmPasswordTextContoller,
    );

    ///
    /// This is the Login button. Dispatch the Login() action when pressed.
    ///
    final _signUpButton = LoginButton(
      loading: viewModel.isLoading,
      label: 'Create Account',
      onTap: () {
        var validated = Validator.formValidated(_formKey);
        if (validated) {
          store.dispatch(
              SignUp(_emailTextContoller.text, _passwordTextContoller.text));
        }
      },
    );

    ///
    /// This is the login using existing account label.
    /// Opens the Login page when pressed.
    ///
    final _loginExistingAccount = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, LoginPage.route);
      },
      child: Text(
        'Login using Existing Account',
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.white,
          fontSize: 40.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    final _body = SingleChildScrollView(
      child: Container(
        height: 1800.h,
        padding: EdgeInsets.symmetric(horizontal: 100.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _formView,
            SizedBox(height: 70.h),
            _signUpButton,
            Visibility(
              visible: viewModel.exception != null,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  error.contains('ALREADY_IN_USE')
                      ? 'Email is already in use.'
                      : "Can't connect to server. Check connection.",
                  style: TextStyle(
                    color: OhNotesColor.error_text,
                    fontWeight: FontWeight.w600,
                    fontSize: 35.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 150.h),
            _loginExistingAccount,
          ],
        ),
      ),
    );

    ///
    /// returns the Scaffold that contains the
    /// signup page ui
    ///
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: _body,
        ),
      ),
    );
  }
}
