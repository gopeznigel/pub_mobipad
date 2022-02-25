import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/features/forgot_password/actions.dart';
import 'package:mobipad/features/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:mobipad/features/login/ui/widgets/login_text_fields.dart';
import 'package:mobipad/utils/validator.dart';
import 'package:redux/redux.dart';

import '../../../state.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String route = '/resetPasswordPage';
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool sent = false;

  Store<AppState> get store => StoreProvider.of(context);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) =>
            ForgotPasswordPageViewModel(store.state.forgotPasswordState),
        builder: _buildPage,
      );

  Widget _buildPage(
      BuildContext context, ForgotPasswordPageViewModel viewModel) {
    final sending = viewModel.isSending;

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 200.h),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 45.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    EmailTextField(
                      enabled: !sending,
                      controller: _emailController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                height: 120.h,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: !sending
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                  ),
                  onPressed: () {
                    var validated = Validator.formValidated(_formKey);
                    if (validated) {
                      store.dispatch(
                          SendResetPasswordLink(_emailController.text));
                      setState(() {
                        sent = true;
                      });
                    }
                  },
                  child: !sending
                      ? Text(
                          'Send Reset Password Link',
                          style: TextStyle(
                              fontSize: 45.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Visibility(
                visible: !sending && sent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Center(
                    child: Text(
                      'Password reset link was sent on the email provided.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
