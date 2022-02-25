import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/features/forgot_password/ui/forgot_password_page.dart';
import 'package:mobipad/features/login/ui/signup_page.dart';
import 'package:mobipad/vars/colors.dart';
import 'package:redux/redux.dart';

import '../../../state.dart';
import '../../../utils/validator.dart';
import '../../login/actions.dart';
import '../../login/ui/login_form_view.dart';
import '../../login/ui/widgets/login_buttons.dart';
import '../../login/view_model/view_model.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ///
  /// Email Text contoller. Use to store password inputs.
  ///
  final _emailTextContoller = TextEditingController();

  ///
  /// Password Text controller. Use to store password inputs.
  ///
  final _passwordTextContoller = TextEditingController();

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

    ///
    /// This is the form view. Container textInputField for email and password
    ///
    final _formView = LoginFormView(
      formKey: _formKey,
      emailTextContoller: _emailTextContoller,
      passwordTextContoller: _passwordTextContoller,
      loading: viewModel.isLoading,
    );

    ///
    /// This is the Login button. Dispatch the Login() action when pressed.
    ///
    final _loginButton = LoginButton(
      loading: !viewModel.googleSignIn ? viewModel.isLoading : false,
      onTap: () {
        if (!viewModel.isLoading) {
          var validated = Validator.formValidated(_formKey);
          if (validated) {
            store.dispatch(
                Login(_emailTextContoller.text, _passwordTextContoller.text));
          }
        }
      },
    );

    ///
    /// This is the create account label.
    /// Opens the SignUp page when pressed.
    ///
    final _createAccount = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SignUpPage.route);
      },
      child: Container(
        height: 48.0,
        child: Center(
          child: Text(
            'Create an Account',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.white,
              fontSize: 40.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );

    ///
    /// This is the forgot password label.
    /// Opens the ForgotPassword page when pressed.
    ///
    final _forgotPassword = GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ForgotPasswordPage.route);
      },
      child: Container(
        height: 48.0,
        child: Center(
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.white,
              fontSize: 40.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );

    ///
    /// This is the google button.
    /// SignIn/Signup using google account
    ///
    final _googleButton = GoogleButton(
      onTap: () {
        if (!viewModel.isLoading) {
          store.dispatch(LoginUsingGoogle());
        }
      },
      isLoading: viewModel.googleSignIn ? viewModel.isLoading : false,
    );

    final _body = Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 100.w, right: 100.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _formView,
            SizedBox(height: 70.h),
            _loginButton,
            Visibility(
              visible: viewModel.exception != null,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  error.contains('ERROR_NETWORK')
                      ? "Can't connect to server. Check connection."
                      : 'Invalid Email or Password.',
                  style: TextStyle(
                    color: OhNotesColor.error_text,
                    fontWeight: FontWeight.w600,
                    fontSize: 35.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 150.h),
            _createAccount,
            SizedBox(height: 150.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Divider(
                color: Colors.white,
                thickness: 2.h,
              ),
            ),
            SizedBox(height: 40.h),
            _googleButton,
             SizedBox(height: 20.h),
            _forgotPassword,
          ],
        ),
      ),
    );

    ///
    /// returns the Scaffold that contains the
    /// login page ui
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
